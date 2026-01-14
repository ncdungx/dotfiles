local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('rebelot/kanagawa.nvim')
Plug('windwp/nvim-autopairs')
Plug('nvim-treesitter/nvim-treesitter')
Plug('lervag/vimtex')
Plug('hrsh7th/nvim-cmp')
Plug('micangl/cmp-vimtex')
vim.call('plug#end')

vim.o.rnu = true
vim.o.nu = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.linebreak = true
vim.o.breakindent = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.vimtex_view_method = 'sioyek'

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.cmd.colorscheme('kanagawa')

vim.diagnostic.config({ signs = false, severity_sort = true, jump = {float = true} })

require('nvim-autopairs').setup()

local cmp = require('cmp')
cmp.setup({
	mapping = ({
		['<M-d>'] = cmp.mapping.scroll_docs(5),
		['<M-u>'] = cmp.mapping.scroll_docs(-5),
		['<M-e>']= cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({select = true}),
		['<M-j>'] = cmp.mapping.select_next_item(),
		['<M-k>'] = cmp.mapping.select_prev_item(),
		['<M-Space>'] = cmp.mapping.complete()
	}),
	sources = ({
		{name = 'buffer'},
	}),
})
cmp.setup.filetype('tex', {
	sources = {
		{name = 'vimtex'},
		{name = 'buffer'},
	},
})
