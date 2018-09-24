//
//  LoginViewController.swift
//  Instagram
//
//  Created by Pat Khai on 9/20/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
    }
   
    

    @IBAction func signIn(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                self.alertControl2()
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                
                self.performSegue(withIdentifier: "login", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
    }
        
        
    
    @IBAction func signUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                self.alertControl()
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "create", sender: nil)
                // manually segue to logged in view
            }
        }
        
    }
    
    
    
    func alertControl () {
        let alertController = UIAlertController(title: "Username already existed", message: "Try a new one" , preferredStyle: .alert)
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
        
        //        }
        //        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    
    func alertControl2 () {
        let alertController = UIAlertController(title: "Invalid username/password", message: "Try again" , preferredStyle: .alert)
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
