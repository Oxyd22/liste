//
//  DinnerTableViewController.swift
//  test
//
//  Created by Daniel Riewe on 13.09.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

protocol MasterViewDataSetter {
    var tisch: Tisch { get set }
    func newGuestOnTable(guest: Gast)
}

class GuestTableViewController: UITableViewController, MasterViewDataSetter {
    var tisch: Tisch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let rootTabBarViewController = self.tabBarController as! RootTabBarViewController
        self.tisch = rootTabBarViewController.tisch
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
        return tisch.gäste.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = tisch.gäste[indexPath.row].name
        
        return cell
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
            tisch.gäste.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    func newGuestOnTable(guest: Gast) {
        tisch.addGast(gast: guest)
        
        tableView.insertRows(at: <#T##[IndexPath]#>, with: <#T##UITableViewRowAnimation#>)
    }
    
    
    @IBAction func addGuestButton(_ sender: UIBarButtonItem) {
        
        
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! GuestDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.guest = tisch.gäste[indexPath.row]
        }
    }
    
    
}