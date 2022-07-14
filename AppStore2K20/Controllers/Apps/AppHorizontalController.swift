//
//  AppHorizontalController.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 11.07.2022.
//

import UIKit

class AppHorizontalController: BaseListController {
    
    private let cellID = "cellID"
    
    private let topBottomPadding: CGFloat = 12
    private let lineSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    
    // MARK: - UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppRowCell
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - (2 * topBottomPadding) - (2 * lineSpacing)) / 3
        return CGSize(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
    }
    
}


