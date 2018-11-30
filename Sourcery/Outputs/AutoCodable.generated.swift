// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
import Foundation

extension BookDTO {
    /// Decode this object from a json from a Data object
    static func decode(object jsonData: Data) -> BookDTO? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(BookDTO.self, from: jsonData)
            return decoded
        } catch let error {
            print("error trying to convert json Data to BookDTO object")
            print(error)
        }
        return nil
    }

    /// Encode this object into a Data object of type json
    func encode() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
        print("error trying to convert BookDTO object to json Data")
        print(error)
        }
        return nil
    }

    /// Decode an arroy of objects from a json from a Data object
    static func decode(array jsonData: Data) -> [BookDTO]? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode([BookDTO].self, from: jsonData)
            return decoded
        } catch let error {
            print("error trying to convert json Data to [BookDTO] object")
            print(error)
        }
        return nil
    }

    /// Encode this object into a Data object of type json
    static func encode(array: [BookDTO]) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(array)
            return data
        } catch {
            print("error trying to convert BookDTO object to json Data")
            print(error)
        }
        return nil
    }
}
extension EventDTO {
    /// Decode this object from a json from a Data object
    static func decode(object jsonData: Data) -> EventDTO? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(EventDTO.self, from: jsonData)
            return decoded
        } catch let error {
            print("error trying to convert json Data to EventDTO object")
            print(error)
        }
        return nil
    }

    /// Encode this object into a Data object of type json
    func encode() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
        print("error trying to convert EventDTO object to json Data")
        print(error)
        }
        return nil
    }

    /// Decode an arroy of objects from a json from a Data object
    static func decode(array jsonData: Data) -> [EventDTO]? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode([EventDTO].self, from: jsonData)
            return decoded
        } catch let error {
            print("error trying to convert json Data to [EventDTO] object")
            print(error)
        }
        return nil
    }

    /// Encode this object into a Data object of type json
    static func encode(array: [EventDTO]) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(array)
            return data
        } catch {
            print("error trying to convert EventDTO object to json Data")
            print(error)
        }
        return nil
    }
}
extension PersonDTO {
    /// Decode this object from a json from a Data object
    static func decode(object jsonData: Data) -> PersonDTO? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(PersonDTO.self, from: jsonData)
            return decoded
        } catch let error {
            print("error trying to convert json Data to PersonDTO object")
            print(error)
        }
        return nil
    }

    /// Encode this object into a Data object of type json
    func encode() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
        print("error trying to convert PersonDTO object to json Data")
        print(error)
        }
        return nil
    }

    /// Decode an arroy of objects from a json from a Data object
    static func decode(array jsonData: Data) -> [PersonDTO]? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode([PersonDTO].self, from: jsonData)
            return decoded
        } catch let error {
            print("error trying to convert json Data to [PersonDTO] object")
            print(error)
        }
        return nil
    }

    /// Encode this object into a Data object of type json
    static func encode(array: [PersonDTO]) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(array)
            return data
        } catch {
            print("error trying to convert PersonDTO object to json Data")
            print(error)
        }
        return nil
    }
}
