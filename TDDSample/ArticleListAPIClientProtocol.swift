//
//  ArticleListAPIClientProtocol.swift
//  TDDSample
//
//  Created by 樋川大聖 on 2021/05/18.
//

import Foundation
protocol ArticleListAPIClientProtocol {
    func fetch(completion: @escaping (([Article]?) -> Void))
}
