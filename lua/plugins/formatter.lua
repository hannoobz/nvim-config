local function setup()
	vim.api.nvim_create_user_command("Format", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, { range = true })
	vim.keymap.set('n', '<space>f', "<cmd>Format<CR>")

	local jsFamily = function()
		local config = vim.fs.find({
			".prettierrc",
			".prettierrc.json",
			".prettierrc.yml",
			".prettierrc.yaml",
			".prettierrc.json5",
			"prettier.config.js",
			".prettierrc.js",
			"prettier.config.mjs",
			".prettierrc.mjs",
			"prettier.config.cjs",
			".prettierrc.cjs"
		}, { upward = true })[1]

		if config then
			return { "prettier" }
		else
			return {}
		end
	end

	local conform = require("conform")

	conform.formatters.nasmfmt = {
		command = "nasmfmt",
		args = { "$FILENAME" },
		stdin = false
	}

	conform.setup({
		formatters_by_ft = {
			javascript = jsFamily,
			typescript = jsFamily,
			javascriptreact = jsFamily,
			typescriptreact = jsFamily,
			c = { 'clang_format' },
			cpp = { 'clang_format' },
			asm = { 'nasmfmt' }
		},
		format_after_save = function(bufnr)
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return {}
			end

			return {
				lsp_fallback = true
			}
		end
	})
end

return {
	"stevearc/conform.nvim",
	config = setup
}
