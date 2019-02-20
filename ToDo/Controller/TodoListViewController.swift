//
//  ViewController.swift
//  ToDo
//
//  Created by Nathan Abraham on 2019-02-18.
//  Copyright © 2019 Nathan Abraham. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var item = [Item]()
    
    // Url for local plist
    let datapath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(datapath)
        /**
         let newItem = Item()
        newItem.title = "Fridge"
        
        item.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Business Account"
        
        item.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Zoning"
        
        item.append(newItem2)
        */
        decodeData()
        
        
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
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(self.item[indexPath.row])
        
        item[indexPath.row].done = !item[indexPath.row].done
       
        encodeData()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //Mark - Model Manipulation
    
    func encodeData() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(item)
            try data.write(to: datapath!)
        }catch {
            print("Error encoding item, \(error)")
        }
        
    }
    
    func decodeData() {
        if let data = try? Data(contentsOf: datapath!) {
            let decoder = PropertyListDecoder()
            do {
            item = try decoder.decode([Item].self, from: data)
            }catch {
                print("Error decoding item, \(error)")

            }
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
            
            let newi = Item()
            newi.title = textField.text!
            
            if (!textField.text!.isEmpty) {
                self.item.append(newi)

                self.encodeData()
                
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

