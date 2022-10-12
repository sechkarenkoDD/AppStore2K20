//
//  TopChartsController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "appsID"
    private let hederID = "hederID"
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .systemGray
        activity.startAnimating()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    private var appsGroup = [AppGroup]()
    private var bannersApp = [BannerApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: hederID)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fechData()
    }
    
    // MARK: - UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appsGroup.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsGroupCell
        let appGroup = appsGroup[indexPath.item]
        cell.configure(with: appGroup)
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            let appDetailController = AppDetailController(appId: feedResult.id)
            self?.navigationController?.pushViewController(appDetailController, animated: true)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: hederID, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalController.bannersApps = bannersApp
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return .init(top: 0, left: 0, bottom: 16, right: 0)
        }
    
    private func fechData() {
        
        var topPaid: AppGroup?
        var topFree: AppGroup?
        
        // help you sync your data fetches together
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkManager.shered.fetchTopPaidApps { result in
            switch result {
            case .success(let appList):
                dispatchGroup.leave()
                topPaid = appList
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        NetworkManager.shered.fetchTopFreeApps { result in
            switch result {
            case .success(let appList):
                dispatchGroup.leave()
                topFree = appList
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        NetworkManager.shered.fetchBannerApps { [weak self] result in
            switch result {
            case .success(let appList):
                dispatchGroup.leave()
                self?.bannersApp = appList
            case .failure(let error):
                print(error)
            }
        }
        
        // completion
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            
            if let group = topPaid {
                self.appsGroup.append(group)
            }
            if let group = topFree {
                self.appsGroup.append(group)
            }
            self.collectionView.reloadData()
        }
    }
}


