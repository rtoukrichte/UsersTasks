//
//  UsersViewController.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 28/05/2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let userProvider = DataProvider()
    var users: [Users.user]?
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Utilisateurs"

        tableView.register(UsersListCell.nib, forCellReuseIdentifier: UsersListCell.reuseIdentifier)
        
        self.loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    func loadUsers() {
        self.loader.startAnimating()
        if UserService.shared.isNetworkReachable() {
            UserService.shared.loadUsers { (success, users) in
                self.users = users
                self.tableView.isHidden = false
                self.loader.stopAnimating()
                self.tableView.reloadData()
            }
        }
        else{
            self.loader.stopAnimating()
            self.users = userProvider.users
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: UsersListCell.reuseIdentifier) as! UsersListCell
        cell.configureCell(with: (self.users?[indexPath.row])!)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskController = TasksViewController(nibName: "TasksViewController", bundle: nil)
        if let user = self.users?[indexPath.row] {
            taskController.userDetail(user)
        }
        self.navigationController?.pushViewController(taskController, animated: true)
    }
}

