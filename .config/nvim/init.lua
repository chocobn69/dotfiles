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
vim.api.nvim_set_option("clipboard", "unnamedplus")

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

-- 1 line for cmd line
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
vim.o.scrolloff = 5

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

-- default border style
local _border = "rounded"

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
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
    use 'NLKNguyen/papercolor-theme'
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'petertriho/cmp-git'
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
    -- Add git related info in the signs columns and popups
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    use 'AaronLasseigne/yank-code' -- yank code with file name and line number
    -- use "lukas-reineke/indent-blankline.nvim" -- visual indentation
    use {'ojroques/nvim-lspfuzzy',
        requires = {
            {'junegunn/fzf'},
            {'junegunn/fzf.vim'}  -- to enable preview (optional)
        }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use 'chentoast/marks.nvim' -- visual marks
    use 'jose-elias-alvarez/null-ls.nvim'
    use { "flobilosaurus/theme_reloader.nvim" }
    use({
        "stevearc/conform.nvim",
        config = function()
          require("conform").setup()
        end,
      })
    use 'rcarriga/nvim-notify'
    use({
        "stevearc/aerial.nvim",
        config = function()
          require("aerial").setup()
        end,
      })
    use 'uga-rosa/ccc.nvim'
end)

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
        theme = 'PaperColor',
        component_separators = '|',
        section_separators = '',
        path = 1,
        shorting_target = 40,
    },
    sections = {
    lualine_x = {
      {
        "aerial",
        dense = true,
      },
    },
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
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
}

--NVimtree shortcuts
require('nvim-tree').setup {}
local api = require("nvim-tree.api")
vim.keymap.set('n', '<leader>t', ':NvimTreeFindFile<cr>')

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
vim.keymap.set('n', '<C-k>', require("telescope").extensions.aerial.aerial)
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
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]],{noremap=true})

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = _border,
    }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = _border
    }
)
vim.diagnostic.config{
    float={border=_border}
}
require('lspconfig.ui.windows').default_options = {
    border = _border
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
                black = { enabled = false },
                isort = { enabled = false },
                flake8 = { enabled = false },
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
                ruff = { enabled = true },
            }
        }
    }
}
lspconfig['ts_ls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig['jsonls'].setup{}
lspconfig['ruff'].setup{}

lspconfig['sqlls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    filetypes = { "sql" },
    cmd = {"sql-language-server", "up", "--method", "stdio"},
    root_dir = vim.loop.os_homedir,
    single_file_support = true,
}


lspconfig['cssls'].setup{}

lspconfig['html'].setup{
    on_attach = on_attach,
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = {'html', 'htmldjango'},
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
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' ,
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
    }),
}

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        { name = 'buffer' ,
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
        { name = 'path' },
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
    })
})

function theme_light(args)
    vim.cmd[[set background=light]]
    vim.cmd[[colorscheme PaperColor]]
end
function theme_dark(args)
    vim.cmd[[set background=dark]]
    vim.cmd[[colorscheme PaperColor]]
end

require("theme_reloader").setup({
  light = "PaperColor",
  dark = "PaperColor"
})

vim.api.nvim_create_user_command('Light', theme_light, {})
vim.api.nvim_create_user_command('Dark', theme_dark, {})

vim.api.nvim_create_user_command('Pricing', ':cd /home/choco/projets_locaux/pricing/', {})
vim.api.nvim_create_user_command('Bo', ':cd /home/choco/projets_locaux/backoffice/', {})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

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
        vim.keymap.set(
            "n",
            "g=",
            ":Format<cr>",
            { noremap = true, silent = false }
        )
    end
})

-- format python
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.py"},
    callback = function()
        vim.keymap.set(
            "n",
            "g=",
            vim.lsp.buf.format,
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

-- format json
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.json"},
    callback = function()
        -- jq formating
        vim.api.nvim_set_keymap(
            "n",
            "g=",
            ":%!jq '.'<cr>",
            { noremap = true, silent = false }
        )
    end
})

require('lspfuzzy').setup {}

-- indent-blankline
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions.
  -- higher values will have better performance but may cause visual lag,
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}

require("conform").setup({
  formatters_by_ft = {
    python = { "ruff" },
    sql = { "pg_format" },
  },
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.notify = require("notify")
local notify = require 'notify'
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local lvl = ({
    'ERROR',
    'WARN',
    'INFO',
    'DEBUG',
  })[result.type]
  notify({ result.message }, lvl, {
    title = 'LSP | ' .. client.name,
    timeout = 10000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

local ccc = require("ccc")
local mapping = ccc.mapping

ccc.setup({
  -- Your preferred settings
  -- Example: enable highlighter
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
})


vim.opt.secure = true
