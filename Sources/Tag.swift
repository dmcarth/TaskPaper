
import Foundation

public final class Tag {
	
	public var name: String
	
	public var value: String?
	
	public var sourceRange: NSRange
	
	public init(name: String, value: String?=nil, sourceRange: NSRange) {
		self.name = name
		self.value = value
		self.sourceRange = sourceRange
	}
	
}

extension Tag: CustomStringConvertible {
	
	public var description: String {
		let valueString = value ?? "nil"
		return "\(type(of: self))(name: \(name), value: \(valueString), sourceRange: NSRange(location: \(sourceRange.location), length: \(sourceRange.length)))"
	}
	
}

extension Tag: Hashable {
	
	public var hashValue: Int {
		return name.hashValue
	}
	
	public static func ==(lhs: Tag, rhs: Tag) -> Bool {
		return lhs.name == rhs.name
	}
	
}
