//
//  AppDetailCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 10.08.2022.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    private let appIconImageView = UIImageView(cornerRadius: 30)
    private let nameLabel = UILabel(text: "Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    private let categoryLabel = UILabel(text: "Category", font: .systemFont(ofSize: 18), textColor: .gray)
    private let priceButton = UIButton(title: "$4.99", titleFont: .boldSystemFont(ofSize: 14), cornerRadius: 16)
    private let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    private let versionLabel = UILabel(text: "1.0", font: .systemFont(ofSize: 16), textColor: .gray)
    private let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        appIconImageView.constrainWidth(constant: 128)
        appIconImageView.constrainHeight(constant: 128)
        
        priceButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 0.937254902, alpha: 1)
        priceButton.constrainHeight(constant: 32)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.constrainWidth(constant: 80)
        
        let headerStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            VerticalStackView(arrangedSubviews: [
                nameLabel,
                categoryLabel,
                UIView(),
                UIStackView(arrangedSubviews: [priceButton, UIView()])
            ], spacing: 5)
        ], customSpacing: 20)
        
        let overAllStackView = VerticalStackView(arrangedSubviews: [
            headerStackView,
            whatsNewLabel,
            versionLabel,
            releaseNotesLabel,
            UIView()
        ], spacing: 12)
        
        addSubview(overAllStackView)
        overAllStackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with result: AppResult?) {
        nameLabel.text = result?.trackName
        categoryLabel.text = result?.primaryGenreName
        priceButton.setTitle(result?.formattedPrice, for: .normal)
        versionLabel.text = result?.version
        releaseNotesLabel.text = result?.releaseNotes
        appIconImageView.sd_setImage(with: URL(string: result?.artworkUrl100 ?? ""))
        
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
