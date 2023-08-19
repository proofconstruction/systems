# Stolen from https://github.com/infinisil/system/blob/master/config/new-modules/default.nix; thanks Silvan!

{ lib
, ...
}:

with lib;
let
  # Recursively constructs an attrset of a given directory
  getDir = dir: mapAttrs
    (file: type:
      if type == "directory"
      then getDir "${dir}/${file}"
      else type)
    (builtins.readDir dir);

  # Collects all files of a directory as a list of path strings
  files = dir: collect isString
    (mapAttrsRecursive
      (pathstr: type: concatStringsSep "/" pathstr)
      (getDir dir));

  filteredFiles = files:
    filter
      # Filters out files that don't end with .nix, ignoring this file.
      (file: hasSuffix ".nix" file && file != "default.nix")
      files;

  # Produces a list of absolute paths to non-`default.nix` nix files in `dir`.
  validFiles = dir: map (file: ./. + "/${file}") (filteredFiles (files dir));
in
{
  imports = validFiles ./.;
}
