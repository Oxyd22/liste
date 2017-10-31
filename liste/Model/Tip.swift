//
//  TipValue.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 27.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation

enum Tip: Int {
	case ten = 0
	case fifteen
	case twenty
	case twentyfive
	case thirty
	
	var doubleValue: Double {
		switch self {
		case .ten:
			return 0.1
		case .fifteen:
			return 0.15
		case .twenty:
			return 0.2
		case .twentyfive:
			return 0.25
		case .thirty:
			return 0.3
		}
	}
}

