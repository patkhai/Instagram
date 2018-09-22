//
//  MainViewController.swift
//  Instagram
//
//  Created by Pat Khai on 9/20/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Parse


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var imageFeed: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  100
        

        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
//        let message = messages[indexPath.row]
//        let chat_message = message["text"] as! String
//        cell.chatMessage.text = chat_message
//
//        if let user = message["user"] as? PFUser {
//            // User found! update username label with username
//            cell.chatID.text = user.username
//        } else {
//            // No user found, set default username
//            cell.chatID.text = "🤖"
//        }
        return cell
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
                
                self.performSegue(withIdentifier: "logout", sender: nil)
            }
            
        })
    }
    
    
    
    func alertControl2 () {
        let alertController = UIAlertController(title: "Network Error while logging out", message: "Try again" , preferredStyle: .alert)
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
        
        //        }
        //        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
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
