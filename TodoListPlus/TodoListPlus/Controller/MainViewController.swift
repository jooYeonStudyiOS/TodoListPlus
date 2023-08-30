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
    var filteredSectionList: [TodoData] = []
    var categories: [Int : String] = [:]
    
    let today = Date()
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableFooterView()
        
        allList = TodoData.getAllList
        categories = TodoData.getCategories
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        let imageView = UIImageView()
        let imageURL = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!

        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: 150)
                    self.todoListTableView.tableFooterView = imageView
                }
            }
        }

        task.resume()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories.sorted(by: { $0.key < $1.key })[section].value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dateString = selectedDateLabel.text, let date = formatter.date(from: dateString) else { return 0 }
        filteredSectionList = allList.filter{ Calendar.current.isDate(date, inSameDayAs: $0.date) && $0.category == section }
        return filteredSectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TodoListTableViewCellID = String(describing: TodoListTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCellID, for: indexPath) as! TodoListTableViewCell
        cell.setupUI(indexPath)
        return cell
    }
    
    func reloadTabelView() {
        allList = TodoData.getAllList
        todoListTableView.reloadData()
    }
}
