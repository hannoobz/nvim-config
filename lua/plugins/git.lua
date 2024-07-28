local function setup()
	require('gitsigns').setup({})
end

return {
	{
		"lewis6991/gitsigns.nvim",
		config = setup
	}
}
