//
//  ViewController.swift
//  ToDo
//
//  Created by Nathan Abraham on 2019-02-18.
//  Copyright © 2019 Nathan Abraham. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var item = ["Fridge", "Donkey Do", "Pumper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Tableview DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        cell.textLabel?.text = item[indexPath.row]
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.item[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new Items +
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
    
        // Local var
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        // Add button. Will display when add is pressed
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What happens when action pressed
            
            if (!textField.text!.isEmpty) {
                self.item.append(textField.text!)
                
                self.tableView.reloadData()
            }
        }
        
        // Close button. Will display what happens when close is pressed
        let close = UIAlertAction(title: "Close", style: .default) { (close) in
            // What happens when action pressed
            print("Closing")
        }
        
        // Alert text field has a slightly narrower scope than add item pressed. var textField has a bigger scope
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item"
            
            textField = alertTextField
            
            print("Nowe")
            
        }
        alert.addAction(action)
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
    }
    


}

