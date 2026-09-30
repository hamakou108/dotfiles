-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Leave <C-s> to the terminal multiplexer, which claims it as its prefix key.
-- Why not remap saving elsewhere: `:w` covers it.
for _, mode in ipairs({ "i", "x", "n", "s" }) do
  pcall(vim.keymap.del, mode, "<C-s>")
end
