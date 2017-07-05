
protocol Container: class {
	var children: [Item] { get set }
}

extension Container {
	
	func addChild(_ child: Item) {
		child.parent = self
		
		children.append(child)
	}
	
	func enumerate(_ handler: (Container)->Void) {
		handler(self)
		
		for child in children {
			child.enumerate(handler)
		}
	}
	
}
