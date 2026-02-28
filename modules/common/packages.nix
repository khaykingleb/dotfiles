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
    act # run github actions locally
    dvc # data version control for ML

    # CLI
    curl
    wget
    watch # watch a command and refresh the output after a certain interval
    rsync # file transfer to or from a remote host (but not between two remote hosts)
    tree # directory tree viewer
    tldr # simplified man pages
    tmux # terminal multiplexer
    moreutils # collection of tools
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
    plantuml # plantuml diagram generator
    tex-fmt # latex formatter
    devcontainer # devcontainer cli

    # Monitoring
    fastfetch # system information viewer (neofetch successor)
    htop # process viewer (replacement for top)
    btop # process viewer (replacement for htop)
    ctop # container viewer
    lazydocker # docker container manager
    glances # system monitoring

    # Networking
    speedtest-cli # measure download/upload speed and latency to nearby servers
    bandwhich # show per-process and per-connection bandwidth usage in real time
    doggo # modern DNS client: queries A/AAAA/MX/etc records (dig replacement)
    gping # graph ping latency over time in the terminal
    tailscale # WireGuard-based mesh VPN for connecting devices across networks
    ngrok # expose local servers to the internet through secure tunnels
    wireshark # deep packet inspection for capturing and analyzing network traffic
    nmap # port scanner and service/OS fingerprinting for network auditing
    mtr # combine traceroute and ping to show per-hop latency and packet loss
    lsof # list open files and processes

    # Media
    ffmpeg # audio/video converter (e.g. convert wav to mp3)
    yt-dlp # audio/video downloader for youtube and other sites
    libwebp # webp image converter (includes cwebp)
    imagemagick # image processing tool

    # Kubernetes and virtualization
    clusterctl # cluster API CLI for managing Kubernetes clusters
    kubecm # manage and switch between multiple kubeconfigs

    # Nix-related packages
    nil
    nixpkgs-fmt
  ];
}
