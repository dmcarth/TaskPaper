
import Foundation

class Item: Container {
	
	enum ItemType {
		case note
		case project
		case task
	}
	
	weak var parent: Container?
	
	var children: [Item] = []
	
	var type: ItemType
	
	/// Range of line describing item in original text
	var sourceRange: NSRange
	
	/// Range of line excluding trailing tags and leading syntax
	var contentRange: NSRange
	
	var attributes: Set<Attribute> = []
	
	init(type: ItemType, sourceRange: NSRange, contentRange: NSRange) {
		self.type = type
		self.sourceRange = sourceRange
		self.contentRange = contentRange
	}
	
}

extension Item {
	
	var sourceRangeIncludingChildren: NSRange {
		var length = sourceRange.length
		
		if let lastChildRange = children.last?.sourceRange {
			length = NSMaxRange(lastChildRange) - sourceRange.location
		}
		
		return NSMakeRange(sourceRange.location, length)
	}
	
}

extension Item {
	
	subscript(_ attributeName: String) -> Attribute? {
		// hack: this only works because attribute.hashValue == attribute.name.hashValue
		let dummyAttribue = Attribute(name: attributeName, sourceRange: NSMakeRange(0, 0))
		if let index = attributes.index(of: dummyAttribue) {
			return attributes[index]
		}
		
		return nil
	}
	
	func addAttributes(_ attrs: [Attribute]) {
		attributes.formUnion(attrs)
	}
	
}
