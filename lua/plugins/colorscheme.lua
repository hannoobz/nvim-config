local function setup()
	local c = require('vscode.colors').get_colors()
	require("vscode").setup({
		style = "dark",
		transparent = false,
		italic_comments = true,
		disable_nvimtree_bg = true,
		color_overrides = {
			vscBack = "#000000",
			vscTabCurrent = "#000000",
			vscLineNumber = "#969696",
			vscPopupBack = "#000000",
			vscLeftDark = "#000000"
		},
		group_overrides = {
			-- nvim-cmp highlight group (using winhighlight properties)
			CompletionPmenu = { bg = '#1e1e1e' },
			CompletionPmenuSel = { bg = '#505050' },
			CmpItemAbbrDeprecated = { fg = c.vscCursorDark, bg = 'NONE', strikethrough = true },
			NvimTreeOpenedFolderName = { bg = 'NONE', fg = '#d4d4d4' }
		}
	})

	require("catppuccin").setup {
		custom_highlights = function()
			return {
				CompletionPmenuSel = { bg = '#505050' },
			}
		end
	}

	require("catppuccin").load()

	local hooks = require("ibl.hooks")
	local highlightBlur = { "IndentBlur" }
	local highlightFocus = { "IndentFocus" }

	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "IndentBlur", { fg = "#333333" })
	end)

	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "IndentFocus", { fg = "#ffffff" })
	end)

	require("ibl").setup({
		indent = {
			char = "│",
			highlight = highlightBlur
		},
		scope = {
			char = "┃",
			show_start = false,
			show_end = false,
			show_exact_scope = false,
			highlight = highlightFocus
		}
	})
end

return {
	{
		'Mofiqul/vscode.nvim',
		dependencies = {
			"lukas-reineke/indent-blankline.nvim"
		},
		config = setup
	},
	{ "folke/tokyonight.nvim" },
	{ "catppuccin/nvim" },
	{ "ellisonleao/gruvbox.nvim" },

	-- Inline colorizer
	{
		'brenoprata10/nvim-highlight-colors',
		config = {
			render = 'background',
			enable_named_colors = true,
			enable_tailwind = true,
		}
	}
}
