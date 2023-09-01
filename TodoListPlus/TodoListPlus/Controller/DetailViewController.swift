//
//  DetailViewController.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

class DetailViewController: UIViewController, UISetupProtocol {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var dateTimePickerView: UIDatePicker!
    
    @IBOutlet weak var memoTextView: UITextView!

    //true = 선택 완료
    //flase = 선택 미완료
    var pickerViewSeletedDoneSwitch: Bool = false
    
    var indexPath: IndexPath?
    var allList: [TodoData]?
    var list: TodoData?
    var categoryKey: Int?
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let section = indexPath?.section, let row = indexPath?.row else { return }
        
        allList = TodoData.getAllList
        list = allList?.filter({$0.category == section}).sorted(by: { $0.date < $1.date })[row]
        
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        
        setupUI()
    }
    
    func setupUI() {
        setupCategoryLabel()
        setupTitleTextField()
        setupdateTimePickerView()
        setupMemoTextView()
        addRightBarButton(title: .update)
    }
    
    func setupCategoryLabel() {
        guard let categoryKey = indexPath?.section else { return }
        categoryLabel.text = TodoData.getCategory(key: categoryKey)
    }
    func setupTitleTextField() {
        setup(to: titleTextField)
        
        titleTextField.text = list?.title
    }
    
    func setupdateTimePickerView() {
        setup(to: dateTimePickerView)
        
        dateTimeLabel.isHidden = false
        
        if let date = list?.date {
            dateTimeLabel.text = formatter.string(from: date)
        }
    }
    
    func setupMemoTextView() {
        setup(to: memoTextView)
        
        memoTextView.text = list?.memo
    }
    
    @IBAction func didTappedCategoryView(_ sender: Any) {
        categoryKey = showCategoryActionSheet(categoryLabel: categoryLabel)
    }
    
    @IBAction func didTappedDateTimeView(_ sender: Any) {
        dateTimePickerView.isHidden = pickerViewSeletedDoneSwitch
        dateTimePickerView.addTarget(self, action: #selector(didSelectedDateTime), for: .valueChanged)
        dateTimePickerView.addTarget(self, action: #selector(didSelectedDateTime), for: .editingDidEnd)
        
        pickerViewSeletedDoneSwitch = pickerViewSeletedDoneSwitch ? false : true
    }
    
    @objc func didSelectedDateTime() {
        dateTimeLabel.text = formatter.string(from: dateTimePickerView.date)
        dateTimeLabel.isHidden = false
    }
    
    override func didTappedRightBarButton() {
        print("ASdf")
    }
}
