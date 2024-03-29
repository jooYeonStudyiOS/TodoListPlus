//
//  ViewController.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var listIsEmptyLabel: UILabel!
    @IBOutlet weak var todoListTableView: UITableView!
    
    var allList: [TodoData] = []
    var categories: [Int : String] = [:]
    
    let today = Date()
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableFooterView()
        addRightBarButton(title: .plus)
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allList = TodoData.getAllList
        categories = TodoData.getCategories
        
        todoListTableView.reloadData()
        
        toggleUI()
    }
    
    //지금 상황에서는 한 번만 불리니까 viewDidLoad에서 불러도 괜찮다
    func setupUI() {

        formatter.dateFormat = "yyyy년 MM년 dd일 E"
        formatter.locale = Locale(identifier: "ko_KR")
        
        selectedDateLabel.text = formatter.string(from: today)
        selectedDateLabel.adjustsFontSizeToFitWidth = true
        
        listIsEmptyLabel.textAlignment = .center
        listIsEmptyLabel.adjustsFontSizeToFitWidth = true
    }
    
    func toggleUI() {
        let isHiddenFlag = allList.isEmpty ? true : false
        listIsEmptyLabel.isHidden = !isHiddenFlag
        todoListTableView.isHidden = isHiddenFlag
    }
    
    func setupTableFooterView() {
        let randomPageButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("랜덤 페이지 이동", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            button.addTarget(self, action: #selector(didTappedRandomPageButton(_:)), for: .touchUpInside)
            return button
        }()
        
        todoListTableView.tableFooterView = randomPageButton
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
    
    //segue 이동 연습, 데이터 전달 연습
    @objc func didTappedRandomPageButton(_ sender: UIButton) {
        performSegue(withIdentifier: "PetViewController", sender: sender.titleLabel?.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PetViewController" {
            if let petViewController = segue.destination as? PetViewController,
               let buttonTitle = sender as? String {
                petViewController.receivedTitle = buttonTitle
            }
        }
    }
    
    override func didTappedRightBarButton() {
        let writeViewControllerID = String(describing: WriteViewController.self)
        let writeViewController = storyboard?.instantiateViewController(withIdentifier: writeViewControllerID) as! WriteViewController
        navigationController?.pushViewController(writeViewController, animated: false)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories.sorted(by: { $0.key < $1.key })[section].value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dateString = selectedDateLabel.text, let date = formatter.date(from: dateString) else { return 0 }
        let filteredSectionList = TodoData.getFilteredAllList(for: date, category: section)
        return filteredSectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TodoListTableViewCellID = String(describing: TodoListTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCellID, for: indexPath) as! TodoListTableViewCell
        cell.setupUI(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewControllerID = String(describing: DetailViewController.self)
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: detailViewControllerID) as! DetailViewController
        detailViewController.indexPath = indexPath
        navigationController?.pushViewController(detailViewController, animated: false)
    }
}
