//
//  WriteViewController.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

class WriteViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var dateTimeSeleteButton: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTappedDateTimeSeleteButton(_ sender: Any) {
    }
    
    @IBAction func didTappedDoneButton(_ sender: Any) {
    }
}
