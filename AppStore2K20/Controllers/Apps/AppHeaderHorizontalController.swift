//
//  AppHeaderHorizontalController.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 14.07.2022.
//

import UIKit

class AppHeaderHorizontalController: BaseListController {
    
    private let cellID = "cellID"
    
    var socialApps: [SocialApp]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        socialApps?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsHeaderCell
        let socialApp = socialApps?[indexPath.item]
        cell.configure(with: socialApp)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
