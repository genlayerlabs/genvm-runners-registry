let
	# list[{id, hash, rev, derivation}]
	allRunnersList = import ./generations {};
		merge = l: r:
			let
				l_elem = if builtins.hasAttr r.id l then l.${r.id} else {};
			in
				l // { "${r.id}" = l_elem // { ${r.hash} = r; }; };
		allRunners = builtins.foldl' merge {} allRunnersList;
in {
	registry = builtins.mapAttrs (name: val: builtins.map (h: builtins.convertHash { hash = h; toHashFormat = "nix32"; }) (builtins.attrNames val)) allRunners;
	derivations = allRunners;
	allRunnersList = allRunnersList;
}
