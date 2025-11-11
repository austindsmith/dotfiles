-- Terminal Toggle (Space+t)
local function toggle_term()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  vim.cmd("belowright split | resize 12 | terminal")
end
vim.keymap.set("n", "<leader>t", toggle_term, { desc = "Toggle terminal" })
