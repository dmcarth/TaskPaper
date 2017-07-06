
extension UTF16 {
	static var tab: CodeUnit { return 0x09 }
	static var newline: CodeUnit { return 0x0a }
	static var formfeed: CodeUnit { return 0x0c }
	static var carriage: CodeUnit { return 0x0d }
	static var space: CodeUnit { return 0x20 }
	static var lsep: CodeUnit { return 0x2028 }
	static var psep: CodeUnit { return 0x2029 }
	
	static var backslash: CodeUnit { return 0x5c }
	static var hyphen: CodeUnit { return 0x2d }
	static var plus: CodeUnit { return 0x2b }
	static var asterisk: CodeUnit { return 0x2a }
	static var colon: CodeUnit { return 0x3a }
	static var at: CodeUnit { return 0x40 }
	static var openParen: CodeUnit { return 0x28 }
	static var closeParen: CodeUnit { return 0x29 }
}

extension UInt16 {
	
	var isWhitespace: Bool {
		return self == UTF16.tab || self == UTF16.space || self == UTF16.newline || self == UTF16.formfeed || self == UTF16.carriage || self == UTF16.lsep || self == UTF16.psep
	}
	
	var isAlphanumeric: Bool {
		let isDigit = self >= 0x30 && self <= 0x39
		let isUppercase = self >= 0x41 && self <= 0x5a
		let isLowercase = self >= 0x61 && self <= 0x7a
		let isUnderscore = self == 0x5f
		
		return isUppercase || isLowercase || isDigit || isUnderscore
	}
	
}
