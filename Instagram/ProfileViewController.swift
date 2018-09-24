//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Pat Khai on 9/23/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import ParseUI


class ProfileViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var userName: UILabel!
    

    @IBOutlet weak var photoView: PFImageView!
    
    var updatePost : Post!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.file = updatePost.media
        
        // get description
        userName.text = PFUser.current()?.username!
        caption.text = updatePost.caption
        
        dateLabel.text = updatePost.date

        // Do any additional setup after loading the view.
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
