
import Foundation

struct ScanResult {
	
	var range: NSRange
	
	var groups: [NSRange]
	
}

extension ScanResult {
	
	subscript(_ i: Int) -> NSRange {
		if i == 0 { return range}
		else { return groups[i-1] }
	}
	
}

func scanForWhitespace(in string: NSString, at index: Int) -> Bool {
	let c = string.character(at: index)
	
	return c.isWhitespace
}

func scanForIndent(in string: NSString, range: NSRange) -> ScanResult {
	//from beginning of string, 0+ tabs
	var length = 0
	
	while length < range.length {
		if string.character(at: range.location + length) == UTF16.tab {
			length += 1
		} else {
			break
		}
	}
	
	return ScanResult(range: NSMakeRange(range.location, length), groups: [])
}

func scanForTask(in string: NSString, range: NSRange) -> ScanResult? {
	guard range.length >= 2 else {
		return nil
	}
	
	switch string.character(at: range.location) {
	case UTF16.backslash, UTF16.hyphen, UTF16.plus, UTF16.asterisk:
		break
	default:
		return nil
	}
	
	guard scanForWhitespace(in: string, at: range.location + 1) else {
		return nil
	}
	
	return ScanResult(range: NSMakeRange(range.location, 2), groups: [])
}

func scanForProject(in string: NSString, range: NSRange) -> ScanResult? {
	guard range.length >= 1 else {
		return nil
	}
	
	var length = 0
	if string.character(at: NSMaxRange(range) - 1) == UTF16.newline {
		length += 1
	}
	
	guard range.length >= 1+length, string.character(at: NSMaxRange(range) - length - 1) == UTF16.colon else {
		return nil
	}
	
	return ScanResult(range: NSMakeRange(NSMaxRange(range) - length, length), groups: [])
}

func scanForTags(in string: NSString, range: NSRange) -> [ScanResult] {
	var matches: [ScanResult] = []
	
	var cursor = range.location
	while cursor < NSMaxRange(range) {
		var i = cursor
		let c = string.character(at: i)
		
		// leading whitespace
		var matchStart = i
		if i == range.location {
			
		} else if c.isWhitespace {
			i += 1
			while i < NSMaxRange(range), string.character(at: i).isWhitespace {
				i += 1
			}
		} else {
			cursor += 1
			continue
		}
		
		// @
		guard string.character(at: i) == UTF16.at else {
			cursor += 1
			continue
		}
		
		i += 1
		
		// name
		guard string.character(at: i).isAlphanumeric else {
			cursor += 1
			continue
		}
		let group1Start = i
		i += 1
		while i < NSMaxRange(range), string.character(at: i).isAlphanumeric {
			i += 1
		}
		let group1End = i
		
		// optional value
		var group2Start: Int?
		var group2End: Int?
		
		if i < NSMaxRange(range), string.character(at: i) == UTF16.openParen {
			i += 1
			group2Start = i
			while i < NSMaxRange(range) {
				let nc = string.character(at: i)
				if nc != UTF16.openParen && nc != UTF16.closeParen {
					i += 1
				} else {
					break
				}
			}
			group2End = i
			guard i < NSMaxRange(range), string.character(at: i) == UTF16.closeParen else {
				cursor += 1
				continue
			}
			i += 1
		}
		
		if i < NSMaxRange(range) {
			guard string.character(at: i).isWhitespace else {
				cursor += 1
				continue
			}
		}
		
		let group1 = NSMakeRange(group1Start, group1End - group1Start)
		var group2 = NSMakeRange(NSNotFound, 0)
		if let start = group2Start, let end = group2End {
			group2 = NSMakeRange(start, end - start)
		}
		let match = ScanResult(range: NSMakeRange(cursor, i - cursor), groups: [group1, group2])
		matches.append(match)
		
		cursor = i + 1
	}
	
	return matches
}

