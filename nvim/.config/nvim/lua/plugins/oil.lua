return {
	'stevearc/oil.nvim',
	opts = {
		columns = {
			"icon",
		},
		keymaps={
			["ss"] ="actions.select_split",
			["vv"] ="actions.select_vsplit"
		}
	},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	lazy = false,
}
