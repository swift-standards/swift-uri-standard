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

extension RFC_3986.URI.Canonicalization.Error {
    public enum Port: Equatable, Sendable {
        case invalid(String)
        case range(Int)
    }
}
