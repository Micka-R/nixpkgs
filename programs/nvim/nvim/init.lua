function breq(module)
	dofile('/home/pkngr/.config/nixpkgs/programs/nvim/nvim/lua/pkngr/' ..  module .. '.lua')
end

breq('theme')
breq('cmp')
breq('tree')
breq('telescope')
breq('bar')
breq('notify')
breq('lsp')
breq('lspsaga')
breq('trouble')
breq('which-key')
breq('dashboard')
breq('prettier')
breq('bindings')
