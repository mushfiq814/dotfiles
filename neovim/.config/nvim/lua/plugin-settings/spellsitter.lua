local success, spellsitter = pcall(require, 'spellsitter')
if not success then return end

spellsitter.setup {
  hl = 'SpellBad',
  captures = { 'comment' },  -- set to {} to spellcheck everything
}
