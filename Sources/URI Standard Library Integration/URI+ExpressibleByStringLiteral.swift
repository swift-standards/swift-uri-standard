// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-uri-standard open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-uri-standard project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

public import RFC_3986

extension RFC_3986.URI: @retroactive ExpressibleByStringLiteral {
    /// Constructs a `URI` from a string literal.
    ///
    /// Parses the literal eagerly via `RFC_3986.URI(_:)`. A malformed
    /// literal traps with `fatalError` — literals authored at the call
    /// site are reviewable surface text, so a parse failure indicates
    /// an authoring-time defect that surfaces at build-load time
    /// rather than at the first use. Use the throwing initializer
    /// `RFC_3986.URI(_ value: some StringProtocol)` directly for URIs
    /// whose validity cannot be guaranteed at compile time.
    @inlinable
    public init(stringLiteral value: Swift.String) {
        do {
            self = try RFC_3986.URI(value)
        } catch {
            fatalError("URI literal failed to parse: \(value): \(error)")
        }
    }
}
