{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
    
    extraConfig = ''
      set mouse=a
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent
      set wrap
      set linebreak
      set breakat=^I!@*-+;:,./?
      set incsearch
      set hlsearch
      set ignorecase
      set smartcase
      set termguicolors
      set signcolumn=yes
      set cursorline
      set lazyredraw
      set synmaxcol=3000
      set clipboard=unnamedplus
      set timeoutlen=300
      set ttimeoutlen=0
      set foldmethod=indent
      set foldlevel=99
      
      let mapleader = " "
      let maplocalleader = "\\"
      
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      
      nnoremap <leader>sv :vsplit<CR>
      nnoremap <leader>sh :split<CR>
      nnoremap <leader>sc :close<CR>
      nnoremap <leader>to :tabnew<CR>
      nnoremap <leader>tc :tabclose<CR>
      nnoremap <leader>tn :tabnext<CR>
      nnoremap <leader>tp :tabprevious<CR>
      nnoremap <leader>e :NvimTreeToggle<CR>
      nnoremap <leader>ff :Telescope find_files<CR>
      nnoremap <leader>fg :Telescope live_grep<CR>
      nnoremap <leader>fb :Telescope buffers<CR>
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
      nnoremap <leader>wq :wq<CR>
      nnoremap <leader>nh :nohl<CR>
      
      nnoremap gd :lua vim.lsp.buf.definition()<CR>
      nnoremap gr :lua vim.lsp.buf.references()<CR>
      nnoremap K :lua vim.lsp.buf.hover()<CR>
      nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
      nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
      nnoremap <leader>cf :lua vim.lsp.buf.format()<CR>
      
      nnoremap <leader>dn :lua vim.diagnostic.goto_next()<CR>
      nnoremap <leader>dp :lua vim.diagnostic.goto_prev()<CR>
      nnoremap <leader>do :lua vim.diagnostic.open_float()<CR>
      
      nnoremap <leader>/ :lua require('Comment').toggle()<CR>
      vnoremap <leader>/ :<C-u>lua require('Comment').toggle()<CR>
      
      nnoremap <leader>tt :terminal<CR>
      tnoremap <Esc> <C-\><C-n>
      
      colorscheme gruvbox
    '';
    
    extraPackages = with pkgs; [
      lua-language-server
      pyright
      typescript-language-server
      rust-analyzer
      gopls
      bash-language-server
      nil
      statix
      stylua
      prettier
      shfmt
      black
      isort
      rustfmt
      hadolint
      yamlfmt
      eslint
      shellcheck
    ];
  };
}
