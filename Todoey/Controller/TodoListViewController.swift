//
//  ViewController.swift
//  Todoey
//
//  Created by 유다훈 on 2018. 9. 18..
//  Copyright © 2018년 PandaYoo. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {
    
    let realm = try! Realm();
    var todoItems : Results<Item>?
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //  create Items.plist
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //Singleton instance. Connecting Database
    
    //This is nil before Category selected
    var selectedCategory : Category? {
        didSet {
            loadItems();
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
        
        //저장된 아이템들을 꺼내서 다시 불러오는 것.
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
   
        
    }
    
    //MARK - TablewView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //셀을 재활용하고 있기때문에 체크표시와 같은 것들이 체크하지도않았는데 나오기도할 수도 있음.
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        
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

        //Update and Delete with Realm
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
//                    realm.delete(item);
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
            
        }
        
        
        //Delete
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        //Update
//        itemArray[indexPath.row].setValue("Completed", forKey: "title")
        //Checking toggle
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        //when selectedItem is done? change to not done
        //Or selectedItem is not done? change to done

//        saveItems()
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

            if let currentCategory = self.selectedCategory {
               
                do {
                    try self.realm.write {
                        /* Create Item */
                        let newItem = Item();
                        newItem.title = textField.text!
                        //            newItem.done = false; //Required Attribute.
                        newItem.dateCreated = Date();
                        currentCategory.item.append(newItem) //variable in Category
                    }
                    } catch {
                    print ("Error saving new Items \(error)")
                }
                
              }
            
          
            
          
//            self.itemArray.append(newItem)
//            self.saveItems(); //Create in CRUD
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
//
//    func saveItems(_ todoItem : Item) {
//        //Save updated Item to UserDefaults
//        do {
//
//           try context.save() //Commit newItem which is Coredata
//        } catch {
//            print("Error")
//        }
//    }
    
    func loadItems() {
        todoItems = selectedCategory?.item.sorted(byKeyPath: "title", ascending: true)
        
//        There is no NSPredicate? nil
        
//        categoryName Only
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
////        sub predicate Array predicate Combination.
//
//        if let addtionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
//        } else {
//            request.predicate = categoryPredicate;
//        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//        request.predicate = compoundPredicate;
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }


        tableView.reloadData()
    }
    
}


//MARK: - Search bar Methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData();
        
        
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()

        
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        //sorting
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//       loadItems(with: request, predicate: predicate)
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
        
    }
    //delegate Method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder() //Cursor no activate
            }

        }
    }

