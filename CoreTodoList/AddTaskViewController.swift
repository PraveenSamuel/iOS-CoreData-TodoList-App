//
//  AddTaskViewController.swift
//  CoreTodoList
//
//  Created by Praveen Samuel . J on 14/10/16.
//  Copyright © 2016 Praveen Samuel . J. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // i am a addtask view containner
    
    @IBAction func btnTapped(_ sender: AnyObject) {
        
        if textField.text == "" {
            
            let alert = UIAlertController(title: "Enter item name" , message: "Item name can't be blank", preferredStyle: UIAlertControllerStyle.alert)

            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(action)
            
            alert.view.tintColor = UIColor.red
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        
        task.name = textField.text!
        
        // save the data to the core data
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
            
            
        }
        
        
        
        
        
    }
}
