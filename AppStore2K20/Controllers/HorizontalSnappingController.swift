//
//  HorizontalSnappingController.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 05.10.2022.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
   
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
