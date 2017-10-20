//
//  Bill.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 20.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation


struct Bill: Billable {
	var tip: Double = 0.0
	var orders: [Order] = []
	
	//Achtung! Konform zum Protokoll
	var totalOrders: [(element: Order, count: Int)] {
		let countedSet = NSCountedSet(array: orders)
		var array: [(element: Order, count: Int)] = []
		for order in countedSet {
			let elementCount = (order as! Order, countedSet.count(for: order))
			array.append(elementCount)
		}
		return array
	}
	
	init(orders: [Order]) {
		self.orders = orders
	}
	
	func billing() -> String {
		var billTable = ""
		let summe = "Summe: \(CurrencyFormater.getCurrencyString(number: self.totalAmount()))"
		let trinkgeld = "+ 10 % Trinkgeld: \(CurrencyFormater.getCurrencyString(number: self.tip(percent: 10)))"
		let columnHeadings = [("Nummer", false), ("Gast", false), ("Artikel", false), ("Preiss", false)]
		
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
			billTable.append("|")
			for (value, reverse) in columnValues {
				billTable.append(spacePadding(value,toLength: columnLength, reverse: reverse))
				billTable.append("|")
			}
			billTable.append("\n")
		}
		
		billTable.append(tableBorderLine)
		addTableRow(columnHeadings)
		billTable.append(tableRowLine)
		for (index, bestellung) in orders.enumerated() {
			var row: [(String, Bool)] = []
			row.append(("\(index + 1)", false))
			row.append((bestellung.customer.name, false))
			row.append((bestellung.item.name, false))
			row.append((CurrencyFormater.getCurrencyString(number: bestellung.item.price), true))
			addTableRow(row)
		}
		billTable.append(tableRowLine)
		addTableRow([(summe, true)])
		addTableRow([(trinkgeld, true)])
		billTable.append(tableBorderLine)
		return billTable
	}
	
}
