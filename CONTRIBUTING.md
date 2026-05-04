# Contributing to the HASP Homebrew Tap

This repository is a small public packaging surface for HASP. Keep changes
narrow and specific to Homebrew installation.

## What belongs here

- fixes to `Formula/hasp.rb`
- installation documentation for Homebrew users
- tap repository maintenance files

## What does not belong here

- HASP product source code
- release binaries or generated tarballs
- private release notes or internal planning docs
- credentials, tokens, deploy keys, or secret material

Formula version and checksum updates normally come from the HASP release
workflow. Avoid hand-editing them unless you are correcting a broken public
release and have verified the published artifacts.

## Verification

Run these checks before opening a pull request:

```bash
ruby -c Formula/hasp.rb
brew audit --formula gethasp/tap/hasp
brew fetch --force gethasp/tap/hasp
```

If you changed installation behavior, also test a local install path:

```bash
brew install --force Formula/hasp.rb
hasp version
```

## Pull requests

- Keep each pull request about one issue.
- Explain why the change is needed.
- Link the matching HASP release or issue when the formula changes.
- Update `README.md`, `SECURITY.md`, or `SUPPORT.md` when behavior or support
  paths change.
