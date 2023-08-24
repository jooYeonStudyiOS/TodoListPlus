//
//  TodoListTableViewCell.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/24.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isComplitedToggleButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setupUI() {
        isComplitedToggleButton.setTitle("", for: .normal)
    }
    
}
