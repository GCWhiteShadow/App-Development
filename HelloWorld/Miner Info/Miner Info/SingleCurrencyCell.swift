//
//  SingleCurrencyCell.swift
//  Miner Info
//
//  Created by GCWhiteShadow on 2017/6/27.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import UIKit

class SingleCurrencyCell: UITableViewCell {
    @IBOutlet weak var currencyType: UILabel!
    @IBOutlet weak var pricing: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
