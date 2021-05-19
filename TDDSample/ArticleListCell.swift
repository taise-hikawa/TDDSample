//
//  ArticleListCell.swift
//  TDDSample
//
//  Created by 樋川大聖 on 2021/05/18.
//

import UIKit

class ArticleListCell: UITableViewCell {
    let titleLabel = UILabel()
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor, constant: 8.0),
            titleLabel.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 8.0)
        ])
    }
    func configure(title: String) {
        titleLabel.text = title
    }
}
