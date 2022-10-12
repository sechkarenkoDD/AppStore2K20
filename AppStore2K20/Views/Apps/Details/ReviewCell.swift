//
//  ReviewCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 10.10.2022.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n", font: .systemFont(ofSize: 16), numberOfLines: 5)
    
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach { _ in
            let imageView = UIImageView(image: .init(systemName: "star.fill"))
            imageView.tintColor = .orange
            arrangedSubviews.append(imageView)
        }
        arrangedSubviews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    //let starImageEmpty = UIImageView(image: .init(systemName: "star"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel, authorLabel
            ], customSpacing: 8),
            starsStackView,
            bodyLabel
        ], spacing: 12)
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func configure(with result: Entry?) {
        titleLabel.text = result?.title.label
        authorLabel.text = result?.author.name.label
        bodyLabel.text = result?.content.label
        
        for (index, view) in starsStackView.arrangedSubviews.enumerated() {
            if let ratingInt = Int(result?.rating.label ?? "") {
                view.alpha = index >= ratingInt ? 0 : 1
            }
        }
    }
}
