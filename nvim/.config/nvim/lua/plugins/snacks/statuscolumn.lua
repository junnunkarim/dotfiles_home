return {
	left = { "mark", "sign" }, -- priority of signs on the left (high to low)
	right = { "fold", "git" }, -- priority of signs on the right (high to low)
	folds = {
		open = false, -- show open fold icons
		git_hl = false, -- use Git Signs hl for fold icons
	},
	git = {
		-- patterns to match Git signs
		patterns = { "GitSign", "MiniDiffSign" },
	},
}
