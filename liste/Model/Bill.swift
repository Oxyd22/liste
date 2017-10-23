//
//  Bill.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 20.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation


struct Bill {
	let orders: [Order]
	let tip: Double
	var countedOrders: [(element: Order, count: Int)] {
		let countedSet = NSCountedSet(array: orders)
		var array: [(element: Order, count: Int)] = []
		for order in countedSet {
			let elementCount = (order as! Order, countedSet.count(for: order))
			array.append(elementCount)
		}
		return array
	}
	
	func totalAmount() -> Double {
		let total = orders.reduce(0.0) { (sum, order) -> Double in
			sum + order.item.price
		}
		return total
	}
	
	func tipAmound() -> Double {
		let total = self.totalAmount()
		let tip = total * self.tip
		return tip
	}
	
	func finalAmound() -> Double {
		let total = self.totalAmount()
		let tip = self.tipAmound()
		let final = total + tip
		return final.rounded(.up)
	}
	
	func billing() -> String {
		var billSpreadsheet = ""
		let totalAmound = "Rechnungsbetrag: \(CurrencyFormater.getCurrencyString(number: self.totalAmount()))"
		let tipAmound = "\(CurrencyFormater.getPercentString(number: self.tip)) Trinkgeld: \(CurrencyFormater.getCurrencyString(number: self.tipAmound()))"
		let finalAmound = "Endbetrag: ≈\(CurrencyFormater.getCurrencyString(number: self.finalAmound()))"
		let columnHeadings = [("Nummer.", false), ("Gast", false), ("Artikel", false), ("Preiss", false)]
		
		var maxStringLengt: Int {
			var caracterCount = 0
			for order in orders {
				caracterCount = max(caracterCount, order.customer.name.characters.count)
				caracterCount = max(caracterCount, order.item.name.characters.count)
				caracterCount = max(caracterCount, CurrencyFormater.getCurrencyString(number: self.totalAmount()).characters.count)
			}
			for (heading, _) in columnHeadings {
				caracterCount = max(caracterCount, heading.characters.count)
			}
			return caracterCount + 1
		}
		let tableLength = maxStringLengt * columnHeadings.count + columnHeadings.count - 1
		let tableBorderLine: String = "+\("".padding(toLength: tableLength, withPad: "-", startingAt: 0))+\n"
		var tableRowLine: String {
			let rowLine = String(repeating: "-", count: maxStringLengt)
			return "|\(rowLine.padding(toLength: tableLength, withPad: "|\(rowLine)", startingAt: 0))|\n"
		}
		
		func spacePadding(_ text: String, toLength: Int, reverse: Bool) -> String {
			if reverse {
				let reverseText = String(text.characters.reversed())
				let reversePadding = reverseText.padding(toLength: toLength, withPad: " ", startingAt: 0)
				return String(reversePadding.characters.reversed())
			} else {
				return text.padding(toLength: toLength, withPad: " ", startingAt: 0)
			}
		}
		
		func addTableRow(_ columnValues: [(String, Bool)]) {
			var columnLength = maxStringLengt
			if columnValues.count == 1 {
				columnLength = tableLength
			}
			billSpreadsheet.append("|")
			for (value, reverse) in columnValues {
				billSpreadsheet.append(spacePadding(value, toLength: columnLength, reverse: reverse))
				billSpreadsheet.append("|")
			}
			billSpreadsheet.append("\n")
		}
		
		billSpreadsheet.append(tableBorderLine)
		addTableRow(columnHeadings)
		billSpreadsheet.append(tableRowLine)
		for (index, bestellung) in orders.enumerated() {
			var row: [(String, Bool)] = []
			row.append(("\(index + 1)", false))
			row.append((bestellung.customer.name, false))
			row.append((bestellung.item.name, false))
			row.append((CurrencyFormater.getCurrencyString(number: bestellung.item.price), true))
			addTableRow(row)
		}
		billSpreadsheet.append(tableRowLine)
		addTableRow([(totalAmound, true)])
		addTableRow([(tipAmound, true)])
		addTableRow([(finalAmound, true)])
		billSpreadsheet.append(tableBorderLine)
		return billSpreadsheet
	}
	
}
