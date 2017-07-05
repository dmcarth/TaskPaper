
import Foundation

class Tag {
	
	var name: String
	
	var value: String?
	
	var sourceRange: NSRange
	
	init(name: String, value: String?=nil, sourceRange: NSRange) {
		self.name = name
		self.value = value
		self.sourceRange = sourceRange
	}
	
}

extension Tag: CustomStringConvertible {
	
	var description: String {
		let valueString = value ?? "nil"
		return "\(type(of: self))(name: \(name), value: \(valueString), sourceRange: NSRange(location: \(sourceRange.location), length: \(sourceRange.length)))"
	}
	
}

extension Tag: Hashable {
	
	var hashValue: Int {
		return name.hashValue
	}
	
	static func ==(lhs: Tag, rhs: Tag) -> Bool {
		return lhs.name == rhs.name
	}
	
}
