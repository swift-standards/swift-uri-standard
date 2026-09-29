# URI Standard

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

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
- ✅ Byte-based percent encoding/decoding through RFC 3986
- ✅ Path normalization
- ✅ Host canonicalization

## Usage

### Creating URIs

```swift
import URI_Standard

// Create a URI
let uri = try URI("https://example.com/path")

// Access components
print(uri.scheme?.value)             // "https"
print(uri.host?.registeredNameValue) // "example.com"
print(uri.path?.description)         // "/path"
```

### Validation

```swift
// Validate URI strings
isValidURI("https://example.com")  // true
isValidHTTP("https://example.com") // true
```

### Canonical Host

```swift
let uri = URI(unchecked: "https://example.com:8080/path")
let canonical = try uri.canonical(host: "canonical.com:9090")
// "https://canonical.com:9090/path"
```

### Percent Encoding

```swift
// Percent coding operates on bytes and is provided by RFC 3986
let encoded = RFC_3986.percentEncode(Array("hello world".utf8))
// "hello%20world" as bytes

let decoded = RFC_3986.percentDecode(Array("hello%20world".utf8))
// "hello world" as bytes
```

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-uri-standard.git", from: "0.1.4")
]
```

Add the product to your target:

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "URI Standard", package: "swift-uri-standard")
    ]
)
```

The package also vends `URI Standard Library Integration` for standard-library interoperation.

## Requirements

- Swift 6.4+
- macOS 27.0+, iOS 27.0+, tvOS 27.0+, watchOS 27.0+
- No platform-specific dependencies
- Pure Swift implementation

## Documentation

For detailed documentation, see the individual type documentation in Xcode or generated documentation.

## License

Apache 2.0

## Related Packages

- [swift-rfc-3986](https://github.com/swift-ietf/swift-rfc-3986) - RFC 3986 domain model
- [swift-rfc-3986-coder](https://github.com/swift-ietf/swift-rfc-3986-coder) - RFC 3986 wire coders
- [swift-rfc-3987](https://github.com/swift-ietf/swift-rfc-3987) - RFC 3987 IRI model
- [swift-uri](https://github.com/swift-compositions/swift-uri) - Composition integration layer
