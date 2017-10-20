//
//  Customer.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 20.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation

class Customer {
	let name: String
	var orders: [Order]
	var bill: Bill {
		let bill = Bill(orders: orders)
		return bill
	}
	
	init(name: String) {
		self.name = name
		self.orders = []
	}
	
	func order(name: String, price: Double) {
		let orderItem = OrderItem(name: name, price: price)
		let order = Order(customer: self, item: orderItem)
		orders.append(order)
	}
}
