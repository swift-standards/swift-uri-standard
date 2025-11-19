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
import RFC_4648

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
public typealias CharacterSets = Set<Character>.URI

/// Percent-encodes a string according to RFC 3986
///
/// Characters not in the allowed set are encoded as `%HH` where HH is
/// the hexadecimal representation of the octet (uppercase per RFC 3986 Section 6.2.2.2).
/// Uses RFC 4648 hex encoding for the byte-to-hex conversion.
///
/// - Parameters:
///   - string: The string to encode
///   - allowedCharacters: The set of characters that should not be encoded
/// - Returns: The percent-encoded string with UPPERCASE hex
public func percentEncode(
    _ string: String,
    allowing allowedCharacters: Set<Character> = Set<Character>.uri.unreserved
) -> String {
    var result = ""
    for character in string {
        if allowedCharacters.contains(character) {
            result.append(character)
        } else {
            // Encode as UTF-8 bytes and percent-encode each byte using RFC 4648 hex
            for byte in String(character).utf8 {
                result.append("%")
                result.append(String(hexEncoding: [byte], uppercase: true))
            }
        }
    }
    return result
}

/// Decodes a percent-encoded string according to RFC 3986
///
/// Replaces percent-encoded octets (`%HH`) with their corresponding characters.
/// Properly handles multi-byte UTF-8 sequences.
/// Uses RFC 4648 hex decoding for the hex-to-byte conversion.
///
/// - Parameter string: The percent-encoded string to decode
/// - Returns: The decoded string
public func percentDecode(_ string: String) -> String {
    var bytes: [UInt8] = []
    var index = string.startIndex

    while index < string.endIndex {
        if string[index] == "%",
           let nextIndex = string.index(index, offsetBy: 1, limitedBy: string.endIndex),
           let thirdIndex = string.index(index, offsetBy: 3, limitedBy: string.endIndex)
        {
            let hexString = String(string[nextIndex..<thirdIndex])
            if let decoded = [UInt8](hexEncoded: hexString), decoded.count == 1 {
                bytes.append(decoded[0])
                index = thirdIndex
                continue
            }
        }
        // Not a valid percent-encoded sequence, append the character's UTF-8 bytes
        for byte in String(string[index]).utf8 {
            bytes.append(byte)
        }
        index = string.index(after: index)
    }

    return String(decoding: bytes, as: UTF8.self)
}

/// Normalizes percent-encoding per RFC 3986 Section 6.2.2.2
///
/// Uppercase hexadecimal digits in percent-encoded octets and
/// decode any percent-encoded unreserved characters.
///
/// - Parameter string: The string to normalize
/// - Returns: The normalized string
public func normalizePercentEncoding(_ string: String) -> String {
    var result = ""
    var index = string.startIndex

    while index < string.endIndex {
        if string[index] == "%",
           let nextIndex = string.index(index, offsetBy: 1, limitedBy: string.endIndex),
           let thirdIndex = string.index(index, offsetBy: 3, limitedBy: string.endIndex)
        {
            let hexString = String(string[nextIndex..<thirdIndex])

            // Uppercase the hex digits using RFC 4648
            let uppercasedHex = hexString.uppercased()

            // Check if this represents an unreserved character
            if let bytes = [UInt8](hexEncoded: uppercasedHex), bytes.count == 1 {
                let scalar = Unicode.Scalar(bytes[0])
                let character = Character(scalar)

                // If it's unreserved, decode it
                if Set<Character>.uri.unreserved.contains(character) {
                    result.append(character)
                } else {
                    // Keep it encoded with uppercase hex
                    result.append("%")
                    result.append(uppercasedHex)
                }
            } else {
                // Invalid encoding, keep as-is
                result.append(contentsOf: string[index..<thirdIndex])
            }

            index = thirdIndex
        } else {
            result.append(string[index])
            index = string.index(after: index)
        }
    }

    return result
}

// MARK: - Path Normalization

/// Removes dot segments from a path per RFC 3986 Section 5.2.4
public func removeDotSegments(from path: String) -> String {
    RFC_3986.removeDotSegments(from: path)
}
