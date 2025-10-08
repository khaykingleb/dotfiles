{ ... }: {
  programs.zsh = {
    initContent = ''
      # >>> AWS
      export AWS_SDK_LOAD_CONFIG=1
      # <<< AWS
    '';
  };
  programs.awscli = {
    enable = true;
    settings = {
      default = {
        region = "us-west-2";
        output = "json";
      };
      "sso-session together" = {
        sso_start_url = "https://together-aws-portal.awsapps.com/start";
        sso_region = "us-west-2";
      };
      "profile together-prod" = {
        sso_session = "together";
        sso_account_id = "598726163780";
        sso_role_name = "PowerUserAccess";
      };
      "profile together-qa" = {
        sso_session = "together";
        sso_account_id = "905418226616";
        sso_role_name = "PowerUserAccess";
      };
      "profile together-research" = {
        sso_session = "together";
        sso_account_id = "805380815601";
        sso_role_name = "PowerUserAccess";
      };
      "profile together-dev" = {
        sso_session = "together";
        sso_account_id = "997151384078";
        sso_role_name = "PowerUserAccess";
      };
    };
  };
}
