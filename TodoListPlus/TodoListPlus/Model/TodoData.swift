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
    var category: Int
    var title: String
    var date: Date
    var memo: String

    static var getKeyName: String {
        return String(describing: self)
    }
    
    static var getCategoryKeyName: String {
        return "listCategory"
    }
    
    static var getAllList: [TodoData] {
        guard let todoData = UserDefaults.standard.value(forKey: TodoData.getKeyName) as? Data,
              let allList = try? PropertyListDecoder().decode([TodoData].self, from: todoData) else { return [] }
        return allList
    }
    
    static var getCategories: [Int: String] {
        var result: [Int: String] = [:]
        
        if let  categories = UserDefaults.standard.dictionary(forKey: TodoData.getCategoryKeyName) {
            for i in categories {
                result[i.value as! Int] = i.key
            }
        }
        
        return result
    }
    
    static func getCategory(key: Int) -> String {
        return getCategories[key] ?? "카테고리"
    }
    
    static func add(_ allList: [TodoData]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(allList), forKey: TodoData.getKeyName)
    }
    
    static func update(_ allList: [TodoData]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(allList), forKey: TodoData.getKeyName)
    }
}
