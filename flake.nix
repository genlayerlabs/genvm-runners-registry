{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/2b4230bf03deb33103947e2528cac2ed516c5c89";
	};

	outputs = inputs@{ self, nixpkgs, ... }:
		let
			pkgs = import nixpkgs {
				system = "x86_64-linux";
			};

			lib = pkgs.lib;

			data = import ./default.nix;
		in data;
}
