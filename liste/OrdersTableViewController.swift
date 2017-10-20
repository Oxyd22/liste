//
//  OrdersTableViewController.swift
//  test
//
//  Created by Daniel Riewe on 15.09.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    var tisch: Table!
    var totalOrders: [(element: Order, count: Int)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let rootTabBarViewController = self.tabBarController as! RootTabBarViewController
        self.tisch = rootTabBarViewController.tisch
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.totalOrders = self.tisch.bill.totalOrders
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return totalOrders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCellIdentifier", for: indexPath)
        
        let item = totalOrders[indexPath.row]
        let artikelName = item.element.item.name
        let artikelPreiss = CurrencyFormater.getCurrencyString(number: item.element.item.price)
        let preissSumme = item.element.item.price * Double(item.count)
        let count = item.count
        cell.textLabel?.text = "\(count) - \(artikelName)"
        cell.detailTextLabel?.text = "Stück: \(artikelPreiss) * \(count) = \(preissSumme)"
        return cell
    }
    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            bestellungen.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let orderDetailsViewController = segue.destination as! OrderDetailsViewController
        if segue.identifier == "orderDetailSegue" {
            if tableView.indexPathForSelectedRow != nil {
                
            }
            orderDetailsViewController.tisch = tisch
        }
     }
    
    
}
