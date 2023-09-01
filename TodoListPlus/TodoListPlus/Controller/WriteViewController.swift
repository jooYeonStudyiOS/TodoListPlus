//
//  WriteViewController.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

class WriteViewController: UIViewController, UISetupProtocol {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var dateTimePickerView: UIDatePicker!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    var categoryKey: Int?
    
    //true = 선택 완료
    //flase = 선택 미완료
    var pickerViewSeletedDoneSwitch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupTitleTextField()
        setupdateTimePickerView()
        setupMemoTextView()
        addRightBarButton(title: .done)
    }
    
    func setupTitleTextField() {
        setup(to: titleTextField)
    }
    
    func setupdateTimePickerView() {
        setup(to: dateTimePickerView)
        
        dateTimeLabel.isHidden = pickerViewSeletedDoneSwitch
    }
    
    func setupMemoTextView() {
        setup(to: memoTextView)
    }
    
    @IBAction func didTappedCategoryView(_ sender: Any) {
        let categories = TodoData.getCategories
        
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
        dateTimePickerView.addTarget(self, action: #selector(didSelectedDateTime), for: .editingDidEnd)
        
        pickerViewSeletedDoneSwitch = pickerViewSeletedDoneSwitch ? false : true
    }
    
    @objc func didSelectedDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        
        dateTimeLabel.text = formatter.string(from: dateTimePickerView.date)
        dateTimeLabel.isHidden = false
    }
    
    override func didTappedRightBarButton() {
        
        guard let title = titleTextField.text, !title.isEmpty,
              let category = categoryLabel.text, category != "카테고리",
              let dateString = dateTimeLabel.text, dateString != "" else {
            showRequiredAlert()
            return
        }
        
        var allList = TodoData.getAllList
        
        let newList = TodoData(number: allList.count,
                               isComplited: false,
                               category: categoryKey ?? 0,
                               title: title,
                               date: dateTimePickerView.date,
                               memo: memoTextView.text ?? "")
        
        allList.append(newList)
        
        TodoData.add(allList)
        
        navigationController?.popViewController(animated: false)
    }
}
