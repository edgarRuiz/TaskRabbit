//
//  CategoryTableViewController.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/10/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: SwipeCellTableViewController {
  
    let realm = try! Realm();
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = realm.objects(Category.self)
        tableView.rowHeight = 80;
        tableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as! SwipeTableViewCell;
        cell.textLabel!.text = categories?[indexPath.row].name ?? "No Categories added yet!";
//        cell.delegate = self;
        return cell;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToTasks", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow;
        
        let destinationController = segue.destination as! TableViewController;
        destinationController.selectedCategory = categories?[indexPath!.row];
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        let category = Category();
        
        let alert = UIAlertController(title: "Add Category", message: "Add a Category", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            category.name = (alert.textFields?[0].text)!;
            self.saveItems(category: category);
            
            self.tableView.reloadData();
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a task";
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveItems(category: Category){
        
        do {
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error saving context \(error)")
        }
    }
    
    override func updateModel(at indexPath: IndexPath){
        do{
            try self.realm.write {
                self.realm.delete(self.categories![indexPath.row])
               // self.tableView.reloadData()
            }
        }catch{
            print(error)
        }
    }

    //here//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else {return nil}
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {action, indexPath in
//            do{
//                try self.realm.write {
//                    self.realm.delete(self.categories![indexPath.row])
//                   // self.tableView.reloadData()
//                }
//            }catch{
//                print(error)
//            }
//        }
//
//        deleteAction.image = UIImage(named:"delete")
//
//        return [deleteAction];
//
//    }
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//        var options = SwipeTableOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
    
    
    
    
}
