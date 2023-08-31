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

class WriteViewController: UIViewController, UISetupProtocol {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var dateTimePickerView: UIDatePicker!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    var allList: [TodoData] = []
    var list: TodoData?
    
    var categories: [Int: String] = TodoData.getCategories
    var categoryKey: Int?
    
    //true = Write New List
    //false = Update Old List
    var writeUpdateSwitch: Bool = true
    
    //true = 선택 완료
    //flase = 선택 미완료
    var pickerViewSeletedDoneSwitch: Bool = false
    
    var delegate: ReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allList = TodoData.getAllList
        writeUpdateSwitch = list == nil ? true : false
        
        setupUI()
    }
    
    func setupUI() {
        
        dateTimeLabel.isHidden = writeUpdateSwitch
        setup(to: titleTextField)
        setup(to: dateTimePickerView)
        setup(to: memoTextView)
    }
    
    @IBAction func didTappedCategoryView(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        actionSheet.addAction(cancel)
        
        for i in categories.sorted(by: { $0.key < $1.key }) {
            let action = UIAlertAction(title: i.value, style: .default) {_ in
                self.categoryLabel.text = i.value
                self.categoryKey = i.key
            }
            
            actionSheet.addAction(action)
        }
        
        present(actionSheet, animated: true)
    }
    
    
    @IBAction func didTappedDateTimeView(_ sender: Any) {
        dateTimePickerView.isHidden = pickerViewSeletedDoneSwitch
        dateTimePickerView.addTarget(self, action: #selector(didSelectedDateTime), for: .valueChanged)
        
        if pickerViewSeletedDoneSwitch {
            pickerViewSeletedDoneSwitch = false
        } else {
            pickerViewSeletedDoneSwitch = true
        }
    }
    
    @objc func didSelectedDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        
        dateTimeLabel.text = formatter.string(from: dateTimePickerView.date)
        dateTimeLabel.isHidden = false
    }
    
    
    @IBAction func didTappedDoneButton(_ sender: Any) {
                
        guard let title = titleTextField.text, !title.isEmpty,
              let category = categoryLabel.text, category != "카테고리",
              let dateString = dateTimeLabel.text, dateString != "" else {
            
            let cancel = UIAlertAction(title: "확인", style: .destructive)
            let alert = UIAlertController(title: "필수항목입니다", message: nil, preferredStyle: .alert)
            alert.addAction(cancel)
            present(alert, animated: true)
                  
            return
        }
              
        let newList = TodoData(number: allList.count,
                               isComplited: false,
                               category: categoryKey ?? 0,
                               title: title,
                               date: dateTimePickerView.date,
                               memo: memoTextView.text ?? "")
            
        allList.append(newList)
        
        TodoData.add(allList)
        
        delegate?.reloadTabelView()
        
        navigationController?.popViewController(animated: false)
    }
}
