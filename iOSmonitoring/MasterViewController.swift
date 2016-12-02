//
//  MasterViewController.swift
//  iOSmonitoring
//
//  Created by Ощепков Александр Юрьевич on 08.06.15.
//  Copyright (c) 2015 Ощепков Александр Юрьевич. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {


    private weak var check_yes: UIAlertAction?
    private  weak var t_user:UITextField?
    private weak var t_pass:UITextField?
    
    private var str_u: NSString = "";
    private var str_p: NSString = "";


    var objects = NSMutableArray()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        var mastert_vc : auth = auth()

        mastert_vc.create_alert(self)
  /*      let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        var alert = UIAlertController(title: "Проверка пользователя", message: "Введите логин/пароль",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let check_yes = UIAlertAction(title: "Подтвердить", style: UIAlertActionStyle.Default, handler: {
            (action:UIAlertAction!) -> Void in
        
            
        self.create_soap_auth(self.str_u, str_p:self.str_p)
            
        })
        check_yes.enabled = false
        
        alert.addTextFieldWithConfigurationHandler{
            (t_user:UITextField!) in
            t_user.textColor = UIColor.blueColor()
            t_user.placeholder = "Имя пользователя"
            NSLog("str_u: %@", t_user.text)
        }

        
        alert.addTextFieldWithConfigurationHandler{
            (t_pass:UITextField!) in
            t_pass.textColor = UIColor.blueColor()
            t_pass.placeholder = "Пароль пользователя"
            t_pass.secureTextEntry = true
            
        }
         NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification,
            object: alert.textFields?[0],
            queue: NSOperationQueue.mainQueue()){(notification) -> Void in
                
                let t_user = alert.textFields?[0] as UITextField
                let t_pass = alert.textFields?[1] as UITextField
                check_yes.enabled = !t_user.text.isEmpty && !t_pass.text.isEmpty
                
                self.str_u = t_user.text
                self.str_p = t_pass.text
               
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification,
            object: alert.textFields?[1],
            queue: NSOperationQueue.mainQueue()){(notification) -> Void in
                
                let t_user = alert.textFields?[0] as UITextField
                let t_pass = alert.textFields?[1] as UITextField
                check_yes.enabled = !t_user.text.isEmpty && !t_pass.text.isEmpty
                
                self.str_u = t_user.text
                self.str_p = t_pass.text
                
                
        }
        
        presentViewController(alert, animated: false, completion: nil)

        alert.addAction(check_yes)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel, handler: nil))
    */
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as NSDate
            (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }
    func create_soap_auth(str_u:NSString?, str_p:NSString?)
    {
       
        var test_alert = UIAlertView()

        test_alert.message = "UserName: sibcem/\(str_u) ||| Pass: \(str_p)" + str_u!
        test_alert.addButtonWithTitle("No")
        test_alert.show()
    
    }
    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let object = objects[indexPath.row] as NSDate
        cell.textLabel.text = object.description
        return cell
        
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

