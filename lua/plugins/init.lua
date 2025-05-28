return {


  -- Formateo automático opcional
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre',
    opts = require "configs.conform",
  },


  -- Plugin para gestionar herramientas como LSP/DAP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- Integra Mason con LSP
  {
    "williamboman/mason-lspconfig.nvim",
    config = true,
  },

  -- Configuración base de LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },


  -- Plugin para Rust con integración automática con DAP
  {
    "mrcjkb/rustaceanvim",
    version = '^6', -- Usamos la versión más reciente estable
    ft = { "rust" }, -- Se carga solo cuando se edita un archivo Rust
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        dap = {
          autoload_config = true, -- Deja que rustaceanvim configure codelldb
        },
      }
    end,
  },

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },


  -- Depurador
  {
    "mfussenegger/nvim-dap",
    config = function ()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function ()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function ()
        dapui.open()
      end
      dap.listeners.before.event_exited.dapui_config = function ()
        dapui.open()
      end
    end
  },

  -- Interfaz para el depurador
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },


  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },

}
