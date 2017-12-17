//
//  CurrencyFormater.swift
//  liste
//
//  Created by Daniel Riewe on 23.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import Foundation


struct CurrencyFormater {
    private init() {}
    
    static func getCurrencyString(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = NSLocale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        let formattedString = formatter.string(for: number)
        return formattedString!
    }
    
    static func getDoubleValue(currencyString: String) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = NSLocale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        guard let number = formatter.number(from: currencyString) else {
            return nil
        }
        return number.doubleValue
    }

	static func getPercentString(number: Double) -> String {
		let formatter = NumberFormatter()
		formatter.locale = NSLocale.current
		formatter.numberStyle = .percent
		formatter.maximumFractionDigits = 2
		let formattedString = formatter.string(for: number)
		return formattedString!
	}
}
