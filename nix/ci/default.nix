{ inputs, ... }:

{
  flake.actions-nix = {
    defaults = {
      jobs = {
        runs-on = "ubuntu-latest";
        timeout-minutes = 15;
      };
    };
    
    workflows = {
      ".github/workflows/main.yaml" = {
        jobs = {
          nix-flake-check = {
            steps = [
              {
                uses = "actions/checkout@v4";
                "with" = {
                    submodules = true;
                };
              }
              inputs.actions-nix.lib.steps.DeterminateSystemsNixInstallerAction
              {
                name = "Check flake";
                run = "nix -Lv flake check";
              }
            ];
          };
        };
      };
    };
  };
}