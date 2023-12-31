{
  description = "Gwendolyn Wren's NixOS configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      # official nix cache server
      "https://cache.nixos.org"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };


  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      #config.allowUnfreePredicate = (pkg: true); # wacky workaround
    };
    #nur.url = "github:nix-community/NUR";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = inputs@{
    self,
    nixpkgs,
    #nur,
    home-manager,
    ... 
  }: {
    nixosConfigurations = {
      night = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

	# allow use of inputs in submodules
	specialArgs = inputs;

	modules = [
	  ./hosts/night

	  # add home-manager as a module
	  home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.dark = import ./home/dark.nix;
	  }
	];
      };

      steel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	
        modules = [
	  ./hosts/steel

	  #nur.modules.nur

	  # add home-manager as a module
#	  home-manager.nixosModules.home-manager {
#           home-manager.useGlobalPkgs = true;
#	    home-manager.useUserPackages = true;
#           home-manager.extraSpecialArgs = inputs;
#	    home-manager.users.flint = import ./home.nix;
#	  }

        ];
      };

      nixos-test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

	specialArgs = inputs;

	modules = [
	  ./hosts/nixos-test

	  #nur.nixosModules.nur

	  # add home-manager as a module
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = inputs;
	    home-manager.users.flint = import ./home/flint.nix;
	  }
	];
      };
    };
  };
}
