# Related i3 config

## Installing i3-gaps

* Follow [this guide](https://gist.github.com/boreycutts/6417980039760d9d9dac0dd2148d4783)
* Instead of `autoreconf --force --install` and all following steps, do this
```bash
meson build
ninja -C build/ install
```

## Mouse

[source](https://github.com/maxwell-bland/i3-natural-scrolling-and-tap/blob/master/inverse-scroll.sh)
```bash
# get device IDs
xinput list

# get device properties
xinput list-props <deviceId>

# change device properties
xinput --set-prop <deviceIdhttps://github.com/maxwell-bland/i3-natural-scrolling-and-tap/blob/master/inverse-scroll.sh> <propId> <value>
```

## Keyboard
```bash
xset r rate [delay [rate]]
xset r rate 200 90
# the delay is the number of milliseconds will be waited before repeated presses work
# the rate is from 0-100 and represents the repeat rate. The above values are my preferred values
```
