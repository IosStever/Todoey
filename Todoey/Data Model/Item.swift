//
//  Item.swift
//  Todoey
//
//  Created by Steven Robertson on 12/30/17.
//  Copyright © 2017 Steven Robertson. All rights reserved.
//

import Foundation


class Item: Codable {
    var title: String = ""
    var done: Bool = false
 
//Encodable means it can be encoded into a plist or a JSON
// init(title: String, completed: Bool) {
// self.title = title
// self.completed = completed
// }
}

