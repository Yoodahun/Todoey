//
//  ViewController.swift
//  Todoey
//
//  Created by 유다훈 on 2018. 9. 18..
//  Copyright © 2018년 PandaYoo. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //  create Items.plist

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        //저장된 아이템들을 꺼내서 다시 불러오는 것.
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        loadItems();
        
    }
    
    //MARK - TablewView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //셀을 재활용하고 있기때문에 체크표시와 같은 것들이 체크하지도않았는데 나오기도할 수도 있음.
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        
        return cell
    }

    //MARK - TableView Delegate Methods - 클릭할때마다 실행되는 메소드??
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //어떠한 셀이 선택되었을때 그 셀이 무엇인지 알려주는 메소드.

        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //when selectedItem is done? change to not done
        //Or selectedItem is not done? change to done

        saveItems()
        //save check
        
        tableView.deselectRow(at: indexPath, animated: true);
        tableView.reloadData() //reload table view
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController (title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
           
            self.saveItems();
            
            self.tableView.reloadData() //reload table view
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil) //show alert
        
    }
    
    //MARK - Model Manupulation Methods
    
    func saveItems() {
        //Save updated Item to UserDefaults
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray) //encode itemArray
            try data.write(to: dataFilePath!) //Writing ecnoded itemArray into dataFilePath which include Items.plist
        } catch {
            print("Error")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                    itemArray = try decoder.decode([Item].self, from: data);
            } catch {
                print("error!")
            }
            
        }
    }
    



}

