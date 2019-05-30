//
//  UsersListCell.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 28/05/2019.
//

import UIKit

class UsersListCell: UITableViewCell {

    // MARK: - Variables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(item: Users.utilisateur) {
        //
        self.nameLabel.text = item.name!
        self.usernameLabel.text = "@" + item.username!
        self.emailLabel.text = item.email!
    }
}
