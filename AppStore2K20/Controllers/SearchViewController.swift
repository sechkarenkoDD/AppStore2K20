//
//  SearchViewController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let searchID = "searchID"
    private var searchResult: SearchResult?
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchID)
        showSeatchApp()
    }
    
    
    // MARK: - CollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResult?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: searchID, for: indexPath) as! SearchResultCell
        
        let searchResult = searchResult?.results[indexPath.item]
        cell.configure(with: searchResult)
        return cell
    }
    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    private func showSeatchApp() {
        Task {
            do {
                searchResult = try await NetworkManager.shered.fetchSearchAppWithContinuations()
                collectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }

}
