//
//  GuestDetailViewController.swift
//  liste
//
//  Created by Daniel Riewe on 21.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class GuestDetailViewController: UIViewController {
	var customer: Customer!
	@IBOutlet var tableView: UITableView!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var totalAmountLabel: UILabel!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let name = customer.name
		nameTextField.text = name
		displaySummForAllOrders()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func displaySummForAllOrders() {
		let totalAmount = customer.bill.totalAmount()
		totalAmountLabel.text = CurrencyFormater.getCurrencyString(number: totalAmount)
		
	}
	
	func newOrderForGuest(name: String, price: String) {
		guard name != "", price != "" else {
			return
		}
		let priceNumber = CurrencyFormater.getDoubleValue(currencyString: price)
		customer.order(name: name, price: priceNumber)
		displaySummForAllOrders()
		let count = customer.orders.count - 1
		let indexPath = IndexPath(row: count, section: 0)
		tableView.beginUpdates()
		tableView.insertRows(at: [indexPath], with: .automatic)
		tableView.endUpdates()
	}
	
	@IBAction func addOrderButton(_ sender: UIButton) {
		let alertController = UIAlertController(title: "Bestellung hinzufügen", message: "Geben Sie Name und Preiss des Artikels ein.", preferredStyle: UIAlertControllerStyle.alert)
		alertController.addTextField { (textField) in
			textField.placeholder = "Name"
		}
		alertController.addTextField { (textField) in
			textField.placeholder = "Preiss"
			textField.keyboardType = .decimalPad
		}
		let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
			let nameTextField = alertController.textFields![0] as UITextField
			let priceTextField = alertController.textFields![1] as UITextField
			self.newOrderForGuest(name: nameTextField.text!, price: priceTextField.text!)
		}
		alertController.addAction(okAction)
		self.present(alertController, animated: true)
	}
	
	// MARK: - Navigation
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
		
	}
	
}

extension GuestDetailViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		if let text = textField.text {
			customer.name = text
		}
		return true
	}
}

extension GuestDetailViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let guest = customer {
			return guest.orders.count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "guestDetailIdentifier", for: indexPath)
		let name = customer.orders[indexPath.row].item.name
		let price = customer.orders[indexPath.row].item.price
		cell.textLabel?.text = name
		cell.detailTextLabel?.text = CurrencyFormater.getCurrencyString(number: price)
		return cell
	}
}

extension GuestDetailViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			customer.orders.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
}

