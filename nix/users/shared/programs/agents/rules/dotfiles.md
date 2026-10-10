# Dotfiles

- Store durable personal preferences, Cursor rules, Cursor skills, and Claude instructions in `/Users/gkhaykin/.config/dotfiles`.
- Do not write directly to `~/.cursor` or `~/.claude` for persistent preferences unless the user says it is temporary.
- When adding Cursor or Claude config, update the matching dotfiles Nix mapping so it is managed by Home Manager.
- The dotfiles repository is public. Put anything the user would not publish, such as work hosts, internal URLs, or account details, in `/Users/gkhaykin/.config/dotfiles-private`.
