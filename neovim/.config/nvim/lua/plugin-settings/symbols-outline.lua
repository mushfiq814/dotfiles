local success, symbols_outline = pcall(require, 'symbols-outline')
if not success then return end
symbols_outline.setup()
