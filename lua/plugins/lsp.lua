local function setup()
	require("neodev").setup({})

	local original_floating = vim.lsp.util.open_floating_preview
	---@diagnostic disable-next-line
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		---@type nil, any
		local buffer, window = original_floating(contents, syntax, opts, ...)

		vim.api.nvim_win_set_option(window, 'winhighlight',
			"Normal:CompletionPmenu,FloatBorder:CompletionPmenu,Pmenu:CompletionPmenu,CursorLine:CompletionPmenuSel,Search:CompletionPmenu")
		return buffer, window
	end

	local lspconfig = require('lspconfig')
	lspconfig.tailwindcss.setup({
		filetypes = { "typescriptreact", "javascriptreact", "vue", "svelte", "html" }
	})
	lspconfig.intelephense.setup({})
	lspconfig.lua_ls.setup({})
	lspconfig.hls.setup({})
	lspconfig.clangd.setup({})
	lspconfig.gopls.setup({})
	lspconfig.pyright.setup({
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "off"
				}
			}
		}
	})
	lspconfig.jdtls.setup({
		root_dir = function()
			local dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
			if dir == nil then
				dir = vim.fn.getcwd()
			end
			return dir
		end
	})
	lspconfig.vuels.setup({})
	lspconfig.asm_lsp.setup({
		root_dir = function()
			return vim.fn.getcwd()
		end
	})

	--Enable (broadcasting) snippet capability for completion
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	lspconfig.cssls.setup {
		capabilities = capabilities,
	}

	local tsCapabilities = vim.lsp.protocol.make_client_capabilities();
	tsCapabilities.textDocument.completion.completionItem.snippetSupport = true
	lspconfig.tsserver.setup({
		capabilities = tsCapabilities
	})

	local htmlCapabilities = vim.lsp.protocol.make_client_capabilities()
	htmlCapabilities.textDocument.completion.completionItem.snippetSupport = true
	lspconfig.html.setup({ capabilities = htmlCapabilities })

	local rustCapabilities = vim.lsp.protocol.make_client_capabilities()
	rustCapabilities.textDocument.completion.completionItem.snippetSupport = true
	rustCapabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { 'additionalTextEdits' }
	}
	lspconfig.rust_analyzer.setup({
		capabilities = rustCapabilities,
	})

	local jsonCapabilities = vim.lsp.protocol.make_client_capabilities()
	jsonCapabilities.textDocument.completion.completionItem.snippetSupport = true
	lspconfig.jsonls.setup({
		settings = {
			json = {
				schemas = require('schemastore').json.schemas(),
				validate = { enable = true }
			},
		},
		capabilities = jsonCapabilities,
	})
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
		vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
		vim.keymap.set('n', 'gp', "<C-t>", opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>',
			{ noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>',
			{ noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>',
			{ noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
	end,
})

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"b0o/schemastore.nvim"
	},
	config = setup,
}
