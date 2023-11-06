{
  description = "A flaky flake";

  # description = "A template that shows all standard flake outputs";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  # The flake in the current directory.
  # inputs.currentDir.url = ".";

  # A flake in some other directory.
  # inputs.otherDir.url = "/home/alice/src/patchelf";

  # A flake in some absolute path
  # inputs.otherDir.url = "path:/home/alice/src/patchelf";

  # The nixpkgs entry in the flake registry.
  # inputs.nixpkgsRegistry.url = "nixpkgs";

  # The nixpkgs entry in the flake registry, overriding it to use a specific Git revision.
  # inputs.nixpkgsRegistryOverride.url = "nixpkgs/a3a3dda3bacf61e8a39258a0ed9c924eeca8e293";

  # The master branch of the NixOS/nixpkgs repository on GitHub.
  # inputs.nixpkgsGitHub.url = "github:NixOS/nixpkgs";

  # The nixos-20.09 branch of the NixOS/nixpkgs repository on GitHub.
  # inputs.nixpkgsGitHubBranch.url = "github:NixOS/nixpkgs/nixos-20.09";

  # A specific revision of the NixOS/nixpkgs repository on GitHub.
  # inputs.nixpkgsGitHubRevision.url = "github:NixOS/nixpkgs/a3a3dda3bacf61e8a39258a0ed9c924eeca8e293";

  # A flake in a subdirectory of a GitHub repository.
  # inputs.nixpkgsGitHubDir.url = "github:edolstra/nix-warez?dir=blender";

  # A git repository.
  # inputs.gitRepo.url = "git+https://github.com/NixOS/patchelf";

  # A specific branch of a Git repository.
  # inputs.gitRepoBranch.url = "git+https://github.com/NixOS/patchelf?ref=master";

  # A specific revision of a Git repository.
  # inputs.gitRepoRev.url = "git+https://github.com/NixOS/patchelf?ref=master&rev=f34751b88bd07d7f44f5cd3200fb4122bf916c7e";

  # A tarball flake
  # inputs.tarFlake.url = "https://github.com/NixOS/patchelf/archive/master.tar.gz";

  # A GitHub repository.
  # inputs.import-cargo = {
  #   type = "github";
  #   owner = "edolstra";
  #   repo = "import-cargo";
  # };

  # Inputs as attrsets.
  # An indirection through the flake registry.
  # inputs.nixpkgsIndirect = {
  #   type = "indirect";
  #   id = "nixpkgs";
  # };

  # Non-flake inputs. These provde a variable of type path.
  # inputs.grcov = {
  #   type = "github";
  #   owner = "mozilla";
  #   repo = "grcov";
  #   flake = false;
  # };

  # Transitive inputs can be overridden from a flake.nix file. For example, the following overrides the nixpkgs input of the nixops input:
  # inputs.nixops.inputs.nixpkgs = {
  #   type = "github";
  #   owner = "NixOS";
  #   repo = "nixpkgs";
  # };

  # It is also possible to "inherit" an input from another input. This is useful to minimize
  # flake dependencies. For example, the following sets the nixpkgs input of the top-level flake
  # to be equal to the nixpkgs input of the nixops input of the top-level flake:
  # inputs.nixpkgs.url = "nixpkgs";
  # inputs.nixpkgs.follows = "nixops/nixpkgs";

  # The value of the follows attribute is a sequence of input names denoting the path
  # of inputs to be followed from the root flake. Overrides and follows can be combined, e.g.
  # inputs.nixops.url = "nixops";
  # inputs.dwarffs.url = "dwarffs";
  # inputs.dwarffs.inputs.nixpkgs.follows = "nixpkgs";

  # For more information about well-known outputs checked by `nix flake check`:
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake-check.html#evaluation-checks

  # These examples all use "x86_64-linux" as the system.
  # Please see the c-hello template for an example of how to handle multiple systems.

  # inputs.c-hello.url = "github:NixOS/templates?dir=c-hello";
  # inputs.rust-web-server.url = "github:NixOS/templates?dir=rust-web-server";
  # inputs.nix-bundle.url = "github:NixOS/bundlers";

  # Work-in-progress: refer to parent/sibling flakes in the same repository
  # inputs.c-hello.url = "path:../c-hello";

  inputs = {
    # Note, starting taken from:
    # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled

    # There are many ways to reference flake inputs.
    # The most widely used is `github:owner/name/reference`,
    # which represents the GitHub repository URL + branch/commit-id/tag.

    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix.url = "github:helix-editor/helix/23.05";
  };

  # outputs = all@{ self, c-hello, rust-web-server, nixpkgs, nix-bundle, ... }: {

    # Utilized by `nix flake check`
    # checks.x86_64-linux.test = c-hello.checks.x86_64-linux.test;

    # Utilized by `nix build .`
    # defaultPackage.x86_64-linux = c-hello.defaultPackage.x86_64-linux;

    # Utilized by `nix build`
    # packages.x86_64-linux.hello = c-hello.packages.x86_64-linux.hello;

    # Utilized by `nix run .#<name>`
    # apps.x86_64-linux.hello = {
    #   type = "app";
    #   program = c-hello.packages.x86_64-linux.hello;
    # };

    # Utilized by `nix bundle -- .#<name>` (should be a .drv input, not program path?)
    # bundlers.x86_64-linux.example = nix-bundle.bundlers.x86_64-linux.toArx;

    # Utilized by `nix bundle -- .#<name>`
    # defaultBundler.x86_64-linux = self.bundlers.x86_64-linux.example;

    # Utilized by `nix run . -- <args?>`
    # defaultApp.x86_64-linux = self.apps.x86_64-linux.hello;

    # Utilized for nixpkgs packages, also utilized by `nix build .#<name>`
    # legacyPackages.x86_64-linux.hello = c-hello.defaultPackage.x86_64-linux;

    # Default overlay, for use in dependent flakes
    # overlay = final: prev: { };

    # # Same idea as overlay but a list or attrset of them.
    # overlays = { exampleOverlay = self.overlay; };

    # Default module, for use in dependent flakes. Deprecated, use nixosModules.default instead.
    # nixosModule = { config, ... }: { options = {}; config = {}; };

    # Same idea as nixosModule but a list or attrset of them.
    # nixosModules = { exampleModule = self.nixosModule; };

    # Used with `nixos-rebuild --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    # nixosConfigurations.example = nixpkgs.lib.nixosSystem {
    #   system = "x86_64-linux";
    #   modules = [{boot.isContainer=true;}] ;
    # };

    # Utilized by `nix develop`
    # devShell.x86_64-linux = rust-web-server.devShell.x86_64-linux;

    # Utilized by `nix develop .#<name>`
    # devShells.x86_64-linux.example = self.devShell.x86_64-linux;

    # Utilized by Hydra build jobs
    # hydraJobs.example.x86_64-linux = self.defaultPackage.x86_64-linux;

    # Utilized by `nix flake init -t <flake>`
    # defaultTemplate = {
    #   path = c-hello;
    #   description = "template description";
    # };

    # Utilized by `nix flake init -t <flake>#<name>`
    # templates.example = self.defaultTemplate;
  # };

  outputs = { self, nixpkgs, home-manager, ...}@inputs: {
    nixosConfigurations = {
      # By default, NixOS will try to refer the nixosConfiguration with
      # its hostname, so the system named `squirrel` will use this one.
      # However, the configuration name can also be specified using:
      #   sudo nixos-rebuild switch --flake /path/to/flakes/directory#<name>
      #
      # The `nixpkgs.lib.nixosSystem` function is used to build this
      # configuration, the following attribute set is its parameter.
      #
      # Run the following command in the flake's directory to
      # deploy this configuration on any NixOS system:
      #   sudo nixos-rebuild switch --flake .#nixos-test

      "squirrel" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # The Nix module system can modularize configuration,
        # improving the maintainability of configuration.
        #
        # Each parameter in the `modules` is a Nix Module, and
        # there is a partial introduction to it in the nixpkgs manual:
        #    <https://nixos.org/manual/nixpkgs/unstable/#module-system-introduction>
        # It is said to be partial because the documentation is not
        # complete, only some simple introductions.
        # such is the current state of Nix documentation...
        #
        # A Nix Module can be an attribute set, or a function that
        # returns an attribute set. By default, if a Nix Module is a
        # function, this function have the following default parameters:
        #
        #  lib:     the nixpkgs function library, which provides many
        #             useful functions for operating Nix expressions:
        #             https://nixos.org/manual/nixpkgs/stable/#id-1.4
        #  config:  all config options of the current flake, every useful
        #  options: all options defined in all NixOS Modules
        #             in the current flake
        #  pkgs:   a collection of all packages defined in nixpkgs,
        #            plus a set of functions related to packaging.
        #            you can assume its default value is
        #            `nixpkgs.legacyPackages."${system}"` for now.
        #            can be customed by `nixpkgs.pkgs` option
        #  modulesPath: the default path of nixpkgs's modules folder,
        #               used to import some extra modules from nixpkgs.
        #               this parameter is rarely used,
        #               you can ignore it for now.
        #
        # The default parameters mentioned above are automatically
        # generated by Nixpkgs. 
        # However, if you need to pass other non-default parameters
        # to the submodules, 
        # you'll have to manually configure these parameters using
        # `specialArgs`. 
        # you must use `specialArgs` by uncomment the following line:
        #
        # specialArgs = {...};  # pass custom arguments into all sub module.

        # Set all input parameters as specialArgs of all sub-modules
        # so that we can use the `helix`(an attribute in inputs) in
        # sub-modules directly.
        specialArgs = inputs;

        modules = [
          # Import the configuration.nix here, so that the
          # old configuration file can still take effect.
          # Note: configuration.nix itself is also a Nix Module,
          ./configuration.nix

	  # make home-manager a module of nixos
          # so that home-manager configuration will be deployed automatically
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dlkrejsa = import ./home.nix;
            # optionally, use home-manager.extraSpecialArgs to pass arguments
            # to home.nix...
          }
        ];
      };
    };
  };
}

