//
//  CategoryCell.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    let horizontalController = AppHorizontalController()
    
    private let titleLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 25))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 12, left: 16, bottom: 0, right: 16)
        )
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(
            top: titleLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with result: AppGroup?) {
        titleLabel.text = result?.feed.title
        horizontalController.appGroup = result
    }
}


