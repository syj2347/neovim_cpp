-- 自定义断点和调试箭头样式
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "Comment", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DiagnosticOk", linehl = "Visual", numhl = "" })

-- 自动编译并返回可执行文件路径
local function build_and_get_exe()
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.fnamemodify(file, ":h")
  local name = vim.fn.fnamemodify(file, ":t:r")
  local exe = dir .. "/" .. name
  local cmd = "g++ -g -o " .. exe .. " " .. file

  vim.notify("Compiling: " .. cmd, vim.log.levels.INFO)
  local output = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Compilation failed:\n" .. output, vim.log.levels.ERROR)
    return nil
  end
  vim.notify("Compilation successful", vim.log.levels.INFO)

  return exe
end

return {
  adapters = {
    codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    },
  },
  configurations = {
    cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return build_and_get_exe()
        end,
        cwd = "${fileDirname}",
        stopOnEntry = false,
      },
      {
        name = "Attach to gdbserver",
        type = "codelldb",
        request = "attach",
        program = function()
          return build_and_get_exe()
        end,
        cwd = "${fileDirname}",
        stopOnEntry = false,
        miDebuggerServerAddress = "localhost:1234",
      },
    },
    c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return build_and_get_exe()
        end,
        cwd = "${fileDirname}",
        stopOnEntry = false,
      },
    },
  },
}
