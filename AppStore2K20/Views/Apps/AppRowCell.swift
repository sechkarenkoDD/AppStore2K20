//
//  AppRowCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 12.07.2022.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    private let imageAppView = UIImageView(cornerRadius: 15)
    private let nameLable = UILabel(text: "Name", font: .systemFont(ofSize: 20))
    private let companyLable = UILabel(text: "Company", font: .systemFont(ofSize: 14), textColor: .gray)
    private let getButton = UIButton(title: "Get", titleFont: .boldSystemFont(ofSize: 14), cornerRadius: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageAppView.constrainWidth(constant: 64)
        imageAppView.constrainHeight(constant: 64)
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: getButton.layer.cornerRadius * 2)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageAppView,
            VerticalStackView(arrangedSubviews: [nameLable, companyLable], spacing: 4),
            getButton
            ], customSpacing: 16)
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with result: FeedResult?) {
        nameLable.text = result?.name
        companyLable.text = result?.artistName
        imageAppView.sd_setImage(with: URL(string: result?.artworkUrl100 ?? ""))
    }
    
}
