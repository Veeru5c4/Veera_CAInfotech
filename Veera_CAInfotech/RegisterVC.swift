//
//  RegisterVC.swift
//  Veera_CAInfotech
//
//  Created by Veeraswamy on 19/10/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView
class RegisterVC: UIViewController {

    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
     @IBOutlet weak var updateButton: UIButton!
     var iscomingFrom:String!
    var name:String!
    var email:String!
    var phone:String!
    var location:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        if(iscomingFrom == "Yes")
        {
            txtName.text = name;
            txtEmail.text = email;
            txtPhone.text = phone;
            txtLocation.text = location;
            self.updateButton.setTitle("Update", for: UIControlState.normal)
        }
        else{
            txtName.text = "";
            txtEmail.text = "";
            txtPhone.text = "";
            txtLocation.text = "";
            self.updateButton.setTitle("Submit", for: UIControlState.normal)
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func submitBtnClicked(_ sender: UIButton) {
        
        if(self.updateButton.titleLabel?.text == "Update" )
        {
            guard txtName.text?.isEmpty == false && txtEmail.text?.isEmpty == false && txtPhone.text?.isEmpty == false && txtLocation.text?.isEmpty == false  else {
                showLocalError(errorMsg: "All fields are requird", title: "Alert")
                return
            }
            guard (txtEmail.text?.isEmail())! else {
                self.showLocalError(errorMsg: "Invalid email", title: "Alert")
                return
            }
            
            updateRegisterData()
        }
        
        else{
            guard txtName.text?.isEmpty == false && txtEmail.text?.isEmpty == false && txtPhone.text?.isEmpty == false && txtLocation.text?.isEmpty == false  else {
                showLocalError(errorMsg: "All fields are requird", title: "Alert")
                return
            }
            guard (txtEmail.text?.isEmail())! else {
                self.showLocalError(errorMsg: "Invalid email", title: "Alert")
                return
            }
            
            registerwithUserData()
        }
        

    }
    
    func updateRegisterData(){
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "(name = %@)", txtName.text!)
        request.predicate = predicate
        do {
            var results =
                try managedContext.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            objectUpdate.setValue(txtName.text!, forKey: "name")
            objectUpdate.setValue(txtEmail.text!, forKey: "email")
             objectUpdate.setValue(txtPhone.text!, forKey: "phone")
            objectUpdate.setValue(txtLocation.text!, forKey: "location")
            do {
                try managedContext.save()
                txtName.text = ""
                txtPhone.text = ""
                txtEmail.text = ""
                txtLocation.text = ""
            }catch let error as NSError {
                
            }
        }
        catch let error as NSError {
           
        }
    }
    
    func registerwithUserData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(txtName.text, forKeyPath: "name")
        user.setValue(txtEmail.text, forKey: "email")
        user.setValue(txtPhone.text, forKey: "phone")
        user.setValue(txtPhone.text, forKey: "location")
        
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
                    txtName.text = "";
                    txtEmail.text = ""
                    txtLocation.text = ""
                    txtPhone.text = ""
            self.showLocalError(errorMsg: "Registration Success", title: "Alert")
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func showLocalError(errorMsg: String,title:String = "Oops!") {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showWarning(title, subTitle: errorMsg)
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
extension String{
    func isEmail() -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
