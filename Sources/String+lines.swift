//
//  String+lines.swift
//  TaskPaper
//
//  Created by Dylan McArthur on 7/2/17.
//
//

import Foundation

extension NSString {
	
	struct LineView: Sequence {
		
		var string: NSString
		
		func makeIterator() -> LineIterator {
			return LineIterator(self)
		}
		
	}
	
	struct LineIterator: IteratorProtocol {
		
		var string: NSString
		
		var beginningOfLine: Int
		
		var endOfLine: Int
		
		init(_ lines: LineView) {
			self.string = lines.string
			self.beginningOfLine = 0
			self.endOfLine = 0
		}
		
		mutating func next() -> (NSRange, NSString)? {
			guard beginningOfLine < string.length else {
				return nil
			}
			
			endOfLine = beginningOfLine
			
			while endOfLine < string.length {
				let backtrack = endOfLine
				endOfLine += 1
				if string.character(at: backtrack) == 0x0a {
					break
				}
			}
			
			defer {
				beginningOfLine = endOfLine
			}
			
			let substringRange = NSMakeRange(beginningOfLine, endOfLine - beginningOfLine)
			let substring = string.substring(with: substringRange) as NSString
			
			return (substringRange, substring)
		}
		
	}
	
	var lines: LineView {
		return LineView(string: self)
	}
	
}
