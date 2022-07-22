//
//  AppsHeaderCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 14.07.2022.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    private let companyLabel = UILabel(font: .boldSystemFont(ofSize: 12))
    private let titleLabel = UILabel(font: .systemFont(ofSize: 24))
    
    private let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        companyLabel.text = "Facebook"
        companyLabel.textColor = .blue
        titleLabel.text = "Keeping up with friends is faster then ever"
        titleLabel.numberOfLines = 2
        
        let stackView = VerticalStackView(
            arrangedSubviews: [companyLabel, titleLabel, imageView],
            spacing: 12
        )
        addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with result: SocialApp?) {
        companyLabel.text = result?.name
        titleLabel.text = result?.tagline
        imageView.sd_setImage(with: URL(string: result?.imageUrl ?? ""))
    }
}
