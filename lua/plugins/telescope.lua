local function setup()
	require("aerial").setup({})
	require("telescope").load_extension("aerial")

	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous
				}
			},
		},
		pickers = {
			buffers = {
				show_all_buffers = true,
				sort_lastused = true,
				theme = "dropdown",
				previewer = false,
				mappings = {
					i = {
						["<C-d>"] = "delete_buffer",
					}
				}
			},
			colorscheme = {
				enable_preview = true,
				layout_config = {
					horizontal = {
						preview_cutoff = 0,
					},
				}
			}
		}
	})

	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
	vim.keymap.set('n', '<leader>fo', '<cmd>Telescope aerial<CR>', {})
	vim.keymap.set('n', '<leader>fa', builtin.builtin, {})
	vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
	vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})
	vim.keymap.set('n', '<leader>ft', builtin.git_files, {})
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
end

return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	config = setup
}
