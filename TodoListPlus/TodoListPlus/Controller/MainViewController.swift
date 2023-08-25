//
//  ViewController.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var listIsEmptyLabel: UILabel!
    @IBOutlet weak var todoListTableView: UITableView!
    
    var allList: [TodoData] = TodoData.getAllList

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toggleUI()
    }
    
    //지금 상황에서는 한 번만 불리니까 viewDidLoad에서 불러도 괜찮다
    func setupUI() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM년 dd일 E"
        formatter.locale = Locale(identifier: "ko_KR")
        todayDateLabel.text = formatter.string(from: today)
    }
    
    func toggleUI() {
        let isHiddenFlag = allList.isEmpty ? true : false
        listIsEmptyLabel.isHidden = !isHiddenFlag
        todoListTableView.isHidden = isHiddenFlag
    }
    
    @IBAction func didTappedGoWriteViewButton(_ sender: Any) {
        //화면 이동 맨날 이 방법만 쓰는데 이걸로만 해도 되는걸까
        let writeViewControllerID = String(describing: WriteViewController.self)
        let writeViewController = storyboard?.instantiateViewController(withIdentifier: writeViewControllerID) as! WriteViewController
        writeViewController.delegate = self
        navigationController?.pushViewController(writeViewController, animated: false)
    }
    
    @IBAction func didTappedDeleteAllListButton(_ sender: Any) {
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let deleteAction = UIAlertAction(title: "삭제", style: .default) { _ in
            UserDefaults.standard.removeObject(forKey: TodoData.getKeyName)
            self.allList = TodoData.getAllList
            self.todoListTableView.reloadData()
            self.toggleUI()
        }
        
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        alert.addAction(cancel)
        alert.addAction(deleteAction)
        
        present(alert, animated: false)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, ReloadDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allList.isEmpty ? 0 : allList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TodoListTableViewCellID = String(describing: TodoListTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCellID, for: indexPath) as! TodoListTableViewCell
        cell.setupUI(indexPath.row)
        return cell
    }
    
    func reloadTabelView() {
        allList = TodoData.getAllList
        todoListTableView.reloadData()
    }
}
