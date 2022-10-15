//
//  BannersTableViewCell.swift
//  TestHammerSystem
//
//  Created by Vicodin on 15.10.2022.
//

import UIKit

class BannersTableViewCell: UITableViewCell {
    
    private let bannersModel = BannerModel.makeCategoryModel()
    
    private lazy var collectionViewBanners: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 112)
        layout.minimumLineSpacing = 16

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(BannersCollectionViewCell.self, forCellWithReuseIdentifier: BannersCollectionViewCell.identifier)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        contentView.layer.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func layout() {
        contentView.addSubview(collectionViewBanners)
        
        NSLayoutConstraint.activate([
            collectionViewBanners.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionViewBanners.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionViewBanners.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 24),
            collectionViewBanners.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionViewBanners.heightAnchor.constraint(equalToConstant: 112)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension BannersTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannersModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannersCollectionViewCell.identifier, for: indexPath) as! BannersCollectionViewCell
        cell.setupCell(bannersModel[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension BannersTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
