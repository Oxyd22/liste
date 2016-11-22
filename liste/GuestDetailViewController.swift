//
//  GuestDetailViewController.swift
//  liste
//
//  Created by Daniel Riewe on 21.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class GuestDetailViewController: UIViewController {
    var guest: Gast!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let guest = guest {
            nameTextField.text = guest.name
        }
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newOrderForGuest(name: String, price: String) {
        guard name != "", price != "" else {
            return
        }
        guard let priceNumber = Double(price) else {
            return
        }
        guest.bestellen(name: name, preiss: priceNumber)
        let count = guest.bestellungen.count - 1
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

extension GuestDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let guest = guest {
            return guest.bestellungen.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestDetailIdentifier", for: indexPath)
        let name = guest.bestellungen[indexPath.row].artikel.name
        let price = guest.bestellungen[indexPath.row].artikel.preiss
        cell.textLabel?.text = "\(name) - \(price)"
        
        return cell
    }
}

extension GuestDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guest.bestellungen.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
