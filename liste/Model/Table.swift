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
		let totalTip = customers.reduce(0.0) { (sum, customer) -> Double in
			sum + customer.tip
		}
		let bill = Bill(orders: orders, tip: totalTip)
		return bill
	}
	
	init() {
		self.customers = []
	}
	
	func addCustomer(name: String) {
		let customer = Customer(name: name)
		self.customers.append(customer)
	}
	
	func addCustomer(_ customer: Customer) {
		self.customers.append(customer)
	}
}
