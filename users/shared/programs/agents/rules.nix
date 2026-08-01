{ lib, pkgs, ... }:
let
  # Absence of `filePatterns` in a rule means it always loads when the agent is active.
  rules = {
    code-style = {
      description = "Core coding standards";
    };
    decision-approval = {
      description = "Require approval for meaningful implementation decisions";
    };
    dotfiles = {
      description = "Personal preference and agent configuration storage";
    };
    git = {
      description = "Git conventions";
    };
    kubernetes = {
      description = "Kubernetes command conventions";
    };

    go = {
      description = "Go conventions";
      filePatterns = [ "**/*.go" ];
    };
    python = {
      description = "Python conventions";
      filePatterns = [
        "**/*.py"
        "**/pyproject.toml"
        "**/uv.lock"
      ];
    };
    rust = {
      description = "Rust conventions";
      filePatterns = [ "**/*.rs" ];
    };
  };

  readRuleContent = name: builtins.readFile ./rules/${name}.md;

  /**
    Wraps YAML field lines in Markdown frontmatter followed by a blank line.

    # Type

    ```
    mkMarkdownFrontmatter :: [String] -> String
    ```
  */
  mkMarkdownFrontmatter = fields: ''
    ---
    ${lib.concatStringsSep "\n" fields}
    ---

  '';

  /**
    Translates shared file patterns into Claude's `paths` frontmatter.
    Returns an empty string for rules that always load.

    # Type

    ```
    mkClaudeMarkdownFrontmatter :: AttrSet -> String
    ```
  */
  mkClaudeMarkdownFrontmatter =
    rule:
    lib.optionalString (rule ? filePatterns) (
      mkMarkdownFrontmatter ([ "paths:" ] ++ map (pattern: "  - \"${pattern}\"") rule.filePatterns)
    );

  /**
    Translates shared rule metadata into Cursor's rule frontmatter.

    # Type

    ```
    mkCursorMarkdownFrontmatter :: AttrSet -> String
    ```
  */
  mkCursorMarkdownFrontmatter =
    rule:
    mkMarkdownFrontmatter (
      [ "description: ${rule.description}" ]
      ++ lib.optional (rule ? filePatterns) "globs: ${lib.concatStringsSep "," rule.filePatterns}"
      ++ [ "alwaysApply: ${lib.boolToString (!(rule ? filePatterns))}" ]
    );

  /**
    Creates a Claude rule file.

    # Type

    ```
    mkClaudeRule :: String -> AttrSet -> Path
    ```
  */
  mkClaudeRule =
    name: rule: pkgs.writeText "${name}.md" (mkClaudeMarkdownFrontmatter rule + readRuleContent name);

  /**
    Creates a Cursor rule file.

    # Type

    ```
    mkCursorRule :: String -> AttrSet -> Path
    ```
  */
  mkCursorRule =
    name: rule: pkgs.writeText "${name}.mdc" (mkCursorMarkdownFrontmatter rule + readRuleContent name);

  /**
    Creates `home.file` entries for every rule using a tool-specific generator.

    # Type

    ```
    mkHomeRuleFiles :: String -> String -> (String -> AttrSet -> Path) -> AttrSet
    ```
  */
  mkHomeRuleFiles =
    directory: extension: mkRule:
    lib.mapAttrs' (
      name: rule: lib.nameValuePair "${directory}/${name}.${extension}" { source = mkRule name rule; }
    ) rules;
in
{
  home.file =
    mkHomeRuleFiles ".claude/rules" "md" mkClaudeRule
    // mkHomeRuleFiles ".cursor/rules" "mdc" mkCursorRule;
}
