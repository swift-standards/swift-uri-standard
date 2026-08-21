public import RFC_3986

extension RFC_3986.URI.Canonicalization.Error {
    public enum Host: Equatable, Sendable {
        case empty
        case invalid(String)
    }
}
