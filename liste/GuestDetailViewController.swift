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
    
    @IBAction func addOrderButton(_ sender: UIButton) {
        guest.bestellen(name: "Pizza", preiss: 6.5)
        let count = guest.bestellungen.count - 1
        let indexPath = IndexPath(row: count, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
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
        
        cell.textLabel?.text = guest.bestellungen[indexPath.row].artikel.name
        
        return cell
    }
    
    
}
