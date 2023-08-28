//
//  TodoList.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

struct TodoData: Codable {
    
    let number: Int
    var isComplited: Bool
//    var category: Cagegory
    var title: String
    var date: Date
    var memo: String

    static var getKeyName: String {
        return String(describing: self)
    }
    
    static var getAllList: [TodoData] {
        guard let todoData = UserDefaults.standard.value(forKey: TodoData.getKeyName) as? Data,
              let allList = try? PropertyListDecoder().decode([TodoData].self, from: todoData) else { return [] }
        return allList
    }
    
    static func add(_ allList: [TodoData]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(allList), forKey: TodoData.getKeyName)
    }
}
