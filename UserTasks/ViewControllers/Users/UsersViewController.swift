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
    @IBOutlet weak var lblError: UILabel!
    
    var users: [UserModel.user]?
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Users"

        tableView.register(UsersListCell.nib, forCellReuseIdentifier: UsersListCell.reuseIdentifier)
        
        self.loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func loadUsers() {
        self.loader.startAnimating()
        if UserService.shared.isNetworkReachable() {
            UserService.shared.loadUsers { (success, users) in
                guard success, users != nil else {
                    self.lblError.isHidden = false
                    self.tableView.isHidden = true
                    self.loader.stopAnimating()
                    self.lblError.text = "Data not available, try later"
                    return
                }
                self.users = users
                self.tableView.isHidden = false
                self.loader.stopAnimating()
                self.tableView.reloadData()
            }
        }
        else{
            self.loader.stopAnimating()
            let users = CoreDataManager.shared.fetchUsers()
            if users?.count ?? 0 > 0 {
                self.tableView.isHidden = false
                self.users = users
                self.tableView.reloadData()
            }
            else{
                self.lblError.isHidden = false
                self.lblError.text = "Please check your connection network"
            }
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

