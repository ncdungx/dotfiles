local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-treesitter/nvim-treesitter', { ['branch'] = 'main', ['do'] = ':TSUpdate' })
Plug('windwp/nvim-autopairs')
Plug('rebelot/kanagawa.nvim')
Plug('lervag/vimtex')
Plug('hrsh7th/nvim-cmp')
Plug('micangl/cmp-vimtex')
Plug('hrsh7th/cmp-buffer')
Plug('nvim-lualine/lualine.nvim')
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

vim.cmd('nnoremap j gj')
vim.cmd('nnoremap k gk')
vim.cmd('nnoremap <leader>h :nohl<CR>')

require('kanagawa').setup({ statementStyle = {bold = true} })
vim.cmd.colorscheme('kanagawa')

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
npairs.setup()
npairs.add_rules({
	Rule('\\(', '\\)', 'tex'),
	Rule('\\[', '\\]', 'tex'),
	Rule('$', '$', 'tex')
		:with_pair(function()
			return vim.fn['vimtex#syntax#in_mathzone']() == 0
		end),
})
local apostrophe_rules = npairs.get_rules("'")
for _, rule in pairs(apostrophe_rules) do
	rule:with_pair(cond.not_filetypes({'tex'}))
end

local cmp = require('cmp')
cmp.setup({
	mapping = ({
		['<M-j>'] = cmp.mapping.select_next_item(),
		['<M-k>'] = cmp.mapping.select_prev_item(),
		['<CR>'] = cmp.mapping.confirm({select = true}),
		['<Esc>']= cmp.mapping.abort(),
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

require('lualine').setup({
	options = {
		icons_enabled = false,
	},
	sections = {
		lualine_x = {},
		lualine_y = {},
		lualine_z = {'location', 'progress'},
	}
})

-- Workaround, used in paired with EVKey:
-- 1033 is English (US)
-- 8192 is English (World)
local vie = '1033' 
local eng = '8192'
local current_kb = ''
local function switch_im(kb)
	return function()
		vim.fn.jobstart({'im-select.exe', kb}, {
			on_exit = function()
				current_kb = kb
				vim.fn.system('sleep 0.1')
				vim.o.guicursor = vim.o.guicursor
			end
		})
	end
end

vim.api.nvim_create_autocmd('VimEnter', { callback = switch_im(eng) })
vim.api.nvim_create_autocmd('VimLeave', { callback = switch_im(vie) })
vim.api.nvim_create_autocmd('InsertEnter', { callback = switch_im(vie) })
vim.api.nvim_create_autocmd('InsertLeave', { callback = switch_im(eng) })
vim.api.nvim_create_autocmd('CmdlineEnter', { callback = switch_im(vie) })
vim.api.nvim_create_autocmd('CmdlineLeave', { callback = switch_im(eng) })
vim.api.nvim_create_autocmd('FocusLost', { callback = switch_im(vie) })
vim.api.nvim_create_autocmd('FocusGained', { callback = switch_im(current_kb) })
