public import RFC_3986

extension RFC_3986.URI: @retroactive ExpressibleByStringLiteral {

    @inlinable
    public init(stringLiteral value: Swift.String) {
        do throws(RFC_3986.Error) {
            self = try RFC_3986.URI(value)
        } catch {
            fatalError("URI literal failed to parse: \(value): \(error)")
        }
    }
}
