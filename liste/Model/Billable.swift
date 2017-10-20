//
//  Billable.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 20.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation

protocol Billable {
	var orders: [Order] { get set }
	var tip: Double { get set }
	func totalAmount() -> Double
	func tip(percent: Int) -> Double
}

extension Billable {
	func totalAmount() -> Double {
		let total = orders.reduce(0.0) { (sum, order) -> Double in
			sum + order.item.price
		}
		return total
	}
	
	func tip(percent: Int) -> Double {
		let total = totalAmount()
		let tip = (total / 100) * Double(percent)
		let finalAmount = total + tip
		return finalAmount
	}
	
	func finalAmound() -> Double {
		let total = self.totalAmount()
		let final = total + tip
		return final.rounded(.up)
	}
}
