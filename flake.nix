{
  description = "Terminal UI for Jira";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in {
        packages = rec {
          lazyjira = pkgs.buildGoModule {
            pname = "lazyjira";
            version = self.shortRev or self.dirtyShortRev or "dev";
            src = self;
            vendorHash = "sha256-PLACEHOLDER";
            ldflags = [ "-s" "-w" "-X main.version=${self.shortRev or "dev"}" ];
            subPackages = [ "cmd/lazyjira" ];
            CGO_ENABLED = 0;
            meta = with pkgs.lib; {
              description = "Terminal UI for Jira";
              homepage = "https://github.com/textfuel/lazyjira";
              license = licenses.mit;
              mainProgram = "lazyjira";
            };
          };
          default = lazyjira;
        };
      }
    );
}
