//
//  ViewController.swift
//  MyInfoStore
//
//  Created by Admin on 08/01/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var SourceTextField: UITextField!
    
    @IBOutlet var UsernameTextField: UITextField!
        
    @IBOutlet var PasswordTextField: UITextField!
    
    @IBOutlet var hintField: UITextField!
    
    @IBOutlet var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SourceTextField.layer.cornerRadius = 8.0
        UsernameTextField.layer.cornerRadius = 8.0
        PasswordTextField.layer.cornerRadius = 8.0
        hintField.layer.cornerRadius = 8.0
        saveBtn.layer.cornerRadius = 8.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BtnTapSave(_ sender: UIButton) {
        
        let appDelegates = UIApplication.shared.delegate as? AppDelegate
        
        let context = appDelegates?.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context!)
        let newUser = NSManagedObject(entity: entity!, insertInto: context!)
        
        newUser.setValue(SourceTextField.text, forKey: "source")
        
        newUser.setValue(UsernameTextField.text, forKey: "username")
        
        newUser.setValue(PasswordTextField.text, forKey: "password")
        
        newUser.setValue(hintField.text, forKey: "hint")
        do {
            try context?.save()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UsersViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }catch{
            print("Failed to save data!")
            
        }
        
        
    }
    
    


}

