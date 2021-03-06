//
//  MainViewController.swift
//  Instagram
//
//  Created by Pat Khai on 9/20/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import PKHUD


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  

    

    @IBOutlet weak var tableView: UITableView!
    
    
    var postView: [Post] = []
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 500
        let refreshControl = UIRefreshControl()
        self.loadPosts()
        
        
        PKHUD.sharedHUD.hide(afterDelay: 0.2)
        
        // Initialize a UIRefreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
   
        
    
        // Do any additional setup after loading the view.
    }
    
   
    
    private func loadPosts() {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.includeKey("createdAt")
        query.limit = 20
        
        // show HUD
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: tableView)
        
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                    self.postView = posts as! [Post]
                } else {
                    self.alertControl2()
                    print("error")
                }
            self.tableView.reloadData()
            }
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postView.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.postView.count != 0{
            return self.postView.count
        }else{
            print("no posts found")
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.updatePost = self.postView[indexPath.row]
        print(postView)
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let post = postView[indexPath.section]
            let ProfileController = segue.destination as! ProfileViewController
            ProfileController.updatePost = post
        }
    }
  

    @IBAction func logout(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                self.alertControl2()
                print(error.localizedDescription)
            } else {
                let user = PFUser.current() ?? nil
                print("Successful logout")
                print(user as Any)
                
                self.performSegue(withIdentifier: "log", sender: nil)
            }
            
        })
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        
    }
    
  
    
    func alertControl2 () {
        let alertController = UIAlertController(title: "Cannont find object in background", message: "Try again" , preferredStyle: .alert)
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
        
        //        }
        //        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        loadPosts()
        // Tell the refreshControl to stop spinning
        //self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
