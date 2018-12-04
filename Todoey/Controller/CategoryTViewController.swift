//
//  CategoryTViewController.swift
//  Todoey
//
//  Created by 유다훈 on 25/11/2018.
//  Copyright © 2018 PandaYoo. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryTViewController: UITableViewController {
    
    //Init realm instance
    let realm = try! Realm();
    
    //We init Datamodel emptyArray
    var categoryArray: Results<Category>?
    
   
    
    
    override func viewDidLoad() {
        loadCategories();
        super.viewDidLoad()

    }

 
    //MARK: - Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //textField
        var textField = UITextField();
        
        //alert window
        let alert = UIAlertController (title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        //alert add button
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            
            //add category
//            self.categoryArray.append(newCategory)
            
            //save category in Core Data
            self.saveCategories(newCategory);
            
            //reload
            self.tableView.reloadData();
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            
            //Setting textField's placeholder
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    //MARK: - tableView datasource methods
    //how many rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //defalut value
        //if categoryArray is null ? return 1
        return categoryArray?.count ?? 1
    }
    
    //reuse cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Area categoryCell in CategoryTableViewController
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
       
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    }
    
    //MARK: - tableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    //When we select one of the cells we probably want to trigger
    //Using the Segue to go to item
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    //Is going to be triggered just before we perform that Segue.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //new constant that is going to store a reference to the destination
        //Down cast
        let destinationViewController = segue.destination as! TodoListViewController
        
        //selected table row in tableView is not nil
        if let indexPath = tableView.indexPathForSelectedRow {
            //Setting the category that selected row number
            destinationViewController.selectedCategory = self.categoryArray?[indexPath.row]
        
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    
    //Save item CoreData
    func saveCategories(_ category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch  {
            print("Error")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categoryArray = realm.objects(Category.self)

//        //Reload data
        tableView.reloadData();
    }
    
    
    
    
    
    
}
