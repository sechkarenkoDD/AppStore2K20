//
//  CategoryCell.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    private lazy var nameLableCategory: UILabel = {
        let nameLableCategory = UILabel()
        nameLableCategory.text = "Best New App"
        nameLableCategory.font = UIFont.systemFont(ofSize: 16)
        return nameLableCategory
    }()
    
    private lazy var appsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let appsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        appsCollectionView.showsHorizontalScrollIndicator = false
        
        //Protocoll
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        
        //Register
        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: appCellID)
        return appsCollectionView
    }()
    
    private lazy var dividerLineView: UIView = {
        let dividerLineView = UIView()
        dividerLineView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return dividerLineView
    }()
    
    private let appCellID = "appCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview(appsCollectionView, nameLableCategory, dividerLineView)
        setupConstraintsAppCollectionView()
        setupConstraintsNameLableCategory()
        setupConstraintsDividerLineView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    private func setupConstraintsAppCollectionView() {
        appsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appsCollectionView.topAnchor.constraint(equalTo: nameLableCategory.topAnchor, constant: 15),
            appsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            appsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            appsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupConstraintsNameLableCategory() {
        nameLableCategory.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLableCategory.topAnchor.constraint(equalTo: topAnchor),
            nameLableCategory.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLableCategory.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupConstraintsDividerLineView(){
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            dividerLineView.heightAnchor.constraint(equalToConstant: 2),
            dividerLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dividerLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
}

extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: appCellID, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: frame.height - 32)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}

class AppCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageAppView: UIImageView = {
        let imageAppView = UIImageView()
        imageAppView.image = UIImage(named: "disney+")
        imageAppView.contentMode = .scaleAspectFill
        imageAppView.layer.cornerRadius = 16
        imageAppView.layer.masksToBounds = true
        imageAppView.translatesAutoresizingMaskIntoConstraints = false
        return imageAppView
    }()
    
    let titleLableApp: UILabel = {
        let titleApp = UILabel()
        titleApp.text = "Disney +"
        titleApp.font = UIFont.systemFont(ofSize: 14)
        titleApp.numberOfLines = 0
        titleApp.translatesAutoresizingMaskIntoConstraints = false
        return titleApp
    }()
    
    let categoryLableApp: UILabel = {
        let categoryLableApp = UILabel()
        categoryLableApp.text = "Entertainment"
        categoryLableApp.font = UIFont.systemFont(ofSize: 13)
        categoryLableApp.textColor = .gray
        categoryLableApp.translatesAutoresizingMaskIntoConstraints = false
        return categoryLableApp
    }()
    
    let priceLableApp: UILabel = {
        let priceLableApp = UILabel()
        priceLableApp.text = "$3.99"
        priceLableApp.font = UIFont.systemFont(ofSize: 13)
        priceLableApp.textColor = .gray
        priceLableApp.translatesAutoresizingMaskIntoConstraints = false
        return priceLableApp
    }()
    
    private func setupViews() {
        
        // Add View
        addSubview(imageAppView)
        addSubview(titleLableApp)
        addSubview(categoryLableApp)
        addSubview(priceLableApp)
        
        // Constraints View
        NSLayoutConstraint.activate([
            imageAppView.topAnchor.constraint(equalTo: topAnchor),
            imageAppView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageAppView.widthAnchor.constraint(equalToConstant: frame.width),
            imageAppView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLableApp.topAnchor.constraint(equalTo: imageAppView.bottomAnchor, constant: 3),
            titleLableApp.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLableApp.widthAnchor.constraint(equalToConstant: frame.width)
        ])
        
        NSLayoutConstraint.activate([
            categoryLableApp.topAnchor.constraint(equalTo: titleLableApp.bottomAnchor, constant: 2),
            categoryLableApp.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLableApp.widthAnchor.constraint(equalToConstant: frame.width)
        ])
        
        NSLayoutConstraint.activate([
            priceLableApp.topAnchor.constraint(equalTo: categoryLableApp.bottomAnchor, constant: 2),
            priceLableApp.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLableApp.widthAnchor.constraint(equalToConstant: frame.width)
        ])
    }
    
}
