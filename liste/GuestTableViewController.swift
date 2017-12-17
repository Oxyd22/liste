//
//  DinnerTableViewController.swift
//  test
//
//  Created by Daniel Riewe on 13.09.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class GuestTableViewController: UITableViewController {
	var table: Table = Table()
	@IBOutlet weak var totalAmoundLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		tableView.reloadData()
		displaySummForAllOrders()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func displaySummForAllOrders() {
		let totalAmound = table.bill.totalAmount()
		totalAmoundLabel.text = CurrencyFormater.getCurrencyString(number: totalAmound)
	}

	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return table.customers.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "guestCellIdentifier", for: indexPath)
		let guest = table.customers[indexPath.row]
		let name = guest.name
		let summe = guest.bill.totalAmount()
		cell.textLabel?.text = name
		cell.detailTextLabel?.text = CurrencyFormater.getCurrencyString(number: summe)
		return cell
	}

	@IBAction func newCustomer(_ sender: UIBarButtonItem) {
		let count = table.customers.count
		let customer = Customer(name: "Gast \(count + 1)")
		table.addCustomer(customer)
		let indexPath = IndexPath(row: count, section: 0)
		tableView.beginUpdates()
		tableView.insertRows(at: [indexPath], with: .automatic)
		tableView.endUpdates()
	}

	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			table.customers.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}

	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowDetailSegue" {
			let guestDetailViewController = segue.destination as! GuestDetailViewController
			if let indexPath = tableView.indexPathForSelectedRow {
				guestDetailViewController.customer = table.customers[indexPath.row]
			}
		}
		if segue.identifier == "ShowBillSegue" {
			let billViewController = segue.destination as! BillViewController
			billViewController.table = table
		}
	}

}
