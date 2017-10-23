//
//  BillViewController.swift
//  liste
//
//  Created by Daniel Riewe on 18.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class BillViewController: UIViewController {
	var tisch: Table!
	@IBOutlet weak var billTextView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let rootTabBarViewController = self.tabBarController as! RootTabBarViewController
		self.tisch = rootTabBarViewController.tisch
	}
	
	override func viewWillAppear(_ animated: Bool) {
		let tip = 0.10
		var bill = tisch.bill.billing()
		for gast in tisch.customers {
			gast.tip = tip
			let text = gast.bill.billing()
			bill.append(text)
		}
		billTextView.text = bill
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
