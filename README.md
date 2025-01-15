# dotfiles

Install Nix with Determinate Nix Installer and restart the shell:

```
make install-nix
```

Apply nix darwin configuration on the selected mackbook:








Install the configuration:

nix run nix-darwin -- switch --flake .#khaykingleb-macbook

Apply new configuration:

darwin-rebuild switch --flake .#khaykingleb-macbook

nix run nix-darwin -- switch --flake ~/.config/nix-darwin

darwin-rebuild switch --flake .#khaykingleb-mac

```
$ sh <(curl -L https://nixos.org/nix/install)

```

Install Nix-darwin from https://github.com/LnL7/nix-darwin.

Install Home-manager:

Download configuration:
nix-shell -p git --run 'git clone https://github.com/khaykingleb/dotfiles.git ~/.dotfiles'

Install the configuration:

nix run nix-darwin -- switch --flake ~/.dotfiles/#khaykingleb-mac

or

nix run nix-darwin -- switch --flake .#khaykingleb-mac

Apply configuration:
darwin-rebuild switch --flake.#khaykingleb-mac

Download configuration:
nix-shell -p git --run 'git clone https://github.com/elliottminns/dotfiles.git .dotfiles'

Install it:

nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake /dotf
iles/nix/darwin\#tsukyyomi

neofetch
