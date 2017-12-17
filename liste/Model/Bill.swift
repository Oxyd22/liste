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
	let tip: Tip

	func totalAmount() -> Double {
		let total = orders.reduce(0.0) { (sum, order) -> Double in
			sum + order.item.price
		}
		return total
	}

	func tipAmound() -> Double {
		let total = self.totalAmount()
		let tip = total * self.tip.doubleValue
		return tip
	}

	func finalAmound() -> Double {
		let total = self.totalAmount()
		let tip = self.tipAmound()
		let final = total + tip
		return final.rounded(.up)
	}

	func countOrders() -> [(element: Order, count: Int)] {
		let countedSet = NSCountedSet(array: orders)
		var array: [(element: Order, count: Int)] = []
		for order in countedSet {
			let elementCount = (order as! Order, countedSet.count(for: order))
			array.append(elementCount)
		}
		return array
	}

    //TODO: Move to ViewController
	func billing(counted: Bool = false) -> String {
		let totalAmound = "Rechnungsbetrag: \(CurrencyFormater.getCurrencyString(number: self.totalAmount()))"
		let tipAmound = "\(CurrencyFormater.getPercentString(number: self.tip.doubleValue)) Trinkgeld: \(CurrencyFormater.getCurrencyString(number: self.tipAmound()))"
		let finalAmound = "Endbetrag: ≈\(CurrencyFormater.getCurrencyString(number: self.finalAmound()))"
		var tableGenerator = TableGenerator()
		if counted {
			let countedOrders = countOrders()
			tableGenerator.addTableRow(columnValues: ["Anzahl", "Artikel", "Preiss", "Summe"])
			tableGenerator.addTableRow(columnValues: ["-"])
			for countedOrder in countedOrders {
				let itemName = countedOrder.element.item.name
				let price = CurrencyFormater.getCurrencyString(number: countedOrder.element.item.price)
				let countedPrice = CurrencyFormater.getCurrencyString(number: (countedOrder.element.item.price * Double(countedOrder.count)))
				tableGenerator.addTableRow(columnValues: [("\(countedOrder.count) * ", .rigth), (itemName, .left), (price, .rigth), (countedPrice, .rigth)])
			}
		} else {
			tableGenerator.addTableRow(columnValues: ["Gast", "Artikel", "Preiss"])
			tableGenerator.addTableRow(columnValues: ["-"])
			for order in orders {
				let customerName = order.customer.name
				let itemName = order.item.name
				let price = CurrencyFormater.getCurrencyString(number: order.item.price)
				tableGenerator.addTableRow(columnValues: [(customerName, .left), (itemName, .left), (price, .rigth)])
			}
		}
		tableGenerator.addTableRow(columnValues: ["-"])
		tableGenerator.addTableRow(columnValues: [(totalAmound, .rigth)])
		tableGenerator.addTableRow(columnValues: [(tipAmound, .rigth)])
		tableGenerator.addTableRow(columnValues: [(finalAmound, .rigth)])
		return tableGenerator.drawSpreadsheet()
	}

}
