//
//  FeaturedAppController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class TodayController: BaseListController {
    
    private let todayID = "todayID"
    private var appList: AppList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: todayID)
        //showApp()
    }
    
    // MARK: - CollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: todayID, for: indexPath)
        
        return cell
    }
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 200)
    }
    
    private func showApp() {
        Task {
            do {
                appList = try await NetworkManager.shered.fetchAppWithContinuations()
                collectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

