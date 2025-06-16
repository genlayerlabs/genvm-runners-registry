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

			# list[{id, hash, derivation}]
			allRunnersList = import ./generations {};
			merge = l: r:
				let
					l_elem = if builtins.hasAttr r.id l then l.${r.id} else {};
				in
					l // { "${r.id}" = l_elem // r; };
			allRunners = builtins.foldl' merge {} allRunnersList;
		in {
			registry = builtins.mapAttrs (name: val: builtins.convertHash { hash = val.hash; toHashFormat = "nix32"; }) allRunners;
			derivations = allRunners;
			allRunnersList = allRunnersList;
		};
}
