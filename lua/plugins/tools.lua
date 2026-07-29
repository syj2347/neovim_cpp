---@type LazySpec
return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
      },
      select = {
        enabled = true,
        builtin = {
          border = "rounded",
          relative = "editor",
          width = 40,
          height = 5,
          prompt_prefix = " ",
          title = "Configuration",
          title_pos = "center",
        },
        telescope = nil,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "stevearc/dressing.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup dapui
      dapui.setup()

      -- Load C++ configurations
      local configs = require("configs.dap")

      -- Set adapters
      for name, adapter in pairs(configs.adapters) do
        dap.adapters[name] = adapter
      end

      -- Set configurations
      for filetype, configurations in pairs(configs.configurations) do
        dap.configurations[filetype] = configurations
      end

      -- Auto open/close dapui
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set("n", "<leader>d<LeftMouse>", function()
        dap.toggle_breakpoint()
      end, { desc = "DAP toggle breakpoint" })
      vim.api.nvim_set_keymap("n", "<2-LeftMouse>", "", {
        callback = function()
          dap.toggle_breakpoint()
        end,
        desc = "DAP toggle breakpoint",
      })
    end,
  },
}
