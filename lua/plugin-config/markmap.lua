
local markmap = require('markmap')

-- 获取当前文件的绝对路径
local current_file = vim.fn.expand('%:p')
-- 获取当前文件的文件名（不含路径和后缀）
local current_file_name = vim.fn.fnamemodify(current_file, ':t:r')
-- 构建html输出路径
local html_output = vim.fn.fnamemodify(current_file, ":p:h") .. '/' .. current_file_name .. '.html'

-- 设置Markmap的默认选项
local opts = {
    html_output = html_output,  -- 设置HTML输出路径为与当前.md文件同名的.html文件
    hide_toolbar = false,       -- 默认不隐藏工具栏
    grace_period = 3600000,       -- 默认宽限期时间
    -- 单个节点的最大宽度
    -- max_width = 10,
}

-- 在CSS样式中添加节点内容自动换行规则
local custom_css = [[
    .markmap-inner .mindmap-container .node .node-content {
        white-space: normal !important;
        word-break: break-word !important;

    }
    .markmap-foreign-testing-max {
        max-width: 100px;  /* 设置节点宽度为200px，根据需求调整实际值 */
    }
]]

-- 设置Markmap的额外样式
opts.custom_css = custom_css

-- 调用Markmap的setup函数设置配置项
markmap.setup(opts)

