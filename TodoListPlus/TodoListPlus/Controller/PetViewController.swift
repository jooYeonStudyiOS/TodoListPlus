//
//  PetViewController.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/31.
//

import UIKit

class PetViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var receivedTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let title = receivedTitle {
            titleLabel.text = title
        }
        
        let isCat = Bool.random()
        let apiURLString = isCat ? "https://api.thecatapi.com/v1/images/search" : "https://api.thedogapi.com/v1/images/search"
        guard let apiURL = URL(string: apiURLString) else { return }
        
        // API 호출 및 데이터 가져오기
        URLSession.shared.dataTask(with: apiURL) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            // JSON 파싱
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                if let imageURLString = json?.first?["url"] as? String, let imageURL = URL(string: imageURLString) {
                    if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }
            } catch {
                print("JSON parsing error: \(error)")
            }
        }.resume()
    }
}


