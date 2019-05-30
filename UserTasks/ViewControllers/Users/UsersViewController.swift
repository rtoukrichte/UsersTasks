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
    var users : [Users.utilisateur]?
    
    // MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
  
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
  
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Liste des utilisateurs"
        self.loader.startAnimating()
        self.loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        self.loadUsers()
    }
    
    func loadUsers() {
        if UsersService.sharedInstance.isNetworkReachable() {
            UsersService.sharedInstance.loadUsers { (success, users) in
                print("Success")
                self.users = users
                self.tableView.isHidden = false
                self.loader.stopAnimating()
                self.tableView.reloadData()
            }
        }
        else{
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
        if self.users != nil, (self.users?.count)! > 0 {
            return self.users!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UsersListCell
        if  let c = tableView.dequeueReusableCell(withIdentifier: "UsersListCell") as? UsersListCell{
            cell = c
        }else{
            let nib = Bundle.main.loadNibNamed("UsersListCell", owner: self, options: nil)! as NSArray
            cell = nib[0] as! UsersListCell
        }

        cell.fill(item: (self.users?[indexPath.row])!)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = TasksViewController(nibName: "TasksViewController", bundle: nil)
        if self.users?[indexPath.row] != nil {
            controller.userDetail((self.users?[indexPath.row])!)
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

