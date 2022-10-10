//
//  AppsHeaderCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 14.07.2022.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    private let companyLabel = UILabel(text: "Company", font: .boldSystemFont(ofSize: 16))
    private let titleLabel = UILabel(text: "Title", font: .systemFont(ofSize: 24))
    private let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        companyLabel.textColor = .blue
        titleLabel.numberOfLines = 2
        
        let stackView = VerticalStackView(
            arrangedSubviews: [companyLabel, titleLabel, imageView],
            spacing: 12
        )
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with result: BannerApp?) {
        companyLabel.text = result?.name
        titleLabel.text = result?.tagline
        imageView.sd_setImage(with: URL(string: result?.imageUrl ?? ""))
    }
}
