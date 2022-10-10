//
//  Extensions.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 12.07.2022.
//

import UIKit

extension UILabel {    
    convenience init(text: String, font: UIFont, textColor: UIColor = .label, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 0.2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String, titleFont: UIFont, cornerRadius: CGFloat) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = titleFont
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.layer.cornerRadius = cornerRadius
    }
}
