# Claude Code global configuration
{ ... }:
{
  home.file = {
    ".claude/rules/code-style.md".source = ./claude/rules/code-style.md;
    ".claude/rules/decision-approval.md".source = ./claude/rules/decision-approval.md;
    ".claude/rules/dotfiles.md".source = ./claude/rules/dotfiles.md;
    ".claude/rules/git.md".source = ./claude/rules/git.md;
    ".claude/rules/go.md".source = ./claude/rules/go.md;
    ".claude/rules/kubernetes.md".source = ./claude/rules/kubernetes.md;
    ".claude/rules/python.md".source = ./claude/rules/python.md;
    ".claude/rules/rust.md".source = ./claude/rules/rust.md;
    ".claude/skills/code-review/SKILL.md".source = ./claude/skills/code-review/SKILL.md;
    ".claude/skills/linear-ticket-writing/SKILL.md".source =
      ./claude/skills/linear-ticket-writing/SKILL.md;
    ".claude/skills/pr-description/SKILL.md".source = ./claude/skills/pr-description/SKILL.md;
  };

  home.activation.claudeMcpServers = ''
    if command -v claude >/dev/null 2>&1; then
      if ! claude mcp list 2>/dev/null | grep -q '^linear:'; then
        claude mcp add --transport http --scope user linear https://mcp.linear.app/mcp >/dev/null || true
      fi
      if ! claude mcp list 2>/dev/null | grep -q '^github:'; then
        claude mcp add-json --scope user github '{"type":"http","url":"https://api.githubcopilot.com/mcp/","headers":{"Authorization":"Bearer ''${GITHUB_PERSONAL_ACCESS_TOKEN}"}}' >/dev/null || true
      fi
      if ! claude mcp list 2>/dev/null | grep -q '^notion:'; then
        claude mcp add --transport http --scope user notion https://mcp.notion.com/mcp >/dev/null || true
      fi
    fi
  '';
}
