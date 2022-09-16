import openrazer.client
kbd = openrazer.client.DeviceManager().devices[0]

# from https://stackoverflow.com/questions/29643352/converting-hex-to-rgb-value-in-python
def hex_to_rgb(value):
    value = value.lstrip('#')
    lv = len(value)
    return tuple(int(value[i:i + lv // 3], 16) for i in range(0, lv, lv // 3))

colors = [
    '#9d0006',
    '#fe8019',
    '#b57614',
    '#fabd2f',
    '#458588',
    '#076678',
]
for i in range(0,6):
    for j in range(1,16):
        kbd.fx.advanced.matrix[i,j] = hex_to_rgb(colors[i])

kbd.fx.advanced.draw()
