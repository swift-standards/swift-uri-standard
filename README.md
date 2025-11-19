# URI Standard

Unified URI type composing RFC 3986 and related URI specifications.

## Overview

`URI Standard` is a pure Swift package that composes URI-related RFC implementations into a clean, unified API. It provides a composition layer over `swift-rfc-3986` without adding Foundation dependencies.

## Architecture

This package is part of a three-layer architecture:

1. **swift-rfc-3986**: Pure RFC 3986 implementation (no Foundation)
2. **swift-uri-standard**: Composition layer (THIS PACKAGE - no Foundation)
3. **coenttb/swift-uri**: Foundation integration layer

## Features

- ✅ Pure Swift - no Foundation dependencies
- ✅ Portable to all Swift platforms
- ✅ Clean, unified API
- ✅ Re-exports RFC 3986 types with simpler names
- ✅ Full RFC 3986 compliance
- ✅ Comprehensive validation
- ✅ Percent encoding/decoding
- ✅ Path normalization

## Usage

### Creating URIs

```swift
import URI_Standard

// Create a URI
let uri = try URI("https://example.com/path")

// Access components
print(uri.scheme?.value)  // "https"
print(uri.host?.rawValue) // "example.com"
print(uri.path?.string)   // "/path"
```

### Validation

```swift
// Validate URI strings
isValidURI("https://example.com")  // true
isValidHTTP("https://example.com") // true
```

### Percent Encoding

```swift
// Encode strings for URIs
let encoded = percentEncode("hello world")
// "hello%20world"

// Decode percent-encoded strings
let decoded = percentDecode("hello%20world")
// "hello world"
```

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-uri-standard.git", from: "1.0.0")
]
```

## Requirements

- Swift 6.2+
- macOS 14.0+, iOS 17.0+, tvOS 17.0+, watchOS 10.0+
- No platform-specific dependencies
- Pure Swift implementation

## Documentation

For detailed documentation, see the individual type documentation in Xcode or generated documentation.

## License

Apache 2.0

## Related Packages

- [swift-rfc-3986](https://github.com/swift-standards/swift-rfc-3986) - RFC 3986 implementation
- [swift-uri](https://github.com/coenttb/swift-uri) - Foundation integration layer
