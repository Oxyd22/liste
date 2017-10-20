//
//  Order.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 20.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation


struct Order: Hashable {
	var hashValue: Int {
		return self.item.name.hashValue ^ self.item.price.hashValue
	}
	let customer: Customer
	let item: Orderable
}
func ==(lhs: Order, rhs: Order) -> Bool {
	return lhs.hashValue == rhs.hashValue
}
