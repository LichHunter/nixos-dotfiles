{ lib, ... }:

with lib;

{
  options = {
    variables = mkOption {
      type = types.attrs;
      default = {};
    };
  };
}
