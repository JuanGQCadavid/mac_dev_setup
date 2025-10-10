local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)


-- This is where you configure lazy.nvim and list your plugins
require("lazy").setup({
  -- For linting (diagnostics)
  "mfussenegger/nvim-lint",
  -- For formatting and autofixing
  "stevearc/conform.nvim",

  -- Example: Install the "Telescope" fuzzy finder plugin
  "nvim-telescope/telescope.nvim",

  -- Example: Install the "Lualine" statusline plugin
  "nvim-lualine/lualine.nvim",
 
  -- You can also add more advanced configuration
  {
    "neovim/nvim-lspconfig", -- LSP client
    -- This 'config' function runs after the plugin is loaded
    config = function()
      -- Do some LSP configuration here
    end
  },
  
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Enable highlighting
      highlight = {
        enable = true,
      },
      -- List of language parsers to install
      ensure_installed = { "yaml", "go", "gotmpl" },
    })
  end,
},
  {
    "qvalentin/helm-ls.nvim",
    ft = "helm",
    opts = {
      conceal_templates = {
        -- enable the replacement of templates with virtual text of their current values
        enabled = true, -- tree-sitter must be setup for this feature
      },
      indent_hints = {
        -- enable hints for indent and nindent functions
        enabled = true, -- tree-sitter must be setup for this feature
      },
    },
  },
  { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile", "BufEnter" } },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
  },

  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({})
      vim.cmd.colorscheme("nord")
    end,
  },
  install = {
    colorscheme = { "nord" },
  },
	
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true
 },
})


require("toggleterm").setup({
  -- The default direction, you can also have 'horizontal' or 'vertical'
  direction = "float",

  -- Other options you can configure
  open_mapping = [[<C-\>]], -- The keybinding to open/close the terminal

  -- Other useful settings
  hide_numbers = true, -- Hide line numbers in the terminal
  start_in_insert = true, -- Automatically start in insert mode
  persist_size = true, -- Remember the size of your terminal split
})


local lspconfig = require('lspconfig')
lspconfig.helm_ls.setup {
  settings = {
    ['helm-ls'] = {
      yamlls = {
        path = "yaml-language-server",
      },
    },
  },
}

vim.cmd("colorscheme nord")
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })


local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ss', function()
  builtin.grep_string({ search = vim.fn.expand('%:p'), initial_mode = 'normal' })
end, { desc = 'Search in current file' })

vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope find buffers' })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>t", builtin.find_files, { desc = "Find files" })


-- For copying and paste across buffers and OS clipboard
-- vim.opt.clipboard = "unnamedplus"
vim.opt.clipboard = "unnamedplus"

local lint = require("lint")

lint.linters_by_ft = {
  terraform = { "tflint" },
  hcl = { "tflint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    -- Use tffmt for formatting
    terraform = { "terraform_fmt" },
    hcl = { "terraform_fmt" },
    -- You can add other formatters here for other languages
    -- For example:
    -- lua = { "stylua" },
  },
  -- Automatically format on save
  format_on_save = {
    -- This ensures that only the currently active formatter runs on save
    -- and that it works for all filetypes
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  },
})
