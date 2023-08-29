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
    
    var allList: [TodoData] = []
    
    func setupUI(_ index: Int) {
        
        allList = TodoData.getAllList
        
        setupIsComplitedToggleButton(index)
        setupTitleLabel(index)
        setupTimeLabel(index)
    }
    
    func setupIsComplitedToggleButton(_ index: Int) {
        
        let isComplited = allList[index].isComplited
        let checkedImage = UIImage(systemName: "checkmark.square")
        let uncheckedImage = UIImage(systemName: "square")
        let image = isComplited ? checkedImage : uncheckedImage
        
        //스토리보드에서 button 없앴는데 왜 보이는거지..
        isComplitedToggleButton.setTitle("", for: .normal)
        isComplitedToggleButton.setImage(image, for: .normal)
    }
    
    func setupTitleLabel(_ index: Int) {
        titleLabel.text = allList[index].title
        titleLabel.numberOfLines = 1
    }
    
    func setupTimeLabel(_ index: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: allList[index].date)
    }
}
