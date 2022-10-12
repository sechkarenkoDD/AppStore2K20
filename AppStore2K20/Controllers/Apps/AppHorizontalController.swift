//
//  AppHorizontalController.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 11.07.2022.
//

import UIKit

class AppHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var appGroup: AppGroup?
    var didSelectHandler: ((FeedResult) -> ())?
    
    private let cellID = "cellID"
    private let topBottomPadding: CGFloat = 12
    private let lineSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
    }
    
    // MARK: - UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppRowCell
        let feedResult = appGroup?.feed.results[indexPath.item]
        cell.configure(with: feedResult)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item] {
            didSelectHandler?(app)
        }
    }
    
}


