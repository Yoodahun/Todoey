//
//  ViewController.swift
//  Todoey
//
//  Created by 유다훈 on 2018. 9. 18..
//  Copyright © 2018년 PandaYoo. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Make", "Buy Eggos", "Destroy Demogorgon"];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - TablewView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row];
        return cell
    }

    //MARK - TableView Delegate Methods - 클릭할때마다 실행되는 메소드??
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //어떠한 셀이 선택되었을때 그 셀이 무엇인지 알려주는 메소드.
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    



}

