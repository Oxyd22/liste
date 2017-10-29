//
//  TipValue.swift
//  Aufteilen
//
//  Created by Daniel Jesaja Riewe on 27.10.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import Foundation

enum Tip: Int {
	case five = 0
	case ten
	case fifteen
	case twenty
	
	var doubleValue: Double {
		switch self {
		case .five:
			return 0.05
		case .ten:
			return 0.1
		case .fifteen:
			return 0.15
		case .twenty:
			return 0.20
		}
	}
}

