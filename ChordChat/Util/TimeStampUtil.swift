import Foundation

struct TimeStampUtil {
    static func getDateNowMiliseconds() -> String {
        let dateNowMiliseconds = Date.now.timeIntervalSince1970
        let stringifiedDateNowMiliseconds = String(dateNowMiliseconds)
        return stringifiedDateNowMiliseconds
    }
    
    static func convertTimestampIntoDate(timestamp: String) -> Date? {
        guard let timeStamp = Double(timestamp) else {
            return nil
        }
        let date = Date(timeIntervalSince1970: timeStamp / 1000)
        return date
    }
}

extension Date {
    func localizedDescription(date dateStyle: DateFormatter.Style = .medium,
                              time timeStyle: DateFormatter.Style = .medium,
                              in timeZone: TimeZone = .current,
                              locale: Locale = .current,
                              using calendar: Calendar = .current) -> String {
        Formatter.date.calendar = calendar
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    var localizedDescription: String { localizedDescription() }
}

extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}

extension Locale {
    static let ptBR = Locale(identifier: "pt_BR")
}

extension Formatter {
    static let date = DateFormatter()
}
