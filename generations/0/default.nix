{ repo ? "https://github.com/yeagerai/genvm.git"
, ...
}:
let
	revs = import ./revs.nix;

	mapRev = rev:
		let
			src = builtins.fetchGit {
				url = repo;
				inherit rev;

				shallow = true;
				submodules = true;
			};
		in
			builtins.map (x: x // { inherit rev; }) (import "${src}/runners")
		;
in builtins.concatLists (builtins.map mapRev revs)
