
import Foundation

class Attribute {
	
	var name: String
	
	var value: String?
	
	var sourceRange: NSRange
	
	init(name: String, value: String?=nil, sourceRange: NSRange) {
		self.name = name
		self.value = value
		self.sourceRange = sourceRange
	}
	
}

extension Attribute: CustomStringConvertible {
	
	var description: String {
		let valueString = value ?? "nil"
		return "Attribute(name: \(name), value: \(valueString), sourceRange: NSRange(location: \(sourceRange.location), length: \(sourceRange.length)))"
	}
	
}

extension Attribute: Hashable {
	
	var hashValue: Int {
		return name.hashValue
	}
	
	static func ==(lhs: Attribute, rhs: Attribute) -> Bool {
		return lhs.name == rhs.name
	}
	
}
