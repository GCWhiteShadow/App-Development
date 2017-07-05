//
//  statusCell.swift
//  Miner Info
//
//  Created by GCWhiteShadow on 2017/6/26.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import UIKit

class statusCell: UITableViewCell {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var detailLabelText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
