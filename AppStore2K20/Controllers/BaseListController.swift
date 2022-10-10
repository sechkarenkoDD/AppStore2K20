//
//  BaseListController.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 11.07.2022.
//

import Foundation
import UIKit


class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
