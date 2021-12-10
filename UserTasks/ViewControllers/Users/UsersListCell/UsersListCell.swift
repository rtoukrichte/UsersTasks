//
//  UsersListCell.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 28/05/2019.
//

import UIKit

class UsersListCell: UITableViewCell, ConfigurableCell {
    typealias T = Users.user
    
    // MARK: - Variables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with item: Users.user) {
        self.nameLabel.text = item.name!
        self.usernameLabel.text = "@" + item.username!
        self.emailLabel.text = item.email!
    }
}
