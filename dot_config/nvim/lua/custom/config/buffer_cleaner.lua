local M = {}

M.max_buffers = 5

function M.cleanup()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })

    if #buffers <= M.max_buffers then
        return
    end

    -- Oldest buffers first
    table.sort(buffers, function(a, b)
        return a.lastused < b.lastused
    end)

    local to_remove = #buffers - M.max_buffers

    for _, buf in ipairs(buffers) do
        if to_remove <= 0 then
            break
        end

        local bufnr = buf.bufnr

        -- Only remove hidden, unmodified buffers
        if vim.api.nvim_buf_is_valid(bufnr)
            and vim.bo[bufnr].modified == false
            and not vim.api.nvim_buf_is_loaded(bufnr) then
            vim.api.nvim_buf_delete(bufnr, {
                force = false,
            })

            to_remove = to_remove - 1
        end
    end
end

function M.setup()
    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
            vim.schedule(M.cleanup)
        end,
    })
end

return M
