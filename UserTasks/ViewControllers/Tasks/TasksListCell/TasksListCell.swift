//
//  TasksListCell.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 28/05/2019.
//

import UIKit

class TasksListCell: UITableViewCell, ConfigurableCell {
    typealias T = TaskModel
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.viewStatus.layer.cornerRadius = CGFloat(self.viewStatus.bounds.width)/2.0
    }
    
    func configureCell(with item: TaskModel) {
        self.titleLabel.text = item.title
        if item.status ?? false {
            viewStatus.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else{
            viewStatus.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }
    }
}
