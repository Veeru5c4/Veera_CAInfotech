//
//  detailsVC.swift
//  Veera_CAInfotech
//
//  Created by Veeraswamy on 19/10/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit
import CoreData
class detailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource
  {
    @IBOutlet weak var tblView: UITableView!
    var stuInfo = [student]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        getStudentsDetails()
        tblView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    func getStudentsDetails() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
//         var stuInfo = [student]()
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
           
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                print(data.value(forKey: "email") as! String)
                let stu = student()
                stu.stu_name = data.value(forKey: "name") as! String
                stu.stu_email = data.value(forKey: "email") as! String
                stu.stu_phone = data.value(forKey: "phone") as! String
                stu.stu_location = data.value(forKey: "location") as! String
                stuInfo.append(stu)
                
            }
            
        } catch {
            
            print("Failed")
        }
        
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stuInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.lblName.text = self.stuInfo[indexPath.row].stu_name
        cell.lblEmail.text = self.stuInfo[indexPath.row].stu_email
        cell.lblPhone.text = self.stuInfo[indexPath.row].stu_phone
        cell.lblLocation.text = self.stuInfo[indexPath.row].stu_location
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonSelected), for: .touchUpInside)
        cell.updateButton.tag = indexPath.row
        cell.updateButton.addTarget(self, action: #selector(updateButtonSelected), for: .touchUpInside)
        return cell;
    }
    
    // MARK: - Table view Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 106
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func deleteButtonSelected(sender: UIButton){
        print(sender.tag)
        if let indexPath = getCurrentCellIndexPath(sender) {
           
            deleteData(indexPath: sender.tag)
          }
         tblView.reloadData()
        tblView.dataSource = self;
        tblView.delegate = self;
    }
    
    @objc func updateButtonSelected(sender: UIButton){
       
        
            if let indexpath = getCurrentCellIndexPath(sender)
            {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let fddVc = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            
           fddVc.name = self.stuInfo[indexpath.row].stu_name
          fddVc.email = self.stuInfo[indexpath.row].stu_email
          fddVc.phone = self.stuInfo[indexpath.row].stu_phone
                fddVc.location = self.stuInfo[indexpath.row].stu_location
            fddVc.iscomingFrom = "Yes"
            
            self.navigationController?.pushViewController(fddVc, animated: true)
        }
       
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            
    }
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tblView)
        if let indexPath: IndexPath = tblView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }

    func deleteData(indexPath:Int){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
     //fetchRequest.predicate = NSPredicate(format: "name =\(name)")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[indexPath] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
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

// Model Class

class student  {
    var stu_name : String = ""
    var stu_email : String = ""
    var stu_phone : String = ""
    var stu_location : String = ""
}
