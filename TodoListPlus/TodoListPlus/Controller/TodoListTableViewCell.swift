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
    
    func setupUI(_ index: Int) {
        //스토리보드에서 button 없앴는데 왜 보이는거지..
        isComplitedToggleButton.setTitle("", for: .normal)
        
        let allList = TodoData.getAllList
        titleLabel.text = allList[index].title
    }
}
