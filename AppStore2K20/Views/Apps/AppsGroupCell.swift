//
//  CategoryCell.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    private let titleLabel = UILabel(font: .boldSystemFont(ofSize: 30))
    
    private let horizontalController = AppHorizontalController()
    
    private lazy var dividerLineView: UIView = {
        let dividerLineView = UIView()
        dividerLineView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return dividerLineView
    }()
    
    private let appCellID = "appCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "App Section"
        addSubview(titleLabel)
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
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
}


