//
//  AppDetailController.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 10.08.2022.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appId: String?
    var app: AppResult?
    var reviews: Reviews?
    
    let detailCellID = "detailCellID"
    let previewCellID = "previewCellID"
    let reviewCellID = "reviewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellID)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellID)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellID)
        
        fechData()
    }
    
    // MARK: - UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellID, for: indexPath) as! AppDetailCell
            cell.configure(with: app)
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellID, for: indexPath) as! PreviewCell
            cell.configure(with: app)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellID, for: indexPath) as! ReviewRowCell
            cell.configure(with: reviews)
            return cell
        }
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        
        if indexPath.item == 0 {
            // calculate the necessary size for our cell somehow
            let dummyCell = AppDetailCell(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 100))
            dummyCell.configure(with: app)
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize.init(width: view.frame.width, height: 100))
            
            return CGSize(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 250
        }
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func fechData() {
        
        NetworkManager.shered.fetchDetailApps(appID: appId ?? "") { [weak self] result in
            switch result {
            case .success(let app):
                self?.app = app.results.first
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        NetworkManager.shered.fetchReviewApps(appID: appId ?? "") { [weak self] result in
            switch result {
            case .success(let review):
                self?.reviews = review
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
