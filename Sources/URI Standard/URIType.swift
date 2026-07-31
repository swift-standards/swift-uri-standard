// URI Standard
// Unified URI type composing RFC 3986 and related URI specifications
//
// This package composes URI-related RFC implementations into a unified type.
// It remains pure Swift with no Foundation dependencies.
//
// Architecture:
// - swift-rfc-3986: Pure RFC 3986 implementation
// - swift-uri-standard: Composition layer (THIS PACKAGE)
// - coenttb/swift-uri: Foundation integration layer

@_exported import RFC_3986
@_exported import RFC_3987

// MARK: - Unified URI Namespace

/// Unified URI type namespace
///
/// This type composes RFC 3986 and provides a clean, unified API
/// for working with URIs across all Swift platforms.
///
/// Example:
/// ```swift
/// import URI_Standard
///
/// let uri = try URI("https://example.com/path")
/// print(uri.scheme?.value)  // "https"
/// print(uri.host?.rawValue) // "example.com"
/// ```
public typealias URI = RFC_3986.URI

/// Internationalized Resource Identifier per RFC 3987
///
/// Converged from swift-rfc-3987; this package delegates rather than
/// reimplementing the IRI grammar.
public typealias IRI = RFC_3987.IRI

// MARK: - Re-export Core Types

/// URI scheme (e.g., "https", "http", "ftp")
public typealias Scheme = RFC_3986.URI.Scheme

/// URI host component
public typealias Host = RFC_3986.URI.Host

/// URI port component
public typealias Port = RFC_3986.URI.Port

/// URI path component
public typealias Path = RFC_3986.URI.Path

/// URI query component
public typealias Query = RFC_3986.URI.Query

/// URI fragment component
public typealias Fragment = RFC_3986.URI.Fragment

/// URI authority component
public typealias Authority = RFC_3986.URI.Authority

/// URI userinfo component (deprecated per RFC 3986)
public typealias Userinfo = RFC_3986.URI.Userinfo

// MARK: - Protocols

/// Protocol for types that can be represented as URIs
public typealias URIRepresentable = RFC_3986.URIRepresentable

// MARK: - Error Types

/// Errors that can occur when working with URIs
public typealias URIError = RFC_3986.Error

// MARK: - Validation Functions

/// Validates if a string is a valid URI per RFC 3986
public func isValidURI(_ string: String) -> Bool {
    RFC_3986.isValidURI(string)
}

/// Validates if a URI is a valid HTTP(S) URI
public func isValidHTTP(_ uri: some URIRepresentable) -> Bool {
    RFC_3986.isValidHTTP(uri)
}

/// Validates if a string is a valid HTTP(S) URI
public func isValidHTTP(_ string: String) -> Bool {
    RFC_3986.isValidHTTP(string)
}

// MARK: - Percent Encoding

/// Character sets defined in RFC 3986
public typealias CharacterSets = Set<Character>.URI

// Percent-encoding, decoding, and normalization are provided by the
// re-exported RFC_3986 engine: `RFC_3986.percentEncode(_:allowing:)`,
// `RFC_3986.percentDecode(_:)`, `RFC_3986.normalizePercentEncoding(_:)`,
// and the `String.percentEncoded(allowing:)` / `String.percentDecoded()`
// conveniences. This package deliberately does not reimplement them.

// MARK: - Path Normalization

/// Removes dot segments from a path per RFC 3986 Section 5.2.4
public func removeDotSegments(from path: String) -> String {
    RFC_3986.removeDotSegments(from: path)
}
