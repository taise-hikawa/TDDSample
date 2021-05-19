//
//  ArticleListAPIClient.swift
//  TDDSample
//
//  Created by 樋川大聖 on 2021/05/18.
//

import Foundation

class ArticleListAPIClient: ArticleListAPIClientProtocol {
    func fetch(completion: @escaping (([Article]?) -> Void)) {
        guard let url = URL(string: "https://qiita.com/api/v2/items") else {
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let error = error {
                print("クライアントエラー: \(error.localizedDescription) \n")
                return
            }
            guard let data = data else { return }
            let articleList = try? JSONDecoder()
                .decode([Article].self, from: data)
            DispatchQueue.main.async {
                completion(articleList)
            }
        }.resume()
    }
}
