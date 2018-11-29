//
//  CategoryTViewController.swift
//  Todoey
//
//  Created by 유다훈 on 25/11/2018.
//  Copyright © 2018 PandaYoo. All rights reserved.
//

import UIKit
import CoreData

class CategoryTViewController: UITableViewController {

    //We created Datamodel emptyArray
    var categoryArray = [Category]()
    
    //Singleton instance. communicate persistent container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
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
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            //add category
            self.categoryArray.append(newCategory)
            
            //save category in Core Data
            self.saveCategories();
            
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
        
        return categoryArray.count
    }
    
    //reuse cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Area categoryCell in CategoryTableViewController
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
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
            destinationViewController.selectedCategory = self.categoryArray[indexPath.row]
        
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    
    //Save item CoreData
    func saveCategories() {
        do {
            try context.save()
        } catch  {
            print("Error")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray =  try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        
        //Reload data
        tableView.reloadData();
    }
    
    
    
    
    
    
}
