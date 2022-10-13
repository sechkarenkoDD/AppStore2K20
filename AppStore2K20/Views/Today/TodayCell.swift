//
//  TodayCell.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 13.10.2022.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: .init(imageLiteralResourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 250, height: 250))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
