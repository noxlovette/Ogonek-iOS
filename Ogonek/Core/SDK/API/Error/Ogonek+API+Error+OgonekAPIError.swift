import Foundation

extension Ogonek.API.Error {
    public enum OgonekError: Swift.Error {
        case generic(error: Ogonek.Entity.Error)

        init(error: Ogonek.Entity.Error) {
            self = .generic(error: error)
        }
    }
}

extension Ogonek.API.Error.OgonekError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error.error
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .generic(let error):
            return error.errorDescription
        }
    }
    
}
