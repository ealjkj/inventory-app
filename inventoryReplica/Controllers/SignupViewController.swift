//
//  SignupViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 29/06/23.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var termRange = NSRange()
    var privacyRange = NSRange()
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        scrollView.isScrollEnabled = true
//        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: errorLabel.frame.maxY)
        
        scrollView.contentSize = CGSizeMake(2000, 2000);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        
        
        //Email keyboard
        emailTextField.keyboardType = .emailAddress
        
        // Do any additional setup after loading the view.
        termsAndConditionsLabel.isUserInteractionEnabled = true
        
        let attributedString = NSMutableAttributedString(string: termsAndConditionsLabel.text ?? "")

        termRange = (attributedString.string as NSString).range(of: "Terms & Conditions")
        
        privacyRange = (attributedString.string as NSString).range(of: "Privacy Policy")
        

        attributedString.addAttribute(.link, value: "https://example.com/terms", range: termRange)
        attributedString.addAttribute(.link, value: "https://example.com/privacy", range: privacyRange)

        // Apply blue color to the link ranges
//        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: termRange)
//        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: privacyRange)

        termsAndConditionsLabel.attributedText = attributedString
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        termsAndConditionsLabel.addGestureRecognizer(tapGesture)
        termsAndConditionsLabel.isUserInteractionEnabled = true
        
    }
    
    @objc private func labelTapped(_ gesture: UITapGestureRecognizer) {
        let text = termsAndConditionsLabel.text!
        
        if gesture.didTapAttributedText(in: termsAndConditionsLabel, inRange: termRange) {
            if let url = URL(string: "https://www.google.com") {
                UIApplication.shared.open(url)
            }
        } else if gesture.didTapAttributedText(in: termsAndConditionsLabel, inRange: privacyRange) {
            // Handle tap on "Privacy Policy"
            if let url = URL(string: "https://example.com/privacy") {
                UIApplication.shared.open(url)
            }
        }
    }

    @IBAction func createAccount(_ sender: UIButton) {
        startSpinner()
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail:  email, password: password) { authResult, error in
                
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                    self.errorLabel.isHidden = false
                    self.stopSpinner()
                } else {
                    self.stopSpinner()
                    self.performSegue(withIdentifier: "RegisterToApp", sender: self)
                    
                }
                
            }
        }

    }
    
    func startSpinner() {
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
    }
    
}

extension UITapGestureRecognizer {
    func didTapAttributedText(in label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attributedText = label.attributedText else {
            return false
        }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let location = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (label.bounds.width - textBoundingBox.width) * 0.5 - textBoundingBox.minX,
                                          y: (label.bounds.height - textBoundingBox.height) * 0.5 - textBoundingBox.minY)
        
        let locationInTextContainer = CGPoint(x: location.x - textContainerOffset.x,
                                              y: location.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationInTextContainer,
                                                             in: textContainer,
                                                             fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
