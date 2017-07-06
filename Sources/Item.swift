
import Foundation

public final class Item {
	
	public enum ItemType {
		case note
		case project
		case task
	}
	
	public weak var parent: Item?
	
	public var children: [Item] = []
	
	public var type: ItemType
	
	/// Range of line describing item in original text
	public var sourceRange: NSRange
	
	/// Range of line excluding trailing tags and leading syntax
	public var contentRange: NSRange
	
	public var tags: Set<Tag> = []
	
	public init(type: ItemType, sourceRange: NSRange, contentRange: NSRange) {
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
	
	public func enumerate(_ handler: (Item)->Void) {
		handler(self)
		
		for child in children {
			child.enumerate(handler)
		}
	}
	
}

extension Item {
	
	public var sourceRangeIncludingChildren: NSRange {
		var length = sourceRange.length
		
		if let lastChildRange = children.last?.sourceRangeIncludingChildren {
			length = NSMaxRange(lastChildRange) - sourceRange.location
		}
		
		return NSMakeRange(sourceRange.location, length)
	}
	
}

extension Item {
	
	public subscript(_ tagName: String) -> Tag? {
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
