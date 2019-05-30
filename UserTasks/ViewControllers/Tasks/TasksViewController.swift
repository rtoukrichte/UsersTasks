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
    var tasks : [Tasks]?
    var user : Users.utilisateur?
    
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
        self.title = "Mes Tâches"
        self.loader.startAnimating()
        self.loadUserTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUserTasks()
       
    }
    
    func loadUserTasks() {
        if UsersService.sharedInstance.isNetworkReachable() {
            UsersService.sharedInstance.loadTasksUser(userId: (self.user?.id)!) { (success, tasks) in
                print("Success")
                self.tasks = tasks
                self.tableView.isHidden = false
                self.loader.stopAnimating()
                self.tableView.reloadData()
            }
        }
        else{
            //self.tasks = taskProvider.tasks
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Get object User
    func userDetail(_ user: Users.utilisateur) {
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
        if self.tasks != nil, (self.tasks?.count)! > 0 {
            return self.tasks!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : TasksListCell
        if  let c = tableView.dequeueReusableCell(withIdentifier: "TasksListCell") as? TasksListCell{
            cell = c
        }else{
            let nib = Bundle.main.loadNibNamed("TasksListCell", owner: self, options: nil)! as NSArray
            cell = nib[0] as! TasksListCell
        }
        
        cell.fill(item: (self.tasks?[indexPath.row])!)
        return cell
    }

}
