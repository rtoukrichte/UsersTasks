//
//  TasksViewController.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 28/05/2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let taskProvider = DataProvider()
    var tasks : [Task]?
    var user : Users.user?
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "\(user?.name ?? "")'s tasks"

        tableView.register(TasksListCell.nib, forCellReuseIdentifier: TasksListCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUserTasks()
    }
    
    func loadUserTasks() {
        self.loader.startAnimating()
        if UserService.shared.isNetworkReachable() {
            UserService.shared.loadTasksUser(userId: (self.user?.id)!) { (success, tasks) in
                if success {
                    self.tasks = tasks
                    self.tableView.isHidden = false
                    self.loader.stopAnimating()
                    self.tableView.reloadData()
                }
                
            }
        }
        else{
            //self.tasks = taskProvider.tasks
            self.loader.stopAnimating()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Get object User
    func userDetail(_ user: Users.user) {
        self.user = user
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: TasksListCell.reuseIdentifier) as! TasksListCell
        if let task = self.tasks?[indexPath.row] {
            cell.configureCell(with: task)
        }
        return cell
    }

}
