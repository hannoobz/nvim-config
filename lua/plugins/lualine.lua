local function setup()
	vim.keymap.set('n', '<leader>bj', function()
		local cmd = 'LualineBuffersJump! ' .. vim.v.count
		vim.cmd(cmd)
	end);

	vim.keymap.set('n', '<leader>bn', '<cmd>bn<CR>')
	vim.keymap.set('n', '<leader>bp', '<cmd>bp<CR>')
	vim.keymap.set('n', '<leader>br', '<cmd>e#<CR>')

	vim.keymap.set('n', '<leader>bc', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>')
	vim.keymap.set('n', '<leader>be', '<cmd>%bd<CR>')
	vim.keymap.set('n', '<leader>bo', '<cmd>%bd|e#<CR>')

	require("bufferline").setup({
		options = {
			close_command = nil,
			buffer_close_icon = '',
			close_icon = '',
			diagnostics = "nvim_lsp",
			hover = {
				enabled = false
			},
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					separator = true
				}
			}
		}
	})


	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = 'auto',
			-- component_separators = { left = '', right = '' },
			component_separators = { left = '|', right = '' },
			section_separators = { left = '', right = '' },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff', 'diagnostics' },
			lualine_c = {
				-- 	{
				-- 		"buffers",
				-- 		show_filename_only = true,
				-- 		hide_filename_extension = false,
				-- 		show_modified_status = true,
				-- 		-- 0: Shows buffer name
				-- 		-- 1: Shows buffer index
				-- 		-- 2: Shows buffer name + buffer index
				-- 		-- 3: Shows buffer number
				-- 		-- 4: Shows buffer name + buffer number
				-- 		mode = 2,
				-- 		max_length = vim.o.columns * 2 / 3,
				-- 		symbols = {
				-- 			modified = ' ●',
				-- 			alternate_file = '',
				-- 			directory = '',
				-- 		},
				-- 	}
			},
			lualine_x = { 'encoding', 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	})
end

return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		'akinsho/bufferline.nvim',
		'nvim-tree/nvim-web-devicons'
	},
	config = setup
}
