-- create autocommand
local create_autocmd = vim.api.nvim_create_autocmd

-- save cursor position of a file
create_autocmd("BufReadPost", {
	pattern = "*",
	command = 'silent! normal! g`"zv',
	desc = "Open file at the last position it was edited earlier",
})
