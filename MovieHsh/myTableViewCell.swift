//
//  myTableViewCell.swift
//  MovieHsh
//
//  Created by sujin on 2022/11/16.
//

import UIKit

class myTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
