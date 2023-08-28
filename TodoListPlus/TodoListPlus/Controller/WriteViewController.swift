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
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var dateTimePickerView: UIDatePicker!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    var allList: [TodoData] = TodoData.getAllList
    var list: TodoData?
    
    //true = Write New List
    //false = Update Old List
    var writeUpdateSwitch: Bool = true
    
    var delegate: ReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeUpdateSwitch = list == nil ? true : false
        
        setupUI()
    }
    

    func setupUI() {
        
        titleTextField.becomeFirstResponder()
        titleTextField.placeholder = "필수항목 입니다"
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor =  UIColor.black.cgColor
        
        dateTimeLabel.isHidden = writeUpdateSwitch
        dateTimePickerView.isHidden = writeUpdateSwitch
    }
    
    @IBAction func didTappedDoneButton(_ sender: Any) {
        
        guard let title = titleTextField.text else { return }
        
        let newList = TodoData(number: 1,
                               isComplited: false,
                               title: title,
                               date: Date(),
                               time: Date(),
                               memo: memoTextView.text ?? "")
        
        allList.append(newList)
        
        TodoData.add(allList)
        
        delegate?.reloadTabelView()
        
        navigationController?.popViewController(animated: false)
    }
}
