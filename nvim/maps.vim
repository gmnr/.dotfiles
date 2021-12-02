" fix Y behaviour
nmap Y y$

" move across visual lines
nnoremap j gj
nnoremap k gk

" disable Q for ex-mode
nnoremap Q <nop>

" open and load .vimrc
nnoremap <leader>ev :e ~/.dotfiles/nvim/init.vim<CR>
nnoremap <leader>ep :e ~/.dotfiles/nvim/plug.vim<CR>
nnoremap <leader>em :e ~/.dotfiles/nvim/maps.vim<CR>
nnoremap <leader>sv :so ~/.dotfiles/nvim/init.vim<CR>
nnoremap <leader>el :Explore ~/.dotfiles/nvim/after/plugin/<CR>

" quick save and exit
nnoremap <leader>ww :w<CR>
nnoremap <leader>qq :bd!<CR>
nnoremap <leader>wq :Wd<CR>
nnoremap <leader>QQ :q!<CR>

" quick search
nnoremap <leader>ff :%s/

" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" remap backspace to lats used buffer
nnoremap <BS> <C-^>

" map vim-fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>
nnoremap <leader>gc :GBranches<CR>

" telescope mappings
nnoremap <leader>pp <cmd>Telescope find_files<CR>
nnoremap <leader>pl <cmd>Telescope live_grep<CR>
nnoremap <leader>po <cmd>Telescope buffers<CR>
nnoremap <leader>pt <cmd>Telescope tags<CR>
nnoremap <leader>ps <cmd>Telescope git_status<CR>
nnoremap <leader>pg <cmd>Telescope git_files<CR>
nnoremap <leader>pc <cmd>Telescope git_branches<CR>

" vimviki
nmap <leader>wm <Plug>VimwikiIndex
nmap <Leader>wo <Plug>Vimwiki2HTMLBrowse
nnoremap <leader>wf :VWS /

" change the current directory to edited file
nmap <leader>cd :cd %:h<CR>

" add autocorrect
nmap <leader><Tab> 1z=

" quickrun
nnoremap <leader>r :w<CR>:QuickRun<CR>

" toggle paste
nnoremap <leader>yy :set invpaste paste?<CR>

" change mappings for location list navigation
nnoremap [w :lprevious<CR>
nnoremap ]w :lnext<CR>
nnoremap [W :lfirst<CR>
nnoremap ]W :llast<CR>

" change prefix for window navigation
nnoremap <leader>a <C-w>

" swap fold command
nnoremap za zo
nnoremap zo za

" copy buffer to clipboard
nnoremap <leader>cp :w !pbcopy<CR>
