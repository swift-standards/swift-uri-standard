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

/// Canonical URI authority replacement for consumers that select one host.
extension RFC_3986.URI {
    public enum Canonicalization {}
}

extension RFC_3986.URI {
    /// Returns `uri` with its authority host replaced by `host`.
    ///
    /// The path, query, fragment, and optional scheme are preserved. Omitting a
    /// port from `host` removes any port from the result. This operation only
    /// constructs a canonical URI; redirect policy belongs to the HTTP layer.
    ///
    /// This is a composed operation on the RFC 3986 URI type; it is distinct
    /// from RFC 3986 Section 6 syntax-based normalization, which is available
    /// separately as `normalized()`. Compose them for a fully canonical result:
    /// `uri.canonical(host:).normalized()`.
    public func canonical(
        host: String
    ) throws(RFC_3986.URI.Canonicalization.Error) -> RFC_3986.URI {
        guard !host.isEmpty else {
            throw .host(.empty)
        }

        let authority: RFC_3986.URI.Authority
        do throws(RFC_3986.URI.Authority.Error) {
            authority = try RFC_3986.URI.Authority(host)
        } catch {
            if let port = Self.port(in: host) {
                if let value = Int(port) {
                    throw .port(.range(value))
                }
                throw .port(.invalid(port))
            }
            throw .host(.invalid(host))
        }

        if let port = authority.port, port.value == 0 {
            throw .port(.range(0))
        }

        var value = ""
        if let scheme = self.scheme {
            value += "\(scheme.value):"
        }
        value += "//\(authority.host.description)"
        if let port = authority.port {
            value += ":\(port.value)"
        }
        value += self.path?.description ?? ""
        if let query = self.query {
            value += "?\(query.description)"
        }
        if let fragment = self.fragment {
            value += "#\(fragment.value)"
        }

        return RFC_3986.URI(unchecked: value)
    }

    private static func port(in authority: String) -> String? {
        if authority.hasPrefix("[") {
            guard let close = authority.firstIndex(of: "]") else {
                return nil
            }
            let suffix = authority[authority.index(after: close)...]
            guard suffix.first == ":" else {
                return nil
            }
            return String(suffix.dropFirst())
        }

        guard let colon = authority.firstIndex(of: ":") else {
            return nil
        }
        return String(authority[authority.index(after: colon)...])
    }
}
