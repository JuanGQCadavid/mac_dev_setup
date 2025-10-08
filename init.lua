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
   "m4xshen/hardtime.nvim",
   lazy = false,
   dependencies = { "MunifTanjim/nui.nvim" },
   opts = {},
  },
  
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

vim.cmd("colorscheme nord")

