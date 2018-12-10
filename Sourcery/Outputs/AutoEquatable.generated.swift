// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
switch (lhs, rhs) {
case let (lValue?, rValue?):
return compare(lValue, rValue)
case (nil, nil):
return true
default:
return false
}
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
guard lhs.count == rhs.count else { return false }
for (idx, lhsItem) in lhs.enumerated() {
guard compare(lhsItem, rhs[idx]) else { return false }
}

return true
}

// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - BookDTO AutoEquatable
extension BookDTO: Equatable {} 
internal func == (lhs: BookDTO, rhs: BookDTO) -> Bool {
guard lhs.isbn == rhs.isbn else { return false }
guard lhs.title == rhs.title else { return false }
guard lhs.subtitle == rhs.subtitle else { return false }
guard lhs.description == rhs.description else { return false }
guard lhs.coverThumb == rhs.coverThumb else { return false }
guard lhs.languageCode == rhs.languageCode else { return false }
guard lhs.subjects == rhs.subjects else { return false }
guard lhs.authors == rhs.authors else { return false }
return true
}
// MARK: - EventDTO AutoEquatable
extension EventDTO: Equatable {} 
internal func == (lhs: EventDTO, rhs: EventDTO) -> Bool {
guard lhs.timestamp == rhs.timestamp else { return false }
return true
}
// MARK: - Person AutoEquatable
extension Person: Equatable {} 
public func == (lhs: Person, rhs: Person) -> Bool {
guard lhs.name == rhs.name else { return false }
guard lhs.age == rhs.age else { return false }
guard lhs.gender == rhs.gender else { return false }
return true
}
// MARK: - PersonDTO AutoEquatable
extension PersonDTO: Equatable {} 
internal func == (lhs: PersonDTO, rhs: PersonDTO) -> Bool {
guard lhs.title == rhs.title else { return false }
guard lhs.name == rhs.name else { return false }
guard lhs.email == rhs.email else { return false }
guard compareOptionals(lhs: lhs.id, rhs: rhs.id, compare: ==) else { return false }
guard lhs.userId == rhs.userId else { return false }
return true
}

// MARK: - AutoEquatable for Enums

// MARK: -M
