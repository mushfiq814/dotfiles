from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb

opts = get_options()

colors = {
    "black": as_rgb(int(opts.color0)),
    "grey1": as_rgb(int(opts.color8)),
    "bright_red": as_rgb(int(opts.color1)),
    "neutral_red": as_rgb(int(opts.color9)),
    "bright_green": as_rgb(int(opts.color2)),
    "neutral_green": as_rgb(int(opts.color10)),
    "bright_yellow": as_rgb(int(opts.color3)),
    "neutral_yellow": as_rgb(int(opts.color11)),
    "bright_blue": as_rgb(int(opts.color4)),
    "neutral_blue": as_rgb(int(opts.color12)),
    "bright_purple": as_rgb(int(opts.color5)),
    "neutral_purple": as_rgb(int(opts.color13)),
    "bright_aqua": as_rgb(int(opts.color6)),
    "neutral_aqua": as_rgb(int(opts.color14)),
    "grey3": as_rgb(int(opts.color7)),
}

layout_icons = {
    "fat": "󱂩", # 󰯋
    "tall": "󱂫", # 󰯌
    "stack": "",
    "grid": "",
    "horizontal": "",
    "vertical": "",
    "splits": "󰕮",
}


def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:

    if index == 1:
        screen.cursor.bg = as_rgb(int(draw_data.default_bg))
        screen.draw(" ")
        screen.cursor.bg = colors["neutral_aqua"]
        screen.draw("  ")
        screen.cursor.bg = colors["neutral_blue"]
        screen.draw("  ")
        screen.cursor.bg = colors["neutral_yellow"]
        screen.draw("  ")
        screen.cursor.bg = colors["neutral_red"]
        screen.draw("  ")

    # preceding separator
    screen.cursor.bg = as_rgb(int(draw_data.default_bg))
    screen.draw(" ")

    if tab.is_active:
        BG0 = as_rgb(int(opts.color3))
        FG0 = as_rgb(int(opts.color0))
        BG1 = as_rgb(int(opts.color11))
        FG1 = as_rgb(int(opts.color0))
    else:
        BG0 = as_rgb(int(draw_data.inactive_bg))
        FG0 = as_rgb(int(opts.color3))
        BG1 = as_rgb(int(opts.color8))
        FG1 = as_rgb(int(draw_data.active_bg))

    screen.cursor.bg = BG0
    screen.cursor.fg = FG0
    screen.draw("  ")
    # screen.draw(str(index))
    screen.draw(str(tab.num_windows))
    screen.draw(" ")
    screen.draw(layout_icons[tab.layout_name])
    screen.draw(" ")

    screen.cursor.bg = BG1
    screen.cursor.fg = FG1
    screen.draw(" ")
    draw_title(draw_data, screen, tab, index)
    screen.draw(" ")

    return screen.cursor.x
