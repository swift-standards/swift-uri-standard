import RFC_3986
import RFC_3987
import Testing
import URI_Standard

@Suite
struct `URI Type Tests` {
    @Test
    func `percent coding delegates to RFC 3986`() {
        #expect(RFC_3986.percentEncode(Array("hello world".utf8)) == Array("hello%20world".utf8))
        #expect(RFC_3986.percentDecode(Array("hello%20world".utf8)) == Array("hello world".utf8))
        #expect(RFC_3986.normalizePercentEncoding("%7e%41") == "~A")
    }

    @Test
    func `URI and IRI aliases resolve`() throws {
        let uri: URI = try URI("https://example.com/path")
        #expect(uri.scheme?.value == "https")

        let iri: IRI = IRI("https://example.com/寿司")
        #expect(iri.value.contains("example.com"))
    }
}
