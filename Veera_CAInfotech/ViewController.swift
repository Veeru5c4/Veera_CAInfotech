//
//  ViewController.swift
//  Veera_CAInfotech
//
//  Created by Veeraswamy on 19/10/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import SCLAlertView
class ViewController: UIViewController {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        guard txtUserName.text!.isEmpty == false else {
            self.showLocalError(errorMsg: "Please enter Name", title: "Alert")
            return
        }
        guard txtPassword.text!.isEmpty == false else {
            self.showLocalError(errorMsg: "Please enter password", title: "Alert")
            return
        }
       
       if(txtUserName.text == "Admin" && txtPassword.text == "Admin")
       {
            self.performSegue(withIdentifier:"detail", sender:nil)
        return
       }
       else{
        self.showLocalError(errorMsg: "Please enter Valid Credentails", title: "Alert")
        return
        }
    }
    @IBAction func signUpClciked(_ sender: UIButton) {
        self.performSegue(withIdentifier:"signUP", sender:nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showLocalError(errorMsg: String,title:String = "Oops!") {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showWarning(title, subTitle: errorMsg)
    }

}

