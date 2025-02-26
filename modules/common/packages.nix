# List packages installed in system profile
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Editors
    vim
    neovim

    # VCS
    git
    diff-so-fancy # git diff formatter
    gh # github cli
    dvc # data version control for ML

    # CLI
    curl
    wget
    watch # watch a command and refresh the output after a certain interval
    rsync # file transfer to or from a remote host (but not between two remote hosts)
    tree # directory tree viewer
    tldr # simplified man pages
    tmux # terminal multiplexer
    bat # cat replacement
    dua # du replacement
    duf # df replacement
    jq # json processor
    yq # yaml processor
    zoxide # cd replacement
    eza # ls replacement
    scc # code counter with complexity calculations and COCOMO estimates
    fzf # fuzzy finder
    graphviz # graph visualization software
    cwebp # webp image converter
    tex-fmt # latex formatter

    # Monitoring
    neofetch # system information viewer
    htop # process viewer (replacement for top)
    btop # process viewer (replacement for htop)
    ctop # container viewer
    lazydocker # docker container manager
    glances # system monitoring

    # Networking
    speedtest-cli # internet speed test
    bandwhich # network bandwidth monitor
    doggo # dns lookup tool (replacement for dig)
    gping # ping replacement
    tailscale # networking tool
    ngrok # tunneling tool
    wireshark # network analyzer and capture tool
    nmap # network auditing

    # Media
    ffmpeg # audio/video converter (e.g. convert wav to mp3)
    yt-dlp # audio/video downloader for youtube and other sites

    # Nix-related packages
    nil
    nixpkgs-fmt
  ];
}
