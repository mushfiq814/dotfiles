# Tweak to avail custom html for Firefox New Tab Page
By default Firefox has disable customizing the new tab page. In order to use the included html start page as a new tab page, please do the following.

* go to the Firefox install dir. For Windows 10, it is:

```sh
/mnt/c/Program Files/Mozilla Firefox # WSL
C:\Program Files\Mozilla Firefox # PS
```

* create `defaults/pref/autoconfig.js` and write the following:

  ```js
  //
  pref("general.config.filename", "autoconfig.cfg");
  pref("general.config.obscure_value", 0);
  pref("general.config.sandbox_enabled", false);
  ```
  
* create `autoconfig.cfg` and write the following:

  ```cfg
  //
  var { classes:Cc, interfaces:Ci, utils:Cu } = Components;

  // set new tab page
  try {
    Cu.import("resource:///modules/AboutNewTab.jsm");
    var newTabURL = "PATH_TO_CUSTOM_STARTPAGE";
    AboutNewTab.newTabURL = newTabURL;
  } catch(e){Cu.reportError(e);} // report errors in the Browser Console
  ```
  
  **Note**: replace `PATH_TO_CUSTOM_STARTPAGE` with the path to the relevant index.html file.
  
* restart firefox.
