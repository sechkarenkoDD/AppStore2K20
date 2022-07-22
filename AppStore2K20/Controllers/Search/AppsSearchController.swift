//
//  SearchViewController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class AppsSearchController: BaseListController {
    
    private let cellID = "cellID"
    private var searchResult: SearchResult?
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    
    private let enterSearchTermLable: UILabel = {
        let lable = UILabel()
        lable.text = "Please enter search term above..."
        lable.textAlignment = .center
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        return lable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellID)

        collectionView.addSubview(enterSearchTermLable)
        enterSearchTermLable.fillSuperview(padding: UIEdgeInsets(top: 200, left: 40, bottom: 0, right: 40))
    }
    
    // MARK: - UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCell
        
        let searchResult = searchResult?.results[indexPath.item]
        cell.configure(with: searchResult)
        return cell
    }
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 315)
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension AppsSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self] _ in
            Task {
                do {
                    searchResult = try await NetworkManager.shered.fetchSearchAppsContinuations(searchTerm: searchText)
                    collectionView.reloadData()
                    enterSearchTermLable.isHidden = searchText.count != 0
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResult?.results.removeAll()
        collectionView.reloadData()
        enterSearchTermLable.isHidden = false
    }
}
