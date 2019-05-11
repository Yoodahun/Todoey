//
//  Category.swift
//  Todoey
//
//  Created by 유다훈 on 02/12/2018.
//  Copyright © 2018 PandaYoo. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    
    //Create List that Type of Item
    let item = List<Item>();

    
}
