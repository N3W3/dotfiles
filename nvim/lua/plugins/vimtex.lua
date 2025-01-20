return {
	{
		"lervag/vimtex", -- Plugin vimtex pour LaTeX
		ft = "tex", -- Charger vimtex uniquement pour les fichiers .tex
		lazy = false,
		config = function()
			vim.g.vimtex_view_method = "zathura_simple"
		end,
	},
}
