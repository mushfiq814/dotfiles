# NeoMutt Email Client

## Setup
For Google mail, app passwords need to be set up.

1. Go to [Account Settings](https://myaccount.google.com/u/0/apppasswords). (**Note** the `0` in the url might be different depending on how many Google accounts you are logged in and which one you are trying to access).
2. Set up App Password for a custom app. Name it `mutt` for example.
3. Copy the generated app password and put it in a `password` in your mutt config directory. An example is provided in `~/.config/mutt/password.example`

```sh
$ echo "set smtp_pass=\"PASSWORD\"" > ~/.config/mutt/password
```

## Securing password with GPG

Rather than store passwords as plain text, encrypt them with gpg. For a full guide, consult [one of many articles on the internet](https://www.linuxbabe.com/security/a-practical-guide-to-gpg-part-1-generate-your-keypair). But the first step is:
```sh
$ gpg --full-gen-key
```

Encrypt the password file

```sh
$ gpg -r YOUR@EMAIL.COM -e ~/.config/mutt/password
```

This will produce a `password.gpg` file which can be sourced in the `muttrc`.

```bashrc
source "gpg -d ~/.config/mutt/password.gpg |"
```

