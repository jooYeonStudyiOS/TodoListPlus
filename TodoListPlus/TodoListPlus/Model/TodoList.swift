//
//  TodoList.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

struct TodoList {
    
    //카테고리 추가하고 싶을 때는 어떻게 해야할까?
    //
    enum Cagegory {
        case study
        case exercise
        case appointment
    }
    
    let listNumber: Int
    var isComplited: Bool
    var category: Cagegory
    var title: String
    var date: Date
    var time: Date
    var memo: String
}
