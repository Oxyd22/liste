import Foundation

public enum Alignment {
	case left, rigth
}

public struct TableGenerator {
	var internalTable: [[(String, Alignment)]] = []
	
	public init() {}
	
	public mutating func addTableRow(columnValues: [String]) {
		let table = columnValues.map { (value) -> (String, Alignment) in
			return (value, .left)
		}
		internalTable.append(table)
	}
	
	public mutating func addTableRow(columnValues: [(String, Alignment)]) {
		internalTable.append(columnValues)
	}
	
	public func transpose<T>(input: [[T]]) -> [[T]] {
		if input.isEmpty { return [[T]]() }
		let count = input[0].count
		var transposed = [[T]](repeating: [T](), count: count)
		for outer in input {
			if outer.count < 2 { continue }
			for (index, inner) in outer.enumerated() {
				transposed[index].append(inner)
			}
		}
		return transposed
	}
	
	func findMaxColumnWidth() -> [Int] {
		let transposed = transpose(input: internalTable)
		let maxColumnWidth = transposed.map { (column) -> Int in
			let maxElement = column.max { (a, b) -> Bool in
				a.0.count < b.0.count
			}
			return (maxElement?.0.count ?? 1) + 1
		}
		return maxColumnWidth
	}
	
	func spacePadding(_ text: String, toLength: Int, alignment: Alignment) -> String {
		switch alignment {
		case .left:
			return text.padding(toLength: toLength, withPad: " ", startingAt: 0)
		case .rigth:
			let reverseText = String(text.reversed())
			let reversePadding = reverseText.padding(toLength: toLength, withPad: " ", startingAt: 0)
			return String(reversePadding.reversed())
		}
	}
	
	func tableRowLine(maxColumnWidth: [Int]) -> String {
		let lineArray = maxColumnWidth.map { (width) -> String in
			return String(repeating: "-", count: width)
		}
		let line = lineArray.joined(separator: "|")
		return "|\(line)|"
	}
	
	public func drawSpreadsheet() -> String {
		var spreadsheet = ""
		let maxColumnWidth = findMaxColumnWidth()
		let columnsCount = maxColumnWidth.count
		let allColumnsWidth = maxColumnWidth.reduce(0) {$0 + $1}
		let tableLength = allColumnsWidth + columnsCount - 1
		let tableBorderLine: String = "+\("".padding(toLength: tableLength, withPad: "-", startingAt: 0))+\n"
		
		spreadsheet.append(tableBorderLine)
		for row in internalTable {
			if row.first?.0 == "-" {
				spreadsheet.append(tableRowLine(maxColumnWidth: maxColumnWidth))
			} else {
				if row.count == 1 {
					spreadsheet.append("|")
					spreadsheet.append(spacePadding(row.first!.0, toLength: tableLength, alignment: row.first!.1))
					spreadsheet.append("|")
				} else {
					spreadsheet.append("|")
					for (index, column) in row.enumerated() {
						spreadsheet.append(spacePadding(column.0, toLength: maxColumnWidth[index], alignment: column.1))
						spreadsheet.append("|")
					}
				}
			}
			spreadsheet.append("\n")
		}
		spreadsheet.append(tableBorderLine)
		return spreadsheet
	}
}


