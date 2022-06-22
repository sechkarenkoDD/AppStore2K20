//
//  FeaturedAppController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class TodayViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let featureCellID = "featureCellID"
    private var appList: AppList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation(withTitle: "Today", withLargeTitles: true)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: featureCellID)
        showApp()
    }
    
    // MARK: - CollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appList?.categories.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: featureCellID, for: indexPath) as! CategoryCell
        
        return cell
    }
    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func setupNavigation(withTitle title: String, withLargeTitles: Bool) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = withLargeTitles
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

