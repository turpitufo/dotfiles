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
    '';
    
    initLua = lib.mkForce ''
      -- Leader key
      vim.g.mapleader = ' '
      vim.g.maplocalleader = '\\'
      
      -- Basic key mappings
      vim.keymap.set('n', '<leader>w', ':w<CR>', { silent = true, desc = 'Save' })
      vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true, desc = 'Quit' })
      vim.keymap.set('n', '<leader>wq', ':wq<CR>', { silent = true, desc = 'Save and quit' })
      vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { silent = true, desc = 'Clear highlights' })
      
      -- Window navigation
      vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
      vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
      vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
      vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
      
      -- Split management
      vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { silent = true, desc = 'Vertical split' })
      vim.keymap.set('n', '<leader>sh', ':split<CR>', { silent = true, desc = 'Horizontal split' })
      vim.keymap.set('n', '<leader>sc', ':close<CR>', { silent = true, desc = 'Close buffer' })
      
      -- Tab management
      vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { silent = true, desc = 'New tab' })
      vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { silent = true, desc = 'Close tab' })
      vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { silent = true, desc = 'Next tab' })
      vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>', { silent = true, desc = 'Previous tab' })
      
      -- File navigation
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true, desc = 'File explorer' })
      vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true, desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { silent = true, desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { silent = true, desc = 'Buffers' })
      vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { silent = true, desc = 'Help tags' })
      
      -- LSP mappings
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true, desc = 'Go to definition' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true, desc = 'Go to references' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, desc = 'Hover' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true, desc = 'Rename' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { silent = true, desc = 'Code action' })
      vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { silent = true, desc = 'Format' })
      
      -- Diagnostics
      vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { silent = true, desc = 'Next diagnostic' })
      vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { silent = true, desc = 'Previous diagnostic' })
      vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { silent = true, desc = 'Open diagnostic' })
      
      -- Comment
      vim.keymap.set('n', '<leader>/', 'gcc', { silent = true, remap = true, desc = 'Toggle comment' })
      vim.keymap.set('v', '<leader>/', 'gc', { silent = true, remap = true, desc = 'Toggle comment' })
      
      -- Terminal
      vim.keymap.set('n', '<leader>tt', ':terminal<CR>', { silent = true, desc = 'Open terminal' })
      vim.keymap.set('t', '<Esc>', '<C-\\\><C-n>', { silent = true, desc = 'Exit terminal mode' })
      
      -- Plugin manager setup (lazy.nvim)
      local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
      if not vim.loop.fs_stat(lazy_path) then
        vim.fn.system({
          'git',
          'clone',
          '--filter=blob:none',
          'https://github.com/folke/lazy.nvim.git',
          '--branch=stable',
          lazy_path
        })
      end
      vim.opt.rtp:prepend(lazy_path)
      
      -- Plugin specifications
      require('lazy').setup({
        -- Colorscheme
        {
          'catppuccin/nvim',
          name = 'catppuccin',
          priority = 1000,
          config = function()
            vim.cmd.colorscheme('catppuccin-mocha')
          end
        },
        
        -- Treesitter
        {
          'nvim-treesitter/nvim-treesitter',
          build = ':TSUpdate',
          config = function()
            require('nvim-treesitter.configs').setup({
              ensure_installed = { 'lua', 'python', 'javascript', 'typescript', 'html', 'css', 'bash', 'c', 'cpp', 'rust', 'go', 'nix' },
              highlight = { enable = true },
              indent = { enable = true },
              sync_install = false,
              auto_install = true
            })
          end
        },
        
        -- LSP and Completion
        {
          'neovim/nvim-lspconfig',
          dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
          },
          config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
              ensure_installed = { 'lua_ls', 'pyright', 'tsserver', 'rust_analyzer', 'gopls', 'bashls' }
            })
            
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')
            
            lspconfig.lua_ls.setup(capabilities)
            lspconfig.pyright.setup(capabilities)
            lspconfig.tsserver.setup(capabilities)
            lspconfig.rust_analyzer.setup(capabilities)
            lspconfig.gopls.setup(capabilities)
            lspconfig.bashls.setup(capabilities)
            
            local cmp = require('cmp')
            cmp.setup({
              snippet = {
                expand = function(args) require('luasnip').lsp_expand(args.body) end
              },
              mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
              }, {
                { name = 'buffer' },
              })
            })
            
            cmp.setup.cmdline(':', {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                { name = 'path' }
              }, {
                { name = 'cmdline' }
              })
            })
            
            local signs = { Error = "X ", Warn = "! ", Hint = "? ", Info = "i " }
            for type, icon in pairs(signs) do
              local hl = "DiagnosticSign" .. type
              vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
          end
        },
        
        -- File explorer
        {
          'nvim-tree/nvim-tree.lua',
          dependencies = { 'nvim-tree/nvim-web-devicons' },
          cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
          config = function()
            require('nvim-tree').setup({
              disable_netrw = true,
              hijack_netrw = true,
              open_on_setup = false,
              ignore_ft_on_setup = { 'dashboard' },
              auto_close = true,
              update_cwd = true,
              diagnostics = { enable = true },
              git = { enable = true },
              view = { width = 30, side = 'left' }
            })
          end
        },
        
        -- Status line
        {
          'nvim-lualine/lualine.nvim',
          dependencies = { 'nvim-tree/nvim-web-devicons' },
          config = function()
            require('lualine').setup({
              options = {
                icons_enabled = true,
                theme = 'catppuccin',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' }
              },
              sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
              }
            })
          end
        },
        
        -- Buffer line
        {
          'akinsho/bufferline.nvim',
          dependencies = { 'nvim-tree/nvim-web-devicons' },
          config = function()
            require('bufferline').setup({
              options = {
                mode = 'tabs',
                numbers = 'none',
                close_command = 'bdelete! %d',
                diagnostics = 'nvim_lsp',
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                separator_style = 'thin'
              }
            })
          end
        },
        
        -- Telescope
        {
          'nvim-telescope/telescope.nvim',
          dependencies = { 'nvim-lua/plenary.nvim' },
          cmd = 'Telescope',
          config = function()
            require('telescope').setup({
              defaults = {
                layout_strategy = 'horizontal',
                layout_config = { preview_cutoff = 1 },
                file_ignore_patterns = { 'node_modules/.*', '.git/.*' },
                path_display = { shorten = { len = 1, exclude = { -1, -2 } } },
                winblend = 0,
                border = {},
                borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                color_devicons = true
              }
            })
          end
        },
        
        -- Autopairs
        {
          'windwp/nvim-autopairs',
          config = function()
            require('nvim-autopairs').setup({
              check_ts = true,
              disable_filetype = { 'TelescopePrompt' }
            })
          end
        },
        
        -- Comment
        {
          'numToStr/Comment.nvim',
          config = function()
            require('Comment').setup({})
          end
        },
        
        -- Indent blankline
        {
          'lukas-reineke/indent-blankline.nvim',
          main = 'ibl',
          config = function()
            require('ibl').setup({
              indent = { char = '┊' },
              whitespace = { remove_blankline_trail = true },
              scope = { enabled = false }
            })
          end
        },
        
        -- Git integration
        {
          'lewis6991/gitsigns.nvim',
          config = function()
            require('gitsigns').setup({
              signs = {
                add = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                change = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
                delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' }
              },
              numhl = true,
              linehl = false
            })
          end
        }
      })
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
