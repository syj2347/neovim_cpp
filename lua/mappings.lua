require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

--- Common mappings with `Ctrl` used in other apps
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n", "i", "v" }, "<C-q>", "<cmd> qa <cr>", { desc = "quit all" })
map({ "n", "i", "v" }, "<C-z>", "<cmd> undo <cr>", { desc = "history undo" })
map({ "n", "i", "v" }, "<C-y>", "<cmd> redo <cr>", { desc = "history redo" })

map({ "n", "i", "v" }, "<C-f>", function()
  if vim.bo.filetype == "TelescopePrompt" then
    vim.cmd "q!"
  else
    vim.cmd "Telescope current_buffer_fuzzy_find"
  end
end, { desc = "search search in current buffer" })

-- DAP mappings
local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  map("n", "<leader>db", function()
    dap.toggle_breakpoint()
  end, { desc = "DAP toggle breakpoint" })
  map("n", "<F5>", function()
    dap.continue()
  end, { desc = "DAP continue" })
  map("n", "<leader>dr", function()
    dap.repl.toggle()
  end, { desc = "DAP REPL toggle" })
  map("n", "<leader>dl", function()
    dap.run_last()
  end, { desc = "DAP run last" })
  map("n", "<F3>", function()
    dap.step_over()
  end, { desc = "DAP step over" })
  map("n", "<F4>", function()
    dap.step_into()
  end, { desc = "DAP step into" })
  map("n", "<leader>dO", function()
    dap.step_out()
  end, { desc = "DAP step out" })
  map("n", "<F12>", function()
    dap.terminate()
  end, { desc = "DAP terminate" })
  map("n", "<leader>du", function()
    require("dapui").toggle()
  end, { desc = "DAP UI toggle" })
  map("n", "<leader>de", function()
    require("dapui").eval()
  end, { desc = "DAP UI eval" })

  -- 运行当前文件（不调试）
  map("n", "<F9>", function()
    local file = vim.fn.expand "%:p"
    local dir = vim.fn.fnamemodify(file, ":h")
    local name = vim.fn.fnamemodify(file, ":t:r")
    local exe = dir .. "/" .. name

    -- 先编译
    local cmd = "g++ -o " .. exe .. " " .. file
    vim.notify("Compiling: " .. cmd, vim.log.levels.INFO)
    local output = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      vim.notify("Compilation failed:\n" .. output, vim.log.levels.ERROR)
      return
    end

    -- 创建浮动终端
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.3)
    local height = math.floor(vim.o.lines * 0.65)
    local row = 2
    local col = vim.o.columns - width - 2
    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      row = row,
      col = col,
      width = width,
      height = height,
      style = "minimal",
      border = "rounded",
      title = " Run ",
      title_pos = "center",
    })
    vim.fn.termopen(exe, {
      on_exit = function()
        vim.schedule(function()
          if vim.api.nvim_win_is_valid(win) then
            vim.keymap.set("n", "q", function()
              vim.api.nvim_win_close(win, true)
            end, { buffer = buf, silent = true })
          end
        end)
      end,
    })
    vim.keymap.set("n", "q", function()
      vim.api.nvim_win_close(win, true)
    end, { buffer = buf, silent = true })
    vim.cmd "startinsert"
  end, { desc = "Run current file" })
end
