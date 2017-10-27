//
//  RootTabBarViewController.swift
//  liste
//
//  Created by Daniel Riewe on 18.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {
    let table = Table()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
	
	var tabBarController = segue.destination as UITabBarController
	var destinationViewController = tabBarController.viewControllers[0] as YourViewController // or whatever tab index you're trying to access
	destination.property = "some value"
	
    }
    */

}
