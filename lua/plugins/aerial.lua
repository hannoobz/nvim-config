local function setup()
	require("aerial").setup({
		on_attach = function(bufnr)
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		end,
	})

	vim.keymap.set('n', '<leader>ov', '<cmd>AerialToggle<CR>')
end

return {
	'stevearc/aerial.nvim',
	config = setup
}
