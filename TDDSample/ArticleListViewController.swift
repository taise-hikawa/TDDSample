//
//  ArticleListViewController.swift
//  TDDSample
//
//  Created by 樋川大聖 on 2021/05/17.
//

import UIKit
import SafariServices

class ArticleListViewController: UIViewController {
    let tableView = UITableView()
    private let client: ArticleListAPIClientProtocol
    private var items: [Article]?
    
    init(client: ArticleListAPIClientProtocol = ArticleListAPIClient()) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleListCell.self, forCellReuseIdentifier: "ArticleListCell")
        client.fetch { [weak self] (articleList) in
            guard let articleList = articleList,
                0 < articleList.count else { return }
            self?.items = articleList
            self?.tableView.reloadData()
        }
        
        
    }
    
    private func setConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.rightAnchor
                .constraint(equalTo: view.rightAnchor),
            tableView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor
                .constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "ArticleListCell")
            as! ArticleListCell
        let article = items?[indexPath.row]
        cell.titleLabel.text = article?.title
        return cell
    }
}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: items?[indexPath.row].url ?? "") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
