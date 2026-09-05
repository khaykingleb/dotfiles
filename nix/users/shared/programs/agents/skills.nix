{ lib }:
/**
  Returns each immediate skill directory keyed by its name.
  Non-directory entries are ignored.

  # Type

  ```
  Path -> AttrSet
  ```
*/
skillsDirectory:
let
  skillNames = lib.attrNames (
    lib.filterAttrs (_: entryType: entryType == "directory") (builtins.readDir skillsDirectory)
  );
in
lib.genAttrs skillNames (skillName: skillsDirectory + "/${skillName}")
