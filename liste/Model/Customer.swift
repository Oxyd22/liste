//
//  Customer.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 20.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation

class Customer {
	var name: String
	var orders: [Order] = []
	var tip = Tip.ten
	var bill: Bill {
		let bill = Bill(orders: orders, tip: tip)
		return bill
	}
	
	init(name: String) {
		self.name = name
	}
	
	func order(name: String, price: Double) {
		let orderItem = OrderItem(name: name, price: price)
		let order = Order(customer: self, item: orderItem)
		orders.append(order)
	}
}
