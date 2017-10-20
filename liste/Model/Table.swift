//
//  Table.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 20.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation


class Table {
	var customers: [Customer]
	var bill: Bill {
		let orders: [Order] = customers.flatMap { customer in
			customer.orders
		}
		let bill = Bill(orders: orders)
		return bill
	}
	
	init() {
		self.customers = []
	}
	
	func addCustomer(name: String) {
		let gast = Customer(name: name)
		self.customers.append(gast)
	}
	
	func addCustomer(gast: Customer) {
		self.customers.append(gast)
	}
}
