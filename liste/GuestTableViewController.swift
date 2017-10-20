//
//  DinnerTableViewController.swift
//  test
//
//  Created by Daniel Riewe on 13.09.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit


class GuestTableViewController: UITableViewController {
    var tisch: Table!
    @IBOutlet weak var summLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //         self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let rootTabBarViewController = self.tabBarController as! RootTabBarViewController
        self.tisch = rootTabBarViewController.tisch
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
        let summ = tisch.bill.totalAmount()
        summLabel.text = CurrencyFormater.getCurrencyString(number: summ)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tisch.customers.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestCellIdentifier", for: indexPath)
        let guest = tisch.customers[indexPath.row]
        let name = guest.name
        let summe = guest.bill.totalAmount()
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = CurrencyFormater.getCurrencyString(number: summe)
        
        return cell
    }
    
    func newGuestOnTable(name: String) {
        if name != "" {
            tisch.addCustomer(name: name)
            let count = tisch.customers.count - 1
            let indexPath = IndexPath(row: count, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    @IBAction func addGuestButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Gast hinzufügen", message: "Geben Sie den Namen des Gastes ein.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let nameTextField = alertController.textFields![0] as UITextField
            self.newGuestOnTable(name: nameTextField.text!)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tisch.customers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! GuestDetailViewController
        if segue.identifier == "ShowDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.guest = tisch.customers[indexPath.row]
            }
        }
    }
    
    
}
