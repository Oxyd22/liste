//
//  BillViewController.swift
//  liste
//
//  Created by Daniel Riewe on 18.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class BillViewController: UIViewController {
    var tisch: Tisch!
    @IBOutlet weak var billTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let rootTabBarViewController = self.tabBarController as! RootTabBarViewController
        self.tisch = rootTabBarViewController.tisch
    }

    override func viewWillAppear(_ animated: Bool) {
        var bill = ""
bill = tisch.rechnung.billPrint()
        for gast in tisch.gäste {
            let text = gast.rechnung.billPrint()
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
