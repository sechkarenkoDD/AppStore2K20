//
//  SearchResultCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 24.06.2022.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    private let appIconImageView = UIImageView(cornerRadius: 15)
    private let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 16))
    private let categoryLabel = UILabel(text: "Category", font: .systemFont(ofSize: 14), textColor: .gray)
    private let ratingsLabel = UILabel(text: "Rating", font: .systemFont(ofSize: 14), textColor: .gray)
    private let getButton = UIButton(title: "Get", titleFont: .boldSystemFont(ofSize: 14), cornerRadius: 16)
    
    lazy var screennshotsImage = screenshotsImageView(number: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        appIconImageView.constrainWidth(constant: 64)
        appIconImageView.constrainHeight(constant: 64)
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: getButton.layer.cornerRadius * 2)
        
        let labelStackView = VerticalStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingsLabel
        ])
        
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView, labelStackView, getButton
        ])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screennshotStackView = UIStackView(arrangedSubviews: screennshotsImage)
        screennshotStackView.spacing = 12
        screennshotStackView.distribution = .fillEqually
        
        let overAllStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screennshotStackView],
                                                 spacing: 16)
        
        addSubview(overAllStackView)
        
        overAllStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with result: AppResult?) {
        nameLabel.text = result?.trackName
        categoryLabel.text = result?.primaryGenreName
        ratingsLabel.text = "Rating: \(result?.averageUserRating ?? 0)"
        appIconImageView.sd_setImage(with: URL(string: result?.artworkUrl100 ?? ""))
        
        fechURLScreenshots(with: result, forImages: screennshotsImage)
    }
    
    private func screenshotsImageView(number: Int) -> [UIImageView] {
        
        var imageViews = [UIImageView]()
        
        for _ in 1...number {
            let image = UIImageView(cornerRadius: 5)
            imageViews.append(image)
        }
        
        return imageViews
    }
    
    private func fechURLScreenshots(with resultApp: AppResult?, forImages screennshotsImage: [UIImageView]) {
        
        let urlLinks = resultApp?.screenshotUrls ?? [""]
    
        for (urlLink, screennshotImage) in zip(urlLinks, screennshotsImage) {
            screennshotImage.sd_setImage(with: URL(string: urlLink))
        }
    }
}
