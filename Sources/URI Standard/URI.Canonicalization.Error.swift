public import RFC_3986

extension RFC_3986.URI.Canonicalization {
    public enum Error: Swift.Error, Equatable {
        case host(Host)
        case port(Port)
    }
}
