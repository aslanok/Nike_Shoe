//
//  TableViewCell.swift
//  NikeApp
//
//  Created by MacBook on 16.09.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
