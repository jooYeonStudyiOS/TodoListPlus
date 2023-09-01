//
//  UIActionHandler.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/31.
//

import UIKit

enum RightBarButtonTitle: String {
    case plus = "추가"
    case done = "완료"
    case update = "수정"
}

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
    
    func addRightBarButton(title: RightBarButtonTitle) {
        let button = UIBarButtonItem(title: title.rawValue, style: .plain, target: self, action: #selector(didTappedRightBarButton))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func didTappedRightBarButton() {  }
}


