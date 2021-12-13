//
//  UsersListCell.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 28/05/2019.
//

import UIKit

class UsersListCell: UITableViewCell, ConfigurableCell {
    typealias T = UserModel.user
    
    // MARK: - Variables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.masksToBounds = false
        self.containerView.layer.cornerRadius = 14
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func configureCell(with item: UserModel.user) {
        self.nameLabel.text = item.name!
        self.usernameLabel.text = "@" + item.username!
        self.emailLabel.text = item.email!
    }
}
