{ getSystemIgnoreWarning, ... }:
let
  # flake-parts provides `withSystem` which prints some trace statements
  # defining a similar function that doesn't print anything
  withSystemIgnoreWarning =
    system: f:
    f (getSystemIgnoreWarning system).allModuleArgs;
in
{
  flake.overlays.default = final: prev:
    withSystemIgnoreWarning prev.stdenv.hostPlatform.system (
      { config, ... }: {
        inherit (config.packages)
          anyrun
          anyrun-with-all-plugins;

        anyrunPlugins = (prev.anyrunPlugins or { }) // {
          inherit (config.packages)
            applications
            dictionary
            kidex
            randr
            rink
            shell
            stdin
            symbols
            translate
            websearch;
        };
      }
    );
}
