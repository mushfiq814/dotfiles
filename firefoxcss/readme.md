# Setup custom userchrome.css support in firefox

[Link to reddit guide post](https://www.reddit.com/r/FirefoxCSS/comments/73dvty/tutorial_how_to_create_and_livedebug_userchromecss/)


## Enable `userChrome.css` support for firefox v69+
> To improve performance, Firefox 69 and later will disable loading of `userChrome.css` and `userContent.css` by default.

To enable, set the pref `toolkit.legacyUserProfileCustomizations.stylesheets` to `true` in `about:config`.

## Create `userchrome.css`
* Open about:support
* Get profile directory path from "Profile Directory"
* Go to profile directory
* create 'chrome/userChrome.css'
* add custom css to `userChrome.css`
* Restart to apply changes.

**Note**: Apply firefox Default (Dark) theme for best results.
