import Foundation

extension Ogonek.API {
    public struct Error: Swift.Error {
        
        public var httpResponseStatus: HTTPResponseStatus
        public var ogonekError: OgonekError?

        init(
            httpResponseStatus: HTTPResponseStatus,
            ogonekError: Ogonek.API.Error.MastodonError?
        ) {
            self.httpResponseStatus = httpResponseStatus
            self.ogonekError = ogonekError
        }
        
        init(
            httpResponseStatus: HTTPResponseStatus,
            error: Ogonek.Entity.Error
        ) {
            self.init(
                httpResponseStatus: httpResponseStatus,
                ogonekError: OgonekError(error: error)
            )
        }
        
    }
}
