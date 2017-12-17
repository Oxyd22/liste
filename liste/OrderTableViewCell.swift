//
//  OrderTableViewCell.swift
//  Aufteilen
//
//  Created by Jesaja on 11.11.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    var delegate: Waiters!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func duplicateOrderButton(_ sender: UIButton) {
        delegate.newOrderForGuest(name: name.text, price: price.text)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
