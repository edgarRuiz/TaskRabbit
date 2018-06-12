//
//  ViewController.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/2/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var tasks : [Task] = [Task]();
    var selectedCategory: Category?{
        didSet{
            print("this did indeed work")
            let request : NSFetchRequest<Task> =  Task.fetchRequest();
            request.predicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name!)!)
            do{
                tasks = try context.fetch(request);
            }catch{
                print("Error fetching \(error)")
            }
            tableView.reloadData();
            
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;



    override func viewDidLoad() {
        super.viewDidLoad()        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        let task = Task(context: context)
        
        let alert = UIAlertController(title: "Add task", message: "Add a task", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add task", style: .default) { (action) in
            task.task = (alert.textFields?[0].text)!;
            task.completed = false;
            task.parentCategory = self.selectedCategory;
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
        
        do {
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
    }
    
}

extension TableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
            
            let request : NSFetchRequest<Task> =  Task.fetchRequest();
            let predicate = NSPredicate(format: "task CONTAINS[cd] %@", searchBar.text!);
            
            request.predicate = predicate;
            
            do{
                try tasks = context.fetch(request);
            }catch{
                print("error");
            }
        
        
        
        
        tableView.reloadData();
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if((searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) || searchBar.text == nil){
            let request : NSFetchRequest<Task> =  Task.fetchRequest();
            request.predicate = NSPredicate(format: "parentCategory.name MATCHES %@",(selectedCategory?.name!)!)
            do{
                tasks = try context.fetch(request);
            }catch{
                print("Error fetching \(error)")
            }
            DispatchQueue.main.async {
                searchBar.resignFirstResponder();
            }
            
            tableView.reloadData();

        }
        
    }
    
}
