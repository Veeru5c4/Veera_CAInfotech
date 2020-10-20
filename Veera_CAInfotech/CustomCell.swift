//
//  CustomCell.swift
//  Veera_CAInfotech
//
//  Created by Veeraswamy on 19/10/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
protocol YourCellDelegate: class {
    func didTapButton(_ sender: UIButton)
}

class CustomCell: UITableViewCell {
    weak var delegate: YourCellDelegate?
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deletebuttonTapped(_ sender: UIButton) {
        delegate?.didTapButton(sender)
    }
    @IBAction func updatebuttonTapped(_ sender: UIButton) {
        delegate?.didTapButton(sender)
    }
}
