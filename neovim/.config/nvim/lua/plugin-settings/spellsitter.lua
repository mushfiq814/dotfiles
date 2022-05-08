local success, spellsitter = pcall(require, 'spellsitter')
if not success then return end

spellsitter.setup {
  enabled = true,
  hl = 'SpellBad',
  captures = { 'comment' },  -- set to {} to spellcheck everything
}
