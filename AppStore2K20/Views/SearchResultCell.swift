//
//  SearchResultCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 24.06.2022.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.widthAnchor.constraint(equalToConstant: 64).isActive = true
        image.heightAnchor.constraint(equalToConstant: 64).isActive = true
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let lable = UILabel()
        return lable
    }()
    
    let categoryLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .gray
        return lable
    }()
    
    let ratingsLabel: UILabel = {
        let lable = UILabel()
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
        
        overAllStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with resultApp: ResultApp?) {
        nameLabel.text = resultApp?.trackName
        categoryLabel.text = resultApp?.primaryGenreName
        ratingsLabel.text = "Rating: \(resultApp?.averageUserRating ?? 0)"
    }
    
    private func createScreenshotsImageView(number: Int) -> [UIImageView] {
        
        var imageViews = [UIImageView]()
        
        for _ in 1...number {
            let imageView = UIImageView()
            imageView.backgroundColor = .blue
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 0.5
            imageViews.append(imageView)
        }
        
        return imageViews
    }
}
