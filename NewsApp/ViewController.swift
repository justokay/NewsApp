//
//  ViewController.swift
//  NewsApp
//
//  Created by Yuri Misyac on 06.02.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var progress: UIActivityIndicatorView!
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        doRequest()
    }
    
    func doRequest() {
        progress.isHidden = false
        self.tableView.isHidden = true
        
        Requester.getNews().responseDecodable { (data: DataResponse<News, AFError>) in
            switch data.result {
            case .success(let news):
                self.updateData(news: news)
            case .failure(let error):
                self.showError(error: error)
            }
            self.progress.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    func showError(error: AFError) {
        debugPrint(error)
    }
        
    func updateData(news: News) {
        debugPrint(news)
        self.articles = news.articles
        self.tableView.reloadData()
    }
}

class ArticleCell: UITableViewCell {
    @IBOutlet var title: UILabel!
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell", for: indexPath) as! ArticleCell
        
        cell.title.text = articles[indexPath.row].title
        
        return cell
    }
    
}

