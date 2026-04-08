local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-treesitter/nvim-treesitter', { ['branch'] = 'main', ['do'] = ':TSUpdate' })
Plug('windwp/nvim-autopairs')
Plug('pysan3/fcitx5.nvim')
Plug('rebelot/kanagawa.nvim')
Plug('lervag/vimtex')
Plug('hrsh7th/nvim-cmp')
Plug('micangl/cmp-vimtex')
Plug('hrsh7th/cmp-buffer')
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

require('kanagawa').setup({
	statementStyle = {bold = false},
})
vim.cmd.colorscheme('kanagawa')

require('nvim-autopairs').setup()

local cmp = require('cmp')
cmp.setup({
	mapping = ({
		['<M-j>'] = cmp.mapping.select_next_item(),
		['<M-k>'] = cmp.mapping.select_prev_item(),
		['<CR>'] = cmp.mapping.confirm({select = true}),
		['<M-CR>'] = cmp.mapping.complete(),
		['<M-e>']= cmp.mapping.abort(),
		['<M-d>'] = cmp.mapping.scroll_docs(5),
		['<M-u>'] = cmp.mapping.scroll_docs(-5),
	}),
	sources = ({
		{name = 'buffer'},
	}),
	formatting = {
		format = function(_, item)
			local MAX_LABEL_WIDTH = 20
			local content = item.abbr
			if #content > MAX_LABEL_WIDTH then
				item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. '…'
			else
				item.abbr = content .. (' '):rep(MAX_LABEL_WIDTH - #content)
			end
			return item
		end
	},
})
cmp.setup.filetype('tex', {
	sources = {
		{name = 'vimtex'},
		{name = 'buffer'},
	},
})

require('fcitx5').setup({
	imname = {
		norm = 'keyboard-us',
		cmd  = 'keyboard-us',
	},
})
