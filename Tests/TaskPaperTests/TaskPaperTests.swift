import XCTest
@testable import TaskPaper

class TaskPaperTests: XCTestCase {
	
	func testBenchmark() {
		let str = "one:\n\t- two\n\t\t- three\n\t- four\n five\n\t- six\n seven:\n\t eight\n\t- nine\n- ten\n"
		var input = str
		
		for _ in 0..<10000 {
			input += str
		}
		
		measure {
			let _ = TaskPaper(input)
		}
	}
	
	func testTagRegex() {
		let str = "@a(b) c @d @e" as NSString
		
		let results = scanForTags(in: str, range: NSMakeRange(0, str.length))
		
		print(results)
	}
	
    static var allTests = [
        ("testTagRegex", testTagRegex),
    ]
}
