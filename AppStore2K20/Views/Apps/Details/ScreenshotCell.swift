//
//  ScreenshotCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 10.10.2022.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 12)
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with screenshotUrl: String?) {
        imageView.sd_setImage(with: URL(string: screenshotUrl ?? ""))
    }
}
