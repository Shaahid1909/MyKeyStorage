//
//  UsersViewController.swift
//  MyInfoStore
//
//  Created by Admin on 08/01/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import CoreData
import SkeletonView


class UsersViewController: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource {
  
    
    
  //  var UserArr = NSMutableArray()
    
    var UserArr = [NSManagedObject]()
    
    @IBOutlet var tabView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabView.delegate = self
        tabView.estimatedRowHeight = 130
        tabView.dataSource = self
    
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            
            self.requestUserData()
            
            self.tabView.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.tabView.reloadData()
        }
        )
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabView.isSkeletonable = true
        tabView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: nil, transition: .crossDissolve(0.25))
    }
    
    func requestUserData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        req.returnsObjectsAsFaults = false
        
        do  {
            let result = try context.fetch(req)
            print("resultsdata=", result)
            for data in result as! [NSManagedObject]{
                UserArr.append(data)
            }
            print("userArr!!=", self.UserArr)
//            tabView.delegate = self
//            tabView.dataSource = self
         //   tabView.reloadData()
        }catch {
            print("failed")
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserArr.count
      }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return UserTableViewCell.identifier
    }
    
//   func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .delete {
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//            let context = appDelegate.persistentContainer.viewContext
//        let objectToDelete = UserArr[indexPath.row]
//            UserArr.remove(at: indexPath.row)
//            context.delete(objectToDelete)
//
//        //Attempt to save the object
//        do{
//          try appDelegate.saveContext()
//            tableView.deleteRows(at: [(indexPath as IndexPath)], with: .fade)
//        }
//        catch let error{
//          print("Could not save Deletion \(error)")
//        }
//
//            requestUserData()
//            tabView.reloadData()
//      }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
                      
                      let context = appDelegate.persistentContainer.viewContext
            let objectToDelete = self.UserArr[indexPath.row]
            self.UserArr.remove(at: indexPath.row)
                      context.delete(objectToDelete)

                  //Attempt to save the object
                  do{
                    try appDelegate.saveContext()
                      tableView.deleteRows(at: [(indexPath as IndexPath)], with: .fade)
                  }
                  catch let error{
                    print("Could not save Deletion \(error)")
                  }
                      
//            self.requestUserData()
//            self.tabView.reloadData()
            complete(true)
        }
        
        // here set your image and background color
        deleteAction.image = #imageLiteral(resourceName: "deletebin")
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        cell.sourceLab.text = (UserArr[indexPath.row] as AnyObject).value(forKey: "source") as? String
        cell.userLab.text = (UserArr[indexPath.row] as AnyObject).value(forKey: "username") as? String
        cell.passLab.text = (UserArr[indexPath.row] as AnyObject).value(forKey: "password") as? String
        
        
        return cell
      }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
