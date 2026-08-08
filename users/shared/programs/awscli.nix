{ lib, ... }:
{
  programs.zsh.initContent = lib.mkAfter ''
    # >>> AWS
    export AWS_SDK_LOAD_CONFIG=1

    # Select a profile and authenticate only when cached credentials are unavailable.
    aws-profile() {
      if (( $# != 1 )); then
        echo "usage: aws-profile <profile>" >&2
        return 2
      fi

      local profile="$1"
      if ! aws configure export-credentials \
        --profile "$profile" \
        --format process >/dev/null 2>&1; then
        aws sso login --profile "$profile" || return
      fi

      export AWS_PROFILE="$profile"
    }

    _aws-profile() {
      local -a profiles
      profiles=($(aws configure list-profiles 2>/dev/null))
      _describe "AWS profile" profiles
    }
    compdef _aws-profile aws-profile
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
