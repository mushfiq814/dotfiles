local success, telescope = pcall(require, 'telescope')
if not success then return end
telescope.load_extension('media_files')
