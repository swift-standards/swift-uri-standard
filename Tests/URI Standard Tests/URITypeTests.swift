import Testing

@testable import URI_Standard

@Test func percentCodingDelegatesToRFC3986() {
    #expect(RFC_3986.percentEncode("hello world") == "hello%20world")
    #expect(RFC_3986.percentDecode("hello%20world") == "hello world")
    #expect(RFC_3986.normalizePercentEncoding("%7e%41") == "~A")
    #expect("hello world".percentEncoded() == "hello%20world")
    #expect("hello%20world".percentDecoded() == "hello world")
}

@Test func uriAndIRIAliasesResolve() throws {
    let uri: URI = try URI("https://example.com/path")
    #expect(uri.scheme?.value == "https")

    let iri: IRI = try IRI("https://example.com/寿司")
    #expect(iri.value.contains("example.com"))
}
