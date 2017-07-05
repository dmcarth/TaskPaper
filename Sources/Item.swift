
import Foundation

class Item {
	
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
	
	var tags: Set<Tag> = []
	
	init(type: ItemType, sourceRange: NSRange, contentRange: NSRange) {
		self.type = type
		self.sourceRange = sourceRange
		self.contentRange = contentRange
	}
	
}

extension Item {
	
	func addChild(_ child: Item) {
		child.parent = self
		
		children.append(child)
	}
	
	func enumerate(_ handler: (Item)->Void) {
		handler(self)
		
		for child in children {
			child.enumerate(handler)
		}
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
	
	subscript(_ tagName: String) -> Tag? {
		// hack: this only works because attribute.hashValue == attribute.name.hashValue
		let dummyTag = Tag(name: tagName, sourceRange: NSMakeRange(0, 0))
		if let index = tags.index(of: dummyTag) {
			return tags[index]
		}
		
		return nil
	}
	
	func addTags(_ newTags: [Tag]) {
		tags.formUnion(newTags)
	}
	
}
