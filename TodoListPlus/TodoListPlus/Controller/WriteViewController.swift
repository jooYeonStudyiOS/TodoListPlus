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
    
    var categories: [String: Int] = TodoData.getCategories
    
    //true = Write New List
    //false = Update Old List
    var writeUpdateSwitch: Bool = true
    
    //true = 선택 완료
    //flase = 선택 미완료
    var pickerViewSeletedDoneSwitch: Bool = false
    
    var delegate: ReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeUpdateSwitch = list == nil ? true : false
        
        setupUI()
    }
    
    func setupUI() {
        setupTitleTextField()
        
        dateTimeLabel.isHidden = writeUpdateSwitch
        dateTimePickerView.isHidden = writeUpdateSwitch
    }
    
    func setupTitleTextField() {
        titleTextField.becomeFirstResponder()
        titleTextField.placeholder = "필수항목 입니다"
        
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor =  UIColor.black.cgColor
        titleTextField.layer.cornerRadius = 5
    }
    
    @IBAction func didTappedCategoryView(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        actionSheet.addAction(cancel)
        
        for i in categories.keys.sorted(by: { $0 < $1 }) {
            let action = UIAlertAction(title: i, style: .default) {_ in
                self.categoryLabel.text = i
            }
            actionSheet.addAction(action)
        }
        
        present(actionSheet, animated: true)
    }
    
    
    @IBAction func didTappedDateTimeView(_ sender: Any) {
        dateTimePickerView.isHidden = pickerViewSeletedDoneSwitch

        if pickerViewSeletedDoneSwitch {
            didSelectedDateTime()
            pickerViewSeletedDoneSwitch = false
        } else {
            pickerViewSeletedDoneSwitch = true
        }
    }
    
    func didSelectedDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        
        dateTimeLabel.text = formatter.string(from: dateTimePickerView.date)
        dateTimeLabel.isHidden = false
    }
    
    
    @IBAction func didTappedDoneButton(_ sender: Any) {
        
        guard let title = titleTextField.text else { return }
        guard let categoryKey = categoryLabel.text else { return }
        
        let newList = TodoData(number: allList.count - 1,
                               isComplited: false,
                               category: categories[categoryKey]!,
                               title: title,
                               date: dateTimePickerView.date,
                               memo: memoTextView.text ?? "")
            
        allList.append(newList)
        
        TodoData.add(allList)
        
        delegate?.reloadTabelView()
        
        navigationController?.popViewController(animated: false)
    }
}
