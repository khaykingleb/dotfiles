# List packages installed in system profile
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Editors
    vim
    neovim

    # Development and VCS
    act # run github actions locally
    dvc # data version control for ML
    scc # code counter with complexity calculations and COCOMO estimates
    devcontainer # devcontainer cli

    # Shell and filesystem
    watch # watch a command and refresh the output after a certain interval
    rsync # file transfer to or from a remote host (but not between two remote hosts)
    tree # directory tree viewer
    tldr # simplified man pages
    moreutils # collection of tools
    bat # cat replacement
    dua # du replacement
    duf # df replacement
    fd # find files and directories
    zoxide # cd replacement
    eza # ls replacement
    fzf # fuzzy finder

    # Data processing
    jq # json processor
    yq # yaml processor
    ripgrep # recursively search file contents

    # API and networking
    curl
    wget
    grpc-health-probe
    grpcui
    grpcurl
    speedtest-cli # measure download/upload speed and latency to nearby servers
    bandwhich # show per-process and per-connection bandwidth usage in real time
    doggo # modern DNS client: queries A/AAAA/MX/etc records (dig replacement)
    gping # graph ping latency over time in the terminal
    tailscale # WireGuard-based mesh VPN for connecting devices across networks
    ngrok # expose local servers to the internet through secure tunnels
    wireshark # deep packet inspection for capturing and analyzing network traffic
    nmap # port scanner and service/OS fingerprinting for network auditing
    mtr # combine traceroute and ping to show per-hop latency and packet loss

    # System inspection and monitoring
    unixtools.ps # list process status with macOS/BSD-compatible options
    lsof # list open files and processes
    fastfetch # system information viewer (neofetch successor)
    htop # process viewer (replacement for top)
    btop # process viewer (replacement for htop)
    glances # system monitoring

    # Containers and security
    ctop # container viewer
    lazydocker # docker container manager
    trivy # scan container images, filesystems, and IaC for vulnerabilities

    # Documentation and media
    graphviz # graph visualization software
    plantuml # plantuml diagram generator
    tex-fmt # latex formatter
    ffmpeg # audio/video converter (e.g. convert wav to mp3)
    yt-dlp # audio/video downloader for youtube and other sites
    libwebp # webp image converter (includes cwebp)
    imagemagick # image processing tool

    # Kubernetes and virtualization
    clusterctl # cluster API CLI for managing Kubernetes clusters
    kubecm # manage and switch between multiple kubeconfigs

    # Language servers
    just-lsp
    nixd

    # Nix tooling
    nixfmt
  ];
}
