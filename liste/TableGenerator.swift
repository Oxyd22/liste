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
	
	func findMaxStringLengt() -> Int {
		let flatArray = internalTable.flatMap { (element) -> [(String, Alignment)] in
			if element.count == 1 {
				return [("", .left)]
			}
			return element
		}
		let maxElement = flatArray.max { (a, b) -> Bool in
			a.0.count < b.0.count
		}
		return (maxElement?.0.count ?? 1) + 1
	}
	
	func spacePadding(_ text: String, toLength: Int, alignment: Alignment) -> String {
		switch alignment {
		case .left:
			return text.padding(toLength: toLength, withPad: " ", startingAt: 0)
		case .rigth:
			let reverseText = String(text.characters.reversed())
			let reversePadding = reverseText.padding(toLength: toLength, withPad: " ", startingAt: 0)
			return String(reversePadding.characters.reversed())
		}
	}
	
	func tableRowLine(maxStringLengt: Int, tableLength: Int) -> String {
		let rowLine = String(repeating: "-", count: maxStringLengt)
		return "|\(rowLine.padding(toLength: tableLength, withPad: "|\(rowLine)", startingAt: 0))|\n"
	}
	
	public func drawSpreadsheet() -> String {
		var spreadsheet = ""
		let maxStringLength = findMaxStringLengt()
		let columns = internalTable.first?.count ?? 1
		let tableLength = maxStringLength *  columns + columns - 1
		let tableBorderLine: String = "+\("".padding(toLength: tableLength, withPad: "-", startingAt: 0))+\n"
		
		spreadsheet.append(tableBorderLine)
		for row in internalTable {
			if row.first?.0 == "-" {
				spreadsheet.append(tableRowLine(maxStringLengt: maxStringLength, tableLength: tableLength))
				continue
			}
			if row.count == 1 {
				spreadsheet.append("|")
				spreadsheet.append(spacePadding(row.first!.0, toLength: tableLength, alignment: row.first!.1))
				spreadsheet.append("|")
			} else {
				spreadsheet.append("|")
				for column in row {
					spreadsheet.append(spacePadding(column.0, toLength: maxStringLength, alignment: column.1))
					spreadsheet.append("|")
				}
			}
			spreadsheet.append("\n")
		}
		spreadsheet.append(tableBorderLine)
		return spreadsheet
	}
}
