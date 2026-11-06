import Byte
public import RFC_3986

extension RFC_3986.URI {
    public enum Canonicalization {}
}

extension RFC_3986.URI {

    public func canonical(
        authority: RFC_3986.URI.Authority
    ) throws(RFC_3986.URI.Canonicalization.Error) -> RFC_3986.URI {
        if let port = authority.port, port.value == 0 {
            throw .port(.range(0))
        }

        var value = ""
        if let scheme = self.scheme {
            value += "\(scheme.value):"
        }
        var host: [Byte] = []
        RFC_3986.URI.Host.serialize(authority.host, into: &host)
        value += "//\(String(decoding: host, as: UTF8.self))"
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
}

extension RFC_3986.URI.Canonicalization {

    /// The authority `text` spells as `host` or `host:port`, with the reason it spells none.
    public static func authority(
        _ text: String
    ) throws(RFC_3986.URI.Canonicalization.Error) -> RFC_3986.URI.Authority {
        guard !text.isEmpty else {
            throw .host(.empty)
        }

        do throws(RFC_3986.URI.Authority.Error) {
            return try RFC_3986.URI.Authority(text)
        } catch {
            if let port = Self.port(in: text) {
                if let value = Int(port) {
                    throw .port(.range(value))
                }
                throw .port(.invalid(port))
            }
            throw .host(.invalid(text))
        }
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
