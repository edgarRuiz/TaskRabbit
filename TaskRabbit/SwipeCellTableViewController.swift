//
//  SwipeCellTableViewController.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/22/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeCellTableViewController: UITableViewController, SwipeTableViewCellDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    
    func updateModel(at indexPath: IndexPath){
        //Will be overriden
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {action, indexPath in
//            do{
//                try self.realm.write {
//                    self.realm.delete(self.categories![indexPath.row])
//                    // self.tableView.reloadData()
//                }
//            }catch{
//                print(error)
//            }
            self.updateModel(at:indexPath);
        }
        
        deleteAction.image = UIImage(named:"delete")
        
        return [deleteAction];
        
    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell;
        cell.delegate = self;
        return cell;
    }

    
}
