//
//  ViewController.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/2/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TableViewController: SwipeCellTableViewController {
    
    let realm = try! Realm();
    var tasks : Results<Task>?; 
    var selectedCategory: Category?{
        didSet{
            tasks = selectedCategory?.tasks.sorted(byKeyPath: "task", ascending: true)
            tableView.reloadData();
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80;
        tableView.separatorStyle = .none
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        navigationItem.title = selectedCategory?.name;
        navigationController?.navigationBar.barTintColor = UIColor(hexString: (selectedCategory?.color)!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(white: 1.0, alpha: 0.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 1;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel!.text = tasks?[indexPath.row].task ?? "No Task created yet";
        
        let percentage = CGFloat(indexPath.row) / CGFloat((tasks?.count)!);
        let color : UIColor = (HexColor((selectedCategory?.color)!)!).darken(byPercentage: percentage)!
        cell.backgroundColor = color;
        cell.textLabel?.textColor = ContrastColorOf(/*UIColor(white: 1.0, alpha: 1.0)*/color, returnFlat: true) //UIColor(white: 1, alpha: 1)//

        
        if(tasks?[indexPath.row].completed == true){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none;
        }
        return cell;
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let task = tasks?[indexPath.row]{
            
            do{
                try realm.write {
                    task.completed = !task.completed;
                }
            }catch{
                print("error")
            }
            
        }
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let task = Task()
        
        let alert = UIAlertController(title: "Add task", message: "Add a task", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add task", style: .default) { (action) in
            task.task = (alert.textFields?[0].text)!;
            task.completed = false;
            
            do{
                try self.realm.write {
                    self.selectedCategory?.tasks.append(task)
                }
            }catch{
                print(error)
            }
        
            self.tableView.reloadData();
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a task";
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func updateModel(at indexPath: IndexPath){
        do{
            try self.realm.write {
                self.realm.delete(self.tasks![indexPath.row])
            }
        }catch{
            print(error)
        }
    }
    
}

extension TableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        tasks = tasks?.filter("task CONTAINS[cd] %a", searchBar.text!).sorted(byKeyPath: "task", ascending: true)
        tableView.reloadData();
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if((searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) || searchBar.text == nil){
            tasks = selectedCategory?.tasks.sorted(byKeyPath: "task", ascending: true)
            DispatchQueue.main.async {
                searchBar.resignFirstResponder();
            }
            
            tableView.reloadData();
            
        }
        
    }
    
}
