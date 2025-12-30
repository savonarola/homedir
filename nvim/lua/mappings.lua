require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Telescope mappings
map("n", "<leader>p", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- Commenting mappings
map("n", "<leader>cc", "gcc", { desc = "Comment line", remap = true })
map("v", "<leader>cc", "gc", { desc = "Comment selection", remap = true })
map("n", "<leader>cu", "gcc", { desc = "Uncomment line", remap = true })
map("v", "<leader>cu", "gc", { desc = "Uncomment selection", remap = true })

-- Indentation mappings (keep selection after indent)
map("v", ">", ">gv", { desc = "Indent and keep selection" })
map("v", "<", "<gv", { desc = "Unindent and keep selection" })

-- Format mappings
map("n", "<leader>fm", function()
  require("conform").format({ async = true, lsp_fallback = false })
end, { desc = "Format file" })

map("v", "<leader>fm", function()
  require("conform").format({ async = true, lsp_fallback = false })
end, { desc = "Format selection" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
