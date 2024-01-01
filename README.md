# overlaid

[![License](https://img.shields.io/badge/license-GPLv2-9977bb.svg?style=plastic)](https://github.com/wltjr/overlaid/blob/master/LICENSE)

## About

Overlaid a.k.a wltjr's Gentoo overlay, the remains of
[os-xtoo](https://github.com/Obsidian-StudiosInc/os-xtoo) overlay. Prepare to
be OVERLAID...

## Warning

Please read subsequent sections before usage, this overlay is not intended
for public consumption. Why public? Good question, it may not always be...
Use at your own risk and peril!

## Issues

Feel free to open any issues with any package in this repository, 
problems, version bumps, etc. They may or may not be addressed, depending
on if the personal impact and interest. Issues and PRs maybe disabled
entirely at times, or permanently.

## Layman

You can add this overlay to layman as an external git repo, but should you?

```toml
/etc/portage/repos.conf/overlaid.conf

[overlaid]
location = /var/db/repo/overlaid
sync-type = git
sync-uri = https://github.com/wltjr/overlaid.git
auto-sync = yes
```

## Profiles

This repository features a few different profiles that are not based on
any profile in Gentoo's main repository. They are stand alone profiles
intended for personal usage, use them at your own risk.
