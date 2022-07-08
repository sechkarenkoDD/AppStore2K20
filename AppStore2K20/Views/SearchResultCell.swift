//
//  SearchResultCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 24.06.2022.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
        let image = UIImageView()
        image.widthAnchor.constraint(equalToConstant: 64).isActive = true
        image.heightAnchor.constraint(equalToConstant: 64).isActive = true
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        return lable
    }()
    
    let categoryLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textColor = .gray
        return lable
    }()
    
    let ratingsLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textColor = .gray
        return lable
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screennshotsImage = createScreenshotsImageView(number: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        overAllStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with resultApp: ResultApp?) {
        nameLabel.text = resultApp?.trackName
        categoryLabel.text = resultApp?.primaryGenreName
        ratingsLabel.text = "Rating: \(resultApp?.averageUserRating ?? 0)"
        
        let urlIcon = URL(string: resultApp?.artworkUrl100 ?? "")
        appIconImageView.sd_setImage(with: urlIcon)
        
        fechURLScreenshots(with: resultApp, forImages: screennshotsImage)
    }
    
    private func createScreenshotsImageView(number: Int) -> [UIImageView] {
        
        var imageViews = [UIImageView]()
        
        for _ in 1...number {
            let imageView = UIImageView()
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 0.5
            imageViews.append(imageView)
        }
        
        return imageViews
    }
    
    private func fechURLScreenshots(with resultApp: ResultApp?, forImages screennshotsImage: [UIImageView]) {
        
        let urlLinks = resultApp?.screenshotUrls ?? [""]
        
        for (urlLink, screennshotImage) in zip(urlLinks, screennshotsImage) {
            let urlScreenshot = URL(string: urlLink)
            screennshotImage.sd_setImage(with: urlScreenshot)
        }
        
    }
}
