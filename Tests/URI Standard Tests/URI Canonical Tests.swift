import Testing
import URI_Standard

@Suite
struct `URI Canonical Tests` {
    @Suite
    struct Unit {
        @Test
        func `canonical replaces host and port`() throws(URI.Canonicalization.Error) {
            let uri = URI(unchecked: "https://example.com:8080/path")
            let result = try uri.canonical(host: "canonical.com:9090")

            #expect(result == "https://canonical.com:9090/path")
        }

        @Test
        func `canonical removes the port when host omits it`() throws(URI.Canonicalization.Error) {
            let uri = URI(unchecked: "https://example.com:8080/path")
            let result = try uri.canonical(host: "canonical.com")

            #expect(result == "https://canonical.com/path")
        }

        @Test
        func `canonical preserves an explicit default port`() throws(URI.Canonicalization.Error) {
            let uri = URI(unchecked: "https://example.com/path")
            let result = try uri.canonical(host: "canonical.com:443")

            #expect(result == "https://canonical.com:443/path")
        }

        @Test
        func `canonical accepts RFC 3986 IPv6 authority`() throws(URI.Canonicalization.Error) {
            let uri = URI(unchecked: "https://example.com/path")
            let result = try uri.canonical(host: "[2001:db8::1]:8443")

            #expect(result == "https://[2001:db8::1]:8443/path")
        }
    }

    @Suite
    struct `Edge Case` {
        @Test
        func `canonical rejects an empty host`() {
            let uri = URI(unchecked: "https://example.com/path")

            #expect(throws: URI.Canonicalization.Error.host(.empty)) {
                try uri.canonical(host: "")
            }
        }

        @Test
        func `canonical rejects a nonnumeric port`() {
            let uri = URI(unchecked: "https://example.com/path")

            #expect(throws: URI.Canonicalization.Error.port(.invalid("invalid"))) {
                try uri.canonical(host: "canonical.com:invalid")
            }
        }

        @Test
        func `canonical rejects an out of range port`() {
            let uri = URI(unchecked: "https://example.com/path")

            #expect(throws: URI.Canonicalization.Error.port(.range(0))) {
                try uri.canonical(host: "canonical.com:0")
            }

            #expect(throws: URI.Canonicalization.Error.port(.range(65536))) {
                try uri.canonical(host: "canonical.com:65536")
            }
        }
    }

    @Suite
    struct Integration {
        @Test
        func `canonical preserves path query and fragment`() throws(URI.Canonicalization.Error) {
            let uri = URI(unchecked: "https://example.com/path?query=value#fragment")
            let result = try uri.canonical(host: "canonical.com")

            #expect(result == "https://canonical.com/path?query=value#fragment")
        }
    }
}
