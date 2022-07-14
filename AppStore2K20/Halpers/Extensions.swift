//
//  Extensions.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 12.07.2022.
//

import UIKit

extension UILabel {    
    convenience init(font: UIFont, textColor: UIColor = .label) {
        self.init(frame: .zero)
        self.font = font
        self.textColor = textColor
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
