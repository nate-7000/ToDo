//
//  ViewController.swift
//  ToDo
//
//  Created by Nathan Abraham on 2019-02-18.
//  Copyright © 2019 Nathan Abraham. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var item = [Item]()
    
    // Url for local plist
    let datapath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // Context with ref to app delegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Tableview DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let i = item[indexPath.row]
        
        cell.textLabel?.text = i.title
        
        cell.accessoryType = i.done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview De   legate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(self.item[indexPath.row])
        
        item[indexPath.row].done = !item[indexPath.row].done
       
        saveItems()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //Mark - Model Manipulation
    
    func saveItems() {
        
        do {
           try context.save()
        }catch {
           print("Error saving context with \(error)")
        }
        
    }
    

    func loadItems() {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            item = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
        
    }
    
    //MARK - Add new Items +
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
    
        // Local var
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        // Add button. Will display when add is pressed
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What happens when action pressed
            
            
            let newi = Item(context: self.context)
            
            newi.title = textField.text!
            
            newi.done = false
            
            if (!textField.text!.isEmpty) {
                self.item.append(newi)

                self.saveData()
                
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

