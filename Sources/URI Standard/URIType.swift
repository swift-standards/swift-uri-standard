@_exported import RFC_3986
@_exported import RFC_3987

public typealias URI = RFC_3986.URI

public typealias IRI = RFC_3987.IRI

public typealias Scheme = RFC_3986.URI.Scheme

public typealias Host = RFC_3986.URI.Host

public typealias Port = RFC_3986.URI.Port

public typealias Path = RFC_3986.URI.Path

public typealias Query = RFC_3986.URI.Query

public typealias Fragment = RFC_3986.URI.Fragment

public typealias Authority = RFC_3986.URI.Authority

public typealias Userinfo = RFC_3986.URI.Userinfo

public typealias URIRepresentable = RFC_3986.URIRepresentable

public typealias URIError = RFC_3986.Error

public func isValidURI(_ string: String) -> Bool {
    RFC_3986.isValidURI(string)
}

public func isValidHTTP(_ uri: some URIRepresentable) -> Bool {
    RFC_3986.isValidHTTP(uri)
}

public func isValidHTTP(_ string: String) -> Bool {
    RFC_3986.isValidHTTP(string)
}

public typealias CharacterSets = Set<Character>.URI

public func removeDotSegments(from path: String) -> String {
    RFC_3986.removeDotSegments(from: path)
}
