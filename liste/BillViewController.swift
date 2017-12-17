//
//  BillViewController.swift
//  liste
//
//  Created by Daniel Riewe on 18.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class BillViewController: UIViewController {
	var table: Table!
	var billText = ""
	@IBOutlet weak var billTextView: UITextView!
	@IBOutlet weak var tipSegmentControl: UISegmentedControl!

	override func viewDidLoad() {
		super.viewDidLoad()
		tipSegmentControl.selectedSegmentIndex = table.tip.rawValue
		displayBill(tip: table.tip)
	}

	@IBAction func tipValueChanged(_ sender: UISegmentedControl) {
		if let tip = Tip(rawValue: sender.selectedSegmentIndex) {
			table.tip = tip
			displayBill(tip: tip)
		}
	}

	func displayBill(tip: Tip) {
		var bill = table.bill.billing(counted: true)
		for gast in table.customers {
			gast.tip = table.tip
			let text = gast.bill.billing()
			bill.append(text)
		}
		billText = bill
		billTextView.text = bill
	}

	@IBAction func shareBill(_ sender: UIBarButtonItem) {
		let activityViewController = UIActivityViewController(
			activityItems: ["Check out this.", billText], applicationActivities: nil)
		if let popoverPresentationController = activityViewController.popoverPresentationController {
			popoverPresentationController.barButtonItem = (sender)
		}
		present(activityViewController, animated: true, completion: nil)
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
