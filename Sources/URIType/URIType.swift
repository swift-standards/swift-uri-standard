// URIType
// Unified URI type composing RFC 3986 and related URI specifications
//
// This package composes URI-related RFC implementations into a unified type.
// It remains pure Swift with no Foundation dependencies.
//
// Architecture:
// - swift-rfc-3986: Pure RFC 3986 implementation
// - swift-uri-type: Composition layer (THIS PACKAGE)
// - coenttb/swift-uri: Foundation integration layer

@_exported import RFC_3986

// MARK: - Unified URI Namespace

/// Unified URI type namespace
///
/// This type composes RFC 3986 and provides a clean, unified API
/// for working with URIs across all Swift platforms.
///
/// Example:
/// ```swift
/// import URIType
///
/// let uri = try URI("https://example.com/path")
/// print(uri.scheme?.value)  // "https"
/// print(uri.host?.rawValue) // "example.com"
/// ```
public typealias URI = RFC_3986.URI

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
public func isValidHTTP(_ uri: any URIRepresentable) -> Bool {
    RFC_3986.isValidHTTP(uri)
}

/// Validates if a string is a valid HTTP(S) URI
public func isValidHTTP(_ string: String) -> Bool {
    RFC_3986.isValidHTTP(string)
}

// MARK: - Percent Encoding

/// Character sets defined in RFC 3986
public typealias CharacterSets = RFC_3986.CharacterSets

/// Percent-encodes a string according to RFC 3986
public func percentEncode(
    _ string: String,
    allowing allowedCharacters: Set<Character> = CharacterSets.unreserved
) -> String {
    RFC_3986.percentEncode(string, allowing: allowedCharacters)
}

/// Decodes a percent-encoded string according to RFC 3986
public func percentDecode(_ string: String) -> String {
    RFC_3986.percentDecode(string)
}

/// Normalizes percent-encoding per RFC 3986 Section 6.2.2.2
public func normalizePercentEncoding(_ string: String) -> String {
    RFC_3986.normalizePercentEncoding(string)
}

// MARK: - Path Normalization

/// Removes dot segments from a path per RFC 3986 Section 5.2.4
public func removeDotSegments(from path: String) -> String {
    RFC_3986.removeDotSegments(from: path)
}
