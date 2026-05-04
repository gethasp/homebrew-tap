# Homebrew Tap for HASP

This is the official Homebrew tap for [HASP](https://gethasp.com), a
local-first broker for managed secrets in agent workflows.

The tap contains only Homebrew formula metadata. Product source, release
notes, signed release assets, and security policy live in the public HASP
repository: <https://github.com/gethasp/hasp>.

## Install

```bash
brew install gethasp/tap/hasp
```

Or add the tap first:

```bash
brew tap gethasp/tap
brew install hasp
```

Verify the installed CLI:

```bash
hasp version
```

## Upgrade

```bash
brew update
brew upgrade hasp
```

If Homebrew still resolves an older formula, refresh this tap explicitly:

```bash
brew update gethasp/tap
brew reinstall hasp
```

## Repository Scope

This repository should stay small:

- `Formula/hasp.rb` is the single public Homebrew formula.
- Release artifacts are served from `downloads.gethasp.com`.
- GitHub Releases and binary assets do not belong in this tap repository.
- Formula updates are produced by the HASP release workflow.

Do not add source archives, binaries, generated release bundles, credentials,
or private release notes to this repository.

## Maintainer Checks

Before pushing a formula or documentation change:

```bash
ruby -c Formula/hasp.rb
brew audit --formula gethasp/tap/hasp
brew fetch --force gethasp/tap/hasp
```

For release updates, also verify that the published formula installs the latest
public HASP version:

```bash
brew uninstall --ignore-dependencies hasp || true
brew install gethasp/tap/hasp
hasp version
```

## Support

Install and tap issues can be opened in this repository. Product bugs,
security issues, and feature requests belong in
[gethasp/hasp](https://github.com/gethasp/hasp).

For security reports, follow [SECURITY.md](SECURITY.md).
