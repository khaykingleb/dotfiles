{ ... }:
{
  programs.zsh.initContent = ''
    # >>> AWS
    export AWS_SDK_LOAD_CONFIG=1
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
