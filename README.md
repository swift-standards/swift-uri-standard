# swift-uri-standard

Use this package when you want one import for URIs and IRIs, so code can write `URI` and `IRI` instead of `RFC_3986.URI` and `RFC_3987.IRI`. It also adds `RFC_3986.URI.canonical(authority:)` for moving a URI to a canonical host. Add `URI Standard Library Integration` if you want to write URIs as string literals. If you only need the RFC 3986 rules, use swift-rfc-3986 directly.

## Laws

- `RFC_3986.URI.canonical(authority:)` replaces the host and port with the ones given and keeps the scheme, path, query and fragment. It keeps the userinfo too: the given one if any, otherwise the original. A host given without a port drops the original port. A port given explicitly is kept, even when it is the scheme's default such as 443.
- `RFC_3986.URI.Canonicalization.authority(_:)` accepts a bracketed IPv6 address with a port. It refuses an empty host, a port that is not a number, and a port of 0 or above 65535.
- With `URI Standard Library Integration`, a string literal that is not a valid URI traps at run time.
