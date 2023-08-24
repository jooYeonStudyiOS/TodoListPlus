//
//  ViewController.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var todoListTableView: UITableView!
    
    var list: [TodoList] = TodoList.allTodoList

    override func viewDidLoad() {
        super.viewDidLoad()
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
    }
    
    //액션 이름 좀 바꿔야겠다
    @IBAction func didTappedGoWriteView(_ sender: Any) {
        //화면 이동 맨날 이 방법만 쓰는데 이걸로만 해도 되는걸까
        let vcName = String(describing: WriteViewController.self)
        let vc = storyboard?.instantiateViewController(withIdentifier: vcName) as! WriteViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, ReloadDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.isEmpty ? 0 : list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as! TodoListTableViewCell
        cell.setupUI(indexPath.row)
        return cell
    }
    
    func reloadTabelView() {
        todoListTableView.reloadData()
    }
}
