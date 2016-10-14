//
//  ViewController.swift
//  CoreTodoList
//
//  Created by Praveen Samuel . J on 14/10/16.
//  Copyright © 2016 Praveen Samuel . J. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // get the data from core data
        getData()
    
        //reload the tableview
        
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = tableView.cellForRow(at: indexPath)
        
        if selectedRow?.accessoryType == UITableViewCellAccessoryType.none {
            selectedRow?.accessoryType = UITableViewCellAccessoryType.checkmark
            selectedRow?.tintColor = UIColor.green
        }
        else {
            selectedRow?.accessoryType = UITableViewCellAccessoryType.none
        }
    }
    
    
    
    func getData() {
        
        do {
        tasks = try context.fetch(Task.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            
            context.delete(task)

            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch{
                print("Fetching Failed")
            }
            
            tableView.reloadData()
            
        }
        
    }
}

