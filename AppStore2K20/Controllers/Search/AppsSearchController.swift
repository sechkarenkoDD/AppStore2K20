//
//  SearchViewController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellID"
    private var results = [AppResult]()
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
        enterSearchTermLable.fillSuperview(padding: .init(top: 200, left: 40, bottom: 0, right: 40))
    }
    
    // MARK: - UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCell
        
        let searchResult = results[indexPath.item]
        cell.configure(with: searchResult)
        return cell
    }
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 315)
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = String(results[indexPath.item].trackId)
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            
            NetworkManager.shered.fetchSearchApps(request: searchText) { [weak self] result in
                switch result {
                case .success(let appList):
                    self?.results = appList.results
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                        self?.enterSearchTermLable.isHidden = searchText.count != 0
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        results.removeAll()
        collectionView.reloadData()
        enterSearchTermLable.isHidden = false
        
    }
}
