//
//  ViewController.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/2/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var newTask : String = ""
    var tasks : [String] = ["Finish TaskRabbit app" , "Learn Thai" , "Finish iOS Udemy classes"];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath);
        cell.textLabel!.text = tasks[indexPath.row];
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell;
        
        if currentCell.accessoryType == .checkmark{
            currentCell.accessoryType = .none
        }else{
            currentCell.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add task", message: "Add a task", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add task", style: .default) { (action) in
            self.newTask = (alert.textFields?[0].text)!;
            self.tasks.append(self.newTask);
            self.tableView.reloadData();
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a task";
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

