language en_GB.utf8 "prerequisite
set number

"plugins
call plug#begin()
Plug 'glepnir/dashboard-nvim'                     "Custom dashboard /plugged/dashboard-nvim
Plug 'folke/which-key.nvim'                       "Keybindings popup
Plug 'nvim-treesitter/nvim-treesitter'            "Orgmode dependancy
Plug 'nvim-orgmode/orgmode'	                      "Orgmode
Plug 'nvim-lua/plenary.nvim'                      "Telescope dependancy
Plug 'nvim-telescope/telescope.nvim'              "Telescope
Plug 'nvim-telescope/telescope-file-browser.nvim' "Telescope file browser
Plug 'elkowar/yuck.vim'                           "Yuck sytax hilighting
Plug 'github/copilot.vim'                         "Github copilot
Plug 'folke/tokyonight.nvim'                      "Theme

call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
syntax on " syntax highlighting

"colorscheme
colorscheme tokyonight-storm


" orgmode configuration
lua << EOF

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})
EOF


" which-key configuration

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
