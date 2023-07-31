//
//  SignupViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 29/06/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        errorLabel.isHidden = true
        emailTextField.keyboardType = .emailAddress
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            login(with: email, password: password)
        } else {
            print("Type something")
        }
        
    }
    
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
    }
    
    func validateEmail(email: String) -> Bool {
        if email.contains("@") {return true}
        return false
    }
    
    func login(with email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if error != nil {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error?.localizedDescription
            } else{
                
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.performSegue(withIdentifier: "LoginToApp", sender: self)
            }
            self.stopSpinner()
        }
    }
    
    func startSpinner(){
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
}
