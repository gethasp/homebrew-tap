# Security Policy

Do not open a public issue for a vulnerability.

## Reporting a Vulnerability

For vulnerabilities in HASP itself, use private vulnerability reporting in the
public product repository:

<https://github.com/gethasp/hasp/security/advisories/new>

For tap-specific security issues, such as an incorrect download URL, checksum
mismatch, or install path that could execute unexpected code, report privately
through GitHub first and avoid posting exploit details in public.

Include:

- what you found
- which formula version or commit is affected
- how to reproduce it
- any workaround you know about

## Supported Scope

Security fixes should be assumed for:

- the current `main` branch
- the latest public HASP release referenced by `Formula/hasp.rb`

Older formula history and removed tags do not receive separate backports.
