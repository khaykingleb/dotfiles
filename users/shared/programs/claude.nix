# Claude Code global configuration
{ ... }:
{
  home.file = {
    ".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
    ".claude/skills/linear-ticket-writing/SKILL.md".source = ./claude/skills/linear-ticket-writing/SKILL.md;
    ".claude/skills/pr-description/SKILL.md".source = ./claude/skills/pr-description/SKILL.md;
  };

  home.activation.claudeLinearMcp = ''
    if command -v claude >/dev/null 2>&1; then
      if ! claude mcp list 2>/dev/null | grep -q '^linear:'; then
        claude mcp add --transport http --scope user linear https://mcp.linear.app/mcp >/dev/null || true
      fi
    fi
  '';
}
