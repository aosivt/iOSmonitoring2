//
//  Auth_Message.swift
//  iOSmonitoring
//
//  Created by Ощепков Александр Юрьевич on 09.06.15.
//  Copyright (c) 2015 Ощепков Александр Юрьевич. All rights reserved.
//

import Foundation
import UIKit 

class auth : UITableViewController {
    private weak var check_yes: UIAlertAction?
    private  weak var t_user:UITextField?
    private weak var t_pass:UITextField?
    
    private var str_u: NSString = "";
    private var str_p: NSString = "";
    
    
    func create_alert(vc_master: MasterViewController)
    {
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

//        vc_master.presentViewController(alert, animated: false, completion: nil)
        
        
        //var master_vc: MasterViewController
        //master_vc.self.presentViewController(alert, animated: true, completion: nil)

        //presentViewController!(alert, animated: false, completion: nil)
        
        alert.addAction(check_yes)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel, handler: nil))

        vc_master.presentViewController(alert, animated: false, completion: nil)


    }
    func create_soap_auth(str_u:NSString?, str_p:NSString?)
    {
        
        
        var test_alert = UIAlertView()
        
        test_alert.message = "UserName: sibcem/\(str_u) ||| Pass: \(str_p)" + str_u!
        test_alert.addButtonWithTitle("No")
        test_alert.show()
        
        
        
    }

}