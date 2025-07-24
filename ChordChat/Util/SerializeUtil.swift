import Foundation

struct SerializeUtil {
    static func serialize(object: Codable) -> String? {
        do {
            let encoder = JSONEncoder()
//          pretty formating
//          encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(object)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("ERROR: Invalid Object")
            return nil
        }
    }
    
    static func deserialize<T: Decodable>(jsonString: String, type: T.Type) -> T?{
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        do {
            let message = try JSONDecoder().decode(type, from: jsonData)
            return message
        } catch {
            print("ERROR: Unable to deserialise the jsonObject")
            return nil
        }
    }
}
