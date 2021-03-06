//
//  ViewController.swift
//  Todoey
//
//  Created by Steven Robertson on 12/23/17.
//  Copyright © 2017 Steven Robertson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

//    var itemArray = ["Col. 1","Col. 2", "Col. 3"]
//        //[Item]()
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
//        let newItem = Item()
//        newItem.title = "Phil. 1"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Phil. 2"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Phil. 3"
//        itemArray.append(newItem3)
//        
        loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
//           itemArray = items
//        }
   }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        //cell.textLabel?.text = itemArray[indexPath.row].title
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
//Longest way
//        if item.completed == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }

// still longer than needed
//cell.accessoryType = item.completed == true ? .checkmark : .none

        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //print(textField)
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            //self.itemArray.append(textField.text!)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("There was an error loading, \(error)")
            }
    }
}

}













