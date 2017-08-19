//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Apostolos Chalkias on 18/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }

    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    

    @IBAction func createAccountPressed(_ sender: Any) {
        
        //Unrwap values
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        //Call authservie
        AuthService.instance.registerUser(email: email, passworrd: pass) { (success) in
            if success {
                print("Registered User!")
            }
        }
        
        
    }
    
}
