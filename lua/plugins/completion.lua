local cmp_kinds = {
	Text = '  ',
	Method = '  ',
	Function = '  ',
	Constructor = '  ',
	Field = '  ',
	Variable = '  ',
	Class = '  ',
	Interface = '  ',
	Module = '  ',
	Property = '  ',
	Unit = '  ',
	Value = '  ',
	Enum = '  ',
	Keyword = '  ',
	Snippet = '  ',
	Color = '  ',
	File = '  ',
	Reference = '  ',
	Folder = '  ',
	EnumMember = '  ',
	Constant = '  ',
	Struct = '  ',
	Event = '  ',
	Operator = '  ',
	TypeParameter = '  ',
}

local function setup()
	-- luasnip setup
	local luasnip = require('luasnip')

	-- nvim-cmp setup
	local cmp = require('cmp')
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
			['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
			-- C-b (back) C-f (forward) for snippet placeholder navigation.
			['<C-Space>'] = cmp.mapping.complete(),
			['<CR>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		}),
		window = {
			completion = {
				winhighlight =
				"Normal:CompletionPmenu,FloatBorder:CompletionPmenu,Pmenu:CompletionPmenu,CursorLine:CompletionPmenuSel,Search:CompletionPmenu"
			},
			documentation = {
				winhighlight =
				"Normal:CompletionPmenu,FloatBorder:CompletionPmenu,Pmenu:CompletionPmenu,CursorLine:CompletionPmenuSel"
			}
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			-- { name = 'nvim_lsp_signature_help' }
		},
		---@diagnostic disable-next-line
		formatting = {
			fields = { "kind", "abbr" },
			format = function(_, vim_item)
				vim_item.kind = cmp_kinds[vim_item.kind] or ""
				return vim_item
			end,
		},
	})

	require("luasnip.loaders.from_vscode").load()

	require 'lsp_signature'.setup({
		bind = true,
		doc_lines = 0,
		hint_enable = false,
		handler_opts = {
			border = "none"
		}
	})
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"ray-x/lsp_signature.nvim",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets"
	},
	config = setup
}
