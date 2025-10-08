local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)


-- This is where you configure lazy.nvim and list your plugins
require("lazy").setup({
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

