//
//  GuestDetailViewController.swift
//  liste
//
//  Created by Daniel Riewe on 21.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class GuestDetailViewController: UIViewController, UITextFieldDelegate {
    var guest: Gast!
    var delegate: MasterViewDataSetter!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let guest = guest {
            nameTextField.text = guest.name
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            let guest = Gast(name: text)
            self.guest = guest
            delegate.newGuestOnTable(guest: guest)
        }
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
     }
    
    
}
