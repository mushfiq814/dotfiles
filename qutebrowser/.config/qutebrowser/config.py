from colors import *
from font import *
from qutebrowser.mainwindow import tabwidget

config.load_autoconfig(False)

c.content.autoplay = False
c.content.notifications.enabled = False
c.downloads.location.directory = '~/downloads'
c.editor.command = ['kitty', '--class', 'floating', '-e', 'nvim', '{file}', '-c','normal {line}G{column0}1']
c.statusbar.padding = {"bottom": 5, "left": 5, "right": 5, "top": 5}
c.statusbar.widgets = ["url", "search_match", "scroll", "progress"]
c.tabs.favicons.scale = 1.2
c.tabs.indicator.width = 0
c.tabs.padding = {"bottom": 5, "left": 5, "right": 5, "top": 5}
c.tabs.title.format = '{audio} {current_title}'
c.tabs.title.format_pinned = ''
c.window.title_format = '{current_title}'
c.window.transparent = True

# colors
c.colors.completion.category.bg = GREY0
c.colors.completion.category.border.bottom = BLACK
c.colors.completion.category.border.top = BLACK
c.colors.completion.category.fg = BRIGHT_PURPLE
c.colors.completion.even.bg = BLACK
c.colors.completion.fg = [BRIGHT_BLUE, WHITE, WHITE]
c.colors.completion.item.selected.bg = BRIGHT_YELLOW
c.colors.completion.item.selected.fg = BLACK
c.colors.completion.item.selected.match.fg = NEUTRAL_PURPLE
c.colors.completion.match.fg = NEUTRAL_PURPLE
c.colors.completion.odd.bg = BLACK
c.colors.completion.scrollbar.fg = WHITE
c.colors.contextmenu.disabled.bg = GREY0
c.colors.contextmenu.disabled.fg = GREY3
c.colors.contextmenu.menu.bg = GREY0
c.colors.contextmenu.menu.fg = WHITE
c.colors.contextmenu.selected.bg = GREY1
c.colors.contextmenu.selected.fg = WHITE
c.colors.downloads.bar.bg = BLACK
c.colors.downloads.error.bg = BRIGHT_RED
c.colors.downloads.error.fg = WHITE
c.colors.downloads.start.bg = NEUTRAL_BLUE
c.colors.downloads.start.fg = BLACK
c.colors.downloads.stop.bg = NEUTRAL_GREEN
c.colors.downloads.stop.fg = BLACK
c.colors.hints.bg = WHITE
c.colors.hints.fg = BLACK
c.colors.hints.match.fg = BRIGHT_PURPLE
c.colors.messages.error.bg = BRIGHT_RED
c.colors.messages.error.fg = BLACK
c.colors.messages.info.bg = BLACK
c.colors.messages.info.fg = WHITE
c.colors.statusbar.command.bg = GREY0
c.colors.statusbar.command.fg = WHITE
c.colors.statusbar.insert.bg = BRIGHT_BLUE
c.colors.statusbar.insert.fg = WHITE
c.colors.statusbar.normal.bg = BLACK
c.colors.statusbar.normal.fg = WHITE
c.colors.statusbar.passthrough.bg = BRIGHT_PURPLE
c.colors.statusbar.passthrough.fg = WHITE
c.colors.statusbar.progress.bg = BLACK
c.colors.statusbar.url.error.fg = BRIGHT_RED
c.colors.statusbar.url.fg = WHITE
c.colors.statusbar.url.hover.fg = BRIGHT_AQUA
c.colors.statusbar.url.success.http.fg = NEUTRAL_GREEN
c.colors.statusbar.url.success.https.fg = BRIGHT_GREEN
c.colors.statusbar.url.warn.fg = BRIGHT_YELLOW
c.colors.tabs.bar.bg = GREY1
c.colors.tabs.even.bg = GREY1
c.colors.tabs.even.fg = GREY5
c.colors.tabs.odd.bg = GREY1
c.colors.tabs.odd.fg = GREY5
c.colors.tabs.pinned.even.bg = GREY1
c.colors.tabs.pinned.even.fg = WHITE
c.colors.tabs.pinned.odd.bg = GREY1
c.colors.tabs.pinned.odd.fg = WHITE
c.colors.tabs.pinned.selected.even.bg = BLACK
c.colors.tabs.pinned.selected.even.fg = WHITE
c.colors.tabs.pinned.selected.odd.bg = BLACK
c.colors.tabs.pinned.selected.odd.fg = WHITE
c.colors.tabs.selected.even.bg = BLACK
c.colors.tabs.selected.even.fg = WHITE
c.colors.tabs.selected.odd.bg = BLACK
c.colors.tabs.selected.odd.fg = WHITE
c.colors.webpage.bg = BLACK
c.colors.webpage.darkmode.enabled = MODE == "dark"
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.contrast = 1
c.colors.webpage.darkmode.policy.images = "smart"
c.colors.webpage.darkmode.policy.page = "smart"
c.colors.webpage.darkmode.threshold.background = 205
c.colors.webpage.darkmode.threshold.foreground = 150
c.colors.webpage.preferred_color_scheme = MODE

# site permissions
with config.pattern('https://mail.google.com') as p:
    p.content.register_protocol_handler = False
with config.pattern('https://calendar.google.com') as p:
    p.content.register_protocol_handler = False

# clipboard access
with config.pattern('https://github.com') as p:
    p.content.javascript.clipboard = "access-paste"
with config.pattern('https://bitwarden.com') as p:
    p.content.javascript.clipboard = "access-paste"

c.fonts.default_family = MONO_FONT
c.fonts.default_size = str(FONT_SIZE) + 'pt'
c.fonts.completion.entry = 'default_size default_family'
c.fonts.debug_console = 'default_size default_family'
c.fonts.prompts = 'default_size default_family'
c.fonts.statusbar = 'default_size default_family'
c.fonts.web.family.cursive = REGULAR_FONT
c.fonts.web.family.fantasy = REGULAR_FONT
c.fonts.web.family.fixed = MONO_FONT
c.fonts.web.family.sans_serif = REGULAR_FONT
c.fonts.web.family.serif = REGULAR_FONT
c.fonts.web.family.standard = 'default_family'
c.fonts.tabs.selected = str(FONT_SIZE - 2) + 'pt default_family'
c.fonts.tabs.unselected= str(FONT_SIZE - 2) + 'pt default_family'
c.fonts.hints = str(FONT_SIZE - 2) + 'pt default_family'

# tab icons
tabwidget.TabWidget.MUTE_STRING = "🔇"
tabwidget.TabWidget.AUDIBLE_STRING = "🔊"

# bindings for normal mode
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('Y', 'spawn mpv {url}')
config.bind('C', 'hint links spawn kitty -e yt-dlp --paths $HOME/music/downloaded --extract-audio --audio-format mp3 {hint-url}')
config.bind('X', 'spawn kitty -e yt-dlp --paths $HOME/music/downloaded --extract-audio --audio-format mp3 {url}')
config.bind('Z', 'hint links spawn st -e youtube-dl {hint-url}')
config.bind('t', 'set-cmd-text -s :open -t')
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
config.bind('gt', 'tab-next')
config.bind('gT', 'tab-prev')

# TODO: open editor (maybe have special config for nvim just for editing with qutebrowser?)
# TODO: find out if image popout can be implemented
# TODO: bitwarden integration
# TODO: youtube player controls (shift + >, j, k, l, etc.)
# TODO: auto type site:reddit.com prefix
# TODO: better status bar?
# TODO: show url in header?
# TODO: prompts color
