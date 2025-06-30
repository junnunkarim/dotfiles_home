local function fcolor(mode, input_string)
	-- check if the mode is valid
	if mode ~= "bg" and mode ~= "fg" then
		error("Invalid mode. Mode should be 'bg' or 'fg'.")
	end

	-- determine the prefix based on the mode
	local prefix
	if mode == "fg" then
		prefix = "^c"
	elseif mode == "bg" then
		prefix = "^b"
	end

	-- construct the new string with prefix, input string, and postfix
	local new_string = prefix .. input_string .. "^"

	-- return the new string
	return new_string
end

-- return the function to make it accessible to other files
return fcolor
