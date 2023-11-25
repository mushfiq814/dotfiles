-- reset all listchars and fillchars for dashboard
-- these will be set again in config/settings
vim.opt_local.listchars = {
  tab =      '  ',
  precedes = ' ',
  extends =  ' ',
  space =    ' ',
  trail =    ' ',
}
vim.opt_local.fillchars = {
  horiz =     ' ',
  horizup =   ' ',
  horizdown = ' ',
  vert =      ' ',
  vertleft =  ' ',
  vertright = ' ',
  verthoriz = ' ',
  fold =      ' ',
  foldopen =  ' ',
  foldclose = ' ',
  foldsep =   ' ',
  diff =      ' ',
  msgsep =    ' ',
  eob =       ' ',
  lastline =  ' ',
}
