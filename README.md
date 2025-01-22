# dotfiles

Clone repo and set up config directory:

```shell
git clone https://github.com/khaykingleb/dotfiles.git \
    && mkdir -p ~/.config \
    && mv dotfiles ~/.config/dotfiles
```

Install Nix with Determinate Nix Installer and restart the shell:

```shell
make install-nix
```

Apply the nix-darwin configuration:

```shell
make apply-darwin-macbook
```
