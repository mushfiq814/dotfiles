from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb

layout_icons = {
    "fat": "󱂩",  # 󰯋
    "tall": "󱂫",  # 󰯌
    "stack": "",
    "grid": "",
    "horizontal": "",
    "vertical": "",
    "splits": "󰕮",
}


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData
) -> int:
    opts = get_options()

    colors = {
        "default": as_rgb(int(draw_data.default_bg)),

        "black": as_rgb(int(opts.color0)),
        "grey0": as_rgb(int(draw_data.inactive_bg)),
        "grey1": as_rgb(int(opts.color8)),
        "grey3": as_rgb(int(opts.color7)),
        "grey5": as_rgb(int(draw_data.active_bg)),
        "white": as_rgb(int(opts.color15)),

        "bright_red": as_rgb(int(opts.color1)),
        "bright_green": as_rgb(int(opts.color2)),
        "bright_yellow": as_rgb(int(opts.color3)),
        "bright_blue": as_rgb(int(opts.color4)),
        "bright_purple": as_rgb(int(opts.color5)),
        "bright_aqua": as_rgb(int(opts.color6)),
        "neutral_red": as_rgb(int(opts.color9)),
        "neutral_green": as_rgb(int(opts.color10)),
        "neutral_yellow": as_rgb(int(opts.color11)),
        "neutral_blue": as_rgb(int(opts.color12)),
        "neutral_purple": as_rgb(int(opts.color13)),
        "neutral_aqua": as_rgb(int(opts.color14)),
    }

    if index == 1:
        screen.cursor.bg = colors["default"]
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
    screen.cursor.bg = colors["default"]
    screen.draw(" ")

    if tab.is_active:
        BG0 = colors["bright_yellow"]
        FG0 = colors["black"]
        BG1 = colors["neutral_yellow"]
        FG1 = colors["black"]
    else:
        BG0 = colors["grey0"]
        FG0 = colors["bright_yellow"]
        BG1 = colors["grey1"]
        FG1 = colors["grey5"]

    screen.cursor.bg = BG0
    screen.cursor.fg = FG0
    screen.draw(f" {layout_icons[tab.layout_name]} {str(tab.num_windows)} ")

    print(extra_data)

    screen.cursor.bg = BG1
    screen.cursor.fg = FG1
    screen.draw(" ")
    draw_title(draw_data, screen, tab, index)
    screen.draw(" ")

    return screen.cursor.x
