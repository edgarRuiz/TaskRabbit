//
//  ViewController.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/2/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last;
    
    var tasks : [Task] = [Task]();
    var defaults = UserDefaults.standard;


    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath);
        if let data = UserDefaults.standard.data(forKey: "tasksArray"){
            tasks = (NSKeyedUnarchiver.unarchiveObject(with: data) as? [Task])!
//            for task in tasks {
//                print(task.completed)
//            }
        } else {
            print("There is an issue")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tasks.count;
        return tasks.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath);
        cell.textLabel!.text = tasks[indexPath.row].task;
        if(tasks[indexPath.row].completed == true){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none;
        }
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tasks[indexPath.row].completed = !tasks[indexPath.row].completed
        
        saveItems();

        tableView.reloadData();
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let task : Task = Task();
        
        let alert = UIAlertController(title: "Add task", message: "Add a task", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add task", style: .default) { (action) in
            task.task = (alert.textFields?[0].text)!;
            self.tasks.append(task);
            self.saveItems();

            self.tableView.reloadData();
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a task";
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: tasks)
        defaults.set(encodedData, forKey: "tasksArray")
        
    }
    
}

