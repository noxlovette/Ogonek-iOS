import Foundation

public extension Ogonek.API.Error {
    enum OgonekError: Swift.Error {
        case generic(error: Ogonek.Entity.Error)

        init(error: Ogonek.Entity.Error) {
            self = .generic(error: error)
        }
    }
}

extension Ogonek.API.Error.OgonekError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .generic(error):
            return error.error
        }
    }

    public var failureReason: String? {
        switch self {
        case let .generic(error):
            return error.errorDescription
        }
    }
}
