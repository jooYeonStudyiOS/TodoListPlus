//
//  UIActionHandler.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/31.
//

import UIKit

extension UIViewController {
    func showCategoryActionSheet(categoryLabel: UILabel) -> Int {
        
        let categories = TodoData.getCategories
        var categoryKey: Int = 0
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        actionSheet.addAction(cancel)
        
        for i in categories.sorted(by: { $0.key < $1.key }) {
            let action = UIAlertAction(title: i.value, style: .default) {_ in
                categoryLabel.text = i.value
                categoryKey = i.key
            }
            
            actionSheet.addAction(action)
        }

        present(actionSheet, animated: true)

        return categoryKey
    }
    
    func showRequiredAlert() {
        let cancel = UIAlertAction(title: "확인", style: .destructive)
        let alert = UIAlertController(title: "필수항목입니다", message: nil, preferredStyle: .alert)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}


