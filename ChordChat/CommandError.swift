import Foundation

enum CommandError: Error {
    case invalidCommandName
    case invalidParameters(parameterNeeded: [String])
}
