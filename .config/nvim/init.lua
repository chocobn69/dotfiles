vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- reopening a file at the same place than last time
vim.cmd [[
augroup reopen_last
autocmd!
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end
-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
vim.cmd [[packadd packer.nvim]]

vim.opt.clipboard = 'unnamedplus'

vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.history = 100
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.linespace = 0
vim.opt.laststatus = 2
vim.opt.updatetime = 100
vim.opt.syntax = 'on'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.background = 'dark'
vim.o.updatetime = 250
vim.o.showcmd = true

-- 2 lines for cmd line
vim.opt.cmdheight = 1

-- utils directories
vim.opt.undodir = '/home/choco/.vim/tmp/undo'
vim.opt.backupdir = '/home/choco/.vim/tmp/backup'
vim.opt.directory = '/home/choco/.vim/tmp/swap'

vim.opt.tags = './tags,tags,/home/choco/projets_locaux/pricing/tags'
vim.g.python3_host_prog = '/home/choco/.pyenv/versions/neovim/bin/python'

vim.opt.encoding = 'utf-8'

-- allow per project settings file
vim.opt.exrc = true

-- enable mouse
vim.opt.mouse = 'a'

-- enter spaces when tab is pressed
vim.o.expandtab = true
-- use 4 spaces to represent tab
vim.o.tabstop = 4
vim.o.softtabstop = 4
-- number of spaces to use for auto indent
vim.o.shiftwidth = 4

--Set the number of lines to always display
vim.o.scrolloff = 0

--Make line numbers default
vim.wo.relativenumber = true
vim.wo.number = true

--Show tabs / nbsp / trailing spaces
vim.opt.list = true
vim.opt.listchars = {nbsp='¤',tab='··',trail='¤',extends='▶',precedes='◀'}

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- define mapleader
vim.g.mapleader = ','

-- do not conceal anything !
vim.opt.conceallevel = 0

--Set colorscheme
vim.o.termguicolors = true

-- get current base16 theme
base16_theme = vim.env.BASE16_THEME

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    use 'RRethy/nvim-base16' -- base16
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'nvim-lualine/lualine.nvim' -- Fancier statusline
    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- A file explorer tree for neovim written in lua
    use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' }}
    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    -- Collection of configurations for built-in LSP client
    use 'neovim/nvim-lspconfig'
    use 'alexaandru/nvim-lspupdate'
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-git'
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'tpope/vim-commentary'
    use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'}, { "nvim-telescope/telescope-live-grep-args.nvim" } },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    -- Add git related info in the signs columns and popups
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    use 'psf/black' -- black formating
    use 'ethanholz/nvim-lastplace' -- reopen file at the previous position
    use 'AaronLasseigne/yank-code' -- yank code with file name and line number
end)

vim.cmd('colorscheme base16-' .. base16_theme)

-- treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "html", "json", "bash", "lua", "sql" },
    auto_install = true,
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    }
}

-- bufferline
require("bufferline").setup{}

require("mason").setup {}
require("mason-lspconfig").setup {}
--Set statusbar
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'base16',
        component_separators = '|',
        section_separators = '',
        path = 1,
        shorting_target = 40,
    },
}

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

--NVimtree shortcuts
require('nvim-tree').setup {}
local api = require("nvim-tree.api")
vim.keymap.set('n', '<leader>t',api.tree.toggle)

-- Telescope
local actions = require("telescope.actions")
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-h>"] = "which_key"
            },
        },
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            ignore_current_buffer = true,
        },
    },
    extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        }
    }
}
require('telescope').load_extension('fzf')
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files)
vim.keymap.set('n', '<C-n>', builtin.live_grep)
vim.keymap.set('n', '<C-l>', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', '<C-b>', builtin.buffers)
vim.keymap.set('n', 'gj', builtin.diagnostics)

-- copy relative path of current file
vim.keymap.set('n', '<leader>f', ':let @+ = expand("%")<CR>', {silent=true})
-- add a line before, then a line after, then go back to initial line
vim.keymap.set('n', 'gA', 'O<esc>jo<esc>k')
-- paste after line
vim.keymap.set('n', 'gP', 'o<esc>p')
-- disable Ex mode
vim.keymap.set('n', 'Q', '<nop>')
-- Use kj as escape
vim.keymap.set('i', 'kj', '<ESC>')
-- select previously pasted
vim.keymap.set('v', 'gp', '`[v`]')
-- save with spacebarspace
vim.keymap.set('n', '<space>', ':update<cr>', { silent = true })
vim.keymap.set('n', '<space>', ':update<cr>', { silent = true })
-- open config file to tune neovim
vim.keymap.set('n', '<leader>i', ':e /home/choco/.config/nvim/init.lua<cr>', { silent = true })
-- close buffer
vim.keymap.set('n', '<leader>x', ':update<cr>:bd<cr>', { silent = true })
-- remove search hl
vim.keymap.set('n', '<leader>h', ':nohlsearch<cr>', { silent = true })

-- fugitive
vim.keymap.set('n', 'gs', ':Git<cr>')
vim.keymap.set('n', 'gw', ':Gwrite<cr>')
vim.keymap.set('n', 'go', ':Git commit<cr>')

-- YankCode
vim.keymap.set('n', '<leader>y', ':YankCode<cr>', { silent = true })

-- remove trailing spaces
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*"},
    command = [[%s/\s\+$//e]],
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
lspconfig['pylsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pylint = { enabled = false },
                pyflakes = { enabled = false },
                black = { enabled = true, cache_config = true, preview = true },
                isort = { enabled = false },
                flake8 = { enabled = true },
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
            }
        }
    }
}
lspconfig['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

lspconfig['sqlls'].setup{
    flags = lsp_flags,
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"sql-language-server", "up", "--method", "stdio"},
    root_dir = vim.loop.os_homedir,
    settings = {
        sqlLanguageServer = {
            connections = {
                {
                    name = 'postgresql_dev',
                    adapter = 'postgres',
                    host = '127.0.0.1',
                    port = 54321,
                    user = 'pricing_dev',
                    password = 'pricing_dev69',
                    database = 'pricing_dev',
                },
            },
        },
    },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    }),
}

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
            { name = 'buffer' },
        })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        })
})

vim.api.nvim_create_user_command('Light', 'colorscheme base16-cupertino', {})
vim.api.nvim_create_user_command('Dark', 'colorscheme base16-seti', {})

vim.api.nvim_create_user_command('Pricing', ':cd /home/choco/projets_locaux/pricing/', {})
vim.api.nvim_create_user_command('Bo', ':cd /home/choco/projets_locaux/backoffice/', {})

-- to cleanup postgresql explain plan
function cleanup(args)
    vim.cmd(':%s/QUERY PLAN | //g')
    vim.cmd(':%g/---/d')
end
vim.api.nvim_create_user_command('CleanExplain', cleanup, {})

-- format SQL
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.sql"},
    callback = function()
        vim.api.nvim_set_keymap(
            "n",
            "g=",
            "<cmd>%!pg_format<CR>",
            { noremap = true, silent = true }
        )
        vim.o.equalprg=pg_format
    end
})

-- format python
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.py"},
    callback = function()
        -- Black formating
        vim.api.nvim_set_keymap(
            "n",
            "g=",
            ":Black<cr>",
            { noremap = true, silent = false }
        )
        -- add breakpoint()
        vim.api.nvim_set_keymap(
            "n",
            "gb",
            "Obreakpoint()<esc>",
            { noremap = true, silent = false }
        )
    end
})


-- reopen file at previous position
require'nvim-lastplace'.setup{}

vim.opt.secure = true
