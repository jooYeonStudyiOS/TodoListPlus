//
//  TodoList.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

struct TodoList: Codable {
    
    let listNumber: Int
    var isComplited: Bool
//    var category: Cagegory
    var title: String
    var date: Date
    var time: Date
    var memo: String?

    static var name: String {
        return String(describing: self)
    }
    
    static var allTodoList: [TodoList]? {
        guard let listData = UserDefaults.standard.value(forKey: TodoList.name) as? Data,
              let allTodoList = try? PropertyListDecoder().decode([TodoList].self, from: listData) else { return nil }
        return allTodoList
    }
    
    func addList(_ todoList: [TodoList]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(todoList), forKey: TodoList.name)
    }
}
