public import RFC_3986

extension RFC_3986.URI.Canonicalization.Error {
    public enum Port: Equatable, Sendable {
        case invalid(String)
        case range(Int)
    }
}
