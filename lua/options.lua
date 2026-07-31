require "nvchad.options"

local opt = vim.opt
opt.number = true

--- Common
-- NvChad 默认只设置高亮当前行的行号，这里把整行也高亮了
opt.cursorlineopt = "both"

-- 开启相对行号，这个因人而异，有些人喜欢有些人不喜欢，所以我默认把这行注释掉了，需要的话把注释取消掉
-- 相对行号主要是方便数行数，这样 `dd` 这种命令会容易用一些
-- opt.relativenumber = true

-- 显示特殊字符，比如尾随空格和 Tab
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- 启用 break indent，这个选项的意思是当一行过长触发自动换行时，会给换行前面添加一点缩进，跟容易识别
-- 说实话我个人不喜欢这个选项，所以这边默认注释掉了，你可以取消注释试试看喜不喜欢
-- opt.breakindent = true

-- 替换文本时展示一个单独的预览窗口，显示替换了哪几行
-- 这选项默认是 "nosplit"，也就是不展示这个预览窗口
-- 我个人不太需要这个选项，所以默认注释掉了，你可以取消注释试试看看喜不喜欢
-- opt.inccommand = "split"

-- 用来控制你滚动时上下至少要在视图里保留多少行
-- 默认这项是不配置的，所以你的光标可以滚动到当前视图的最后一行
-- 我不太习惯配置这个选项，所以默认注释掉了，你可以取消注释试试看看喜不喜欢
-- opt.scrolloff = 10
