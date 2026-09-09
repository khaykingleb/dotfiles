{ lib, pkgs, ... }:
{
  home.packages = [ pkgs.ssm-session-manager-plugin ];

  programs.zsh.initContent = lib.mkAfter ''
    # >>> AWS
    export AWS_SDK_LOAD_CONFIG=1

    # Select a profile and authenticate only when cached credentials are unavailable.
    aws-profile() {
      if (( $# != 1 )); then
        print -u2 "usage: aws-profile <profile>"
        return 2
      fi

      local profile="$1"
      if ! aws configure export-credentials \
        --profile "$profile" \
        --format process >/dev/null 2>&1; then
        aws sso login --profile "$profile" || return
      fi

      export AWS_PROFILE="$profile"
      aws-ecr-login "$profile"
    }

    # Refresh Docker's ECR credentials for an explicit or active AWS profile.
    aws-ecr-login() {
      if (( $# > 1 )); then
        print -u2 "usage: aws-ecr-login [profile]"
        return 2
      fi

      local profile="''${1:-''${AWS_PROFILE:-}}"
      if [[ -z "$profile" ]]; then
        print -u2 "usage: aws-ecr-login [profile]"
        return 2
      fi

      command -v docker >/dev/null 2>&1 || return 0

      local region account registry ecr_password
      region=$(aws configure get region --profile "$profile" 2>/dev/null)
      if [[ -z "$region" ]]; then
        region=$(aws configure get region --profile default 2>/dev/null)
      fi
      if [[ -z "$region" ]]; then
        print -u2 "warning: no AWS region configured; skipping ECR login"
        return 0
      fi

      if ! account=$(aws sts get-caller-identity \
        --profile "$profile" \
        --query Account \
        --output text); then
        print -u2 "warning: unable to determine the AWS account; skipping ECR login"
        return 0
      fi

      registry="$account.dkr.ecr.$region.amazonaws.com"
      if ! ecr_password=$(aws ecr get-login-password \
        --profile "$profile" \
        --region "$region"); then
        print -u2 "warning: unable to obtain ECR credentials for $registry"
        return 0
      fi

      if ! print -rn -- "$ecr_password" |
        docker login --username AWS --password-stdin "$registry" >/dev/null; then
        print -u2 "warning: unable to log Docker into $registry"
      fi
    }

    _aws-profile() {
      local -a profiles
      profiles=($(aws configure list-profiles 2>/dev/null))
      _describe "AWS profile" profiles
    }
    compdef _aws-profile aws-profile aws-ecr-login
    # <<< AWS
  '';

  programs.awscli = {
    enable = true;
    settings.default = {
      region = "us-west-2";
      output = "json";
    };
  };
}
