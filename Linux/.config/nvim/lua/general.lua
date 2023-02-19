vim.opt.compatible = false 

-- Setting helpers
local cmd = vim.cmd
-- Set options (global/buffer/windows-scoped)
local opt = vim.opt
-- Global variables
local g = vim.g
local s = vim.s
local indent = 2

cmd([[
  filetype on
  filetype plugin indent on
]])

table.insert(opt.tags, './tags')

-- Generic settings

-- indention
opt.autoindent = true -- auto indentation
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = indent -- the number of spaces inserted for each indentation
opt.smartindent = true -- make indenting smarter
opt.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
opt.tabstop = indent -- insert 2 spaces for a tab
opt.shiftround = true -- use multiple of shiftwidth when indenting with '<' and '>'

opt.number = true

-- opt.noswapfile = true
opt.list = true
opt.listchars = {
    tab = '>>',
    trail = '·',
    extends = '»',
    precedes = '«',
    nbsp = '×'
}
opt.hls=true

opt.hidden = true
opt.termguicolors = true
opt.mouse = 'a' -- allow the mouse to be used in neovim


-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.syntax = 'enable'
opt.completeopt = {'menu', 'menuone', 'noselect'} -- mostly just for cmp
opt.shortmess = opt.shortmess + {
    c = true
}
opt.spell = true
opt.spelllang = en,cjk
opt.spellsuggest = best,9


