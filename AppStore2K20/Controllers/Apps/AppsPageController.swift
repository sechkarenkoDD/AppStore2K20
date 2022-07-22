//
//  TopChartsController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class AppsPageController: BaseListController {
    
    private let cellID = "appsID"
    private let hederID = "hederID"
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .systemGray
        activity.startAnimating()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    private var appsGroup: [AppGroup]?
    private var socialApp: [SocialApp]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
        
        // For section header
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: hederID)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fechData()
    }
    
    // MARK: - UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appsGroup?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsGroupCell
        let appGroup = appsGroup?[indexPath.item]
        cell.configure(with: appGroup)
        return cell
    }
    
    // For section header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let heder = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: hederID, for: indexPath) as! AppsPageHeader
        heder.appHeaderHorizontalController.socialApps = socialApp
        heder.appHeaderHorizontalController.collectionView.reloadData()
        return heder
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 300)
    }
    
    // For section header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 300)
    }
    
    
    private func fechData(){
        Task {
            do {
                let result = try await withThrowingTaskGroup(of: AppGroup.self) { group -> [AppGroup] in
                    
                    for url in [NetworkUrlLinks.topPaid, NetworkUrlLinks.topFree] {
                        group.addTask { try await NetworkManager.shered.fetchTopAppsContinuations(url: url.rawValue)}
                    }
                    
                    var appsGroup: [AppGroup] = []
                    
                    for try await value in group {
                        appsGroup.append(value)
                    }
                    return appsGroup
                }
                
                appsGroup = result
                collectionView.reloadData()
                activityIndicatorView.stopAnimating()
            } catch {
                print(error)
            }
        }
        
        Task {
            do {
                socialApp = try await NetworkManager.shered.fetchSocilaAppsContinuations(url: NetworkUrlLinks.socialApp.rawValue)
                collectionView.reloadData()
            }
        }
    }
}

