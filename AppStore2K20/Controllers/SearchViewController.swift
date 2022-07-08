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
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    
    private let enterSearchTermLable: UILabel = {
        let lable = UILabel()
        lable.text = "Please enter search term above..."
        lable.textAlignment = .center
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        return lable
    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchID)

        collectionView.addSubview(enterSearchTermLable)
        enterSearchTermLable.fillSuperview(padding: UIEdgeInsets(top: 200, left: 40, bottom: 0, right: 40))
    }
    
    // MARK: - CollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: searchID, for: indexPath) as! SearchResultCell
        
        let searchResult = searchResult?.results[indexPath.item]
        cell.configure(with: searchResult)
        return cell
    }
    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 320)
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [self] _ in
            Task {
                do {
                    searchResult = try await NetworkManager.shered.fetchSearchAppWithContinuations(searchTerm: searchText)
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
