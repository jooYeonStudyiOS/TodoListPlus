//
//  WriteViewController.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

protocol ReloadDelegate {
    func reloadTabelView()
}

class WriteViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var dateTimeSeleteButton: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    
    var list: [TodoList] = TodoList.allTodoList
    
    var delegate: ReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTappedDateTimeSeleteButton(_ sender: Any) {
    }
    
    @IBAction func didTappedDoneButton(_ sender: Any) {
        
        guard let title = titleTextField.text else { return }
        
        let newList = TodoList(listNumber: 1,
                               isComplited: false,
                               title: title,
                               date: Date(),
                               time: Date(),
                               memo: memoTextView.text ?? "")
        
        list.append(newList)
        
        TodoList.addList(list)
        
        delegate?.reloadTabelView()
        
        navigationController?.popViewController(animated: false)
    }
}
