//
//  CategoryHeaderView.swift
//  TestHammerSystem
//
//  Created by Vicodin on 15.10.2022.
//

import UIKit

protocol CategoryCellDelegate: AnyObject {
    func scrollCategory(index: IndexPath)
}

class CategoryHeaderView: UIView {
    
    weak var delegate: CategoryCellDelegate?

    private var previousSelected : IndexPath?
    private var currentSelected : Int?
    
    private let categoryModel = CategoryModel.makeCategoryModel()
    
    private lazy var collectionViewCategory: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 88, height: 32)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 24
        layout.minimumLineSpacing = 8
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(CollectionViewCellCategory.self, forCellWithReuseIdentifier: CollectionViewCellCategory.identifier)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [collectionViewCategory].forEach{addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            collectionViewCategory.topAnchor.constraint(equalTo: topAnchor),
            collectionViewCategory.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionViewCategory.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionViewCategory.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionViewCategory.heightAnchor.constraint(equalToConstant: 80),

        ])
    }
}

//MARK: - UICollectionViewDataSource
extension CategoryHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellCategory.identifier, for: indexPath) as! CollectionViewCellCategory
        cell.setupCell(categoryModel[indexPath.item])
        
        if currentSelected != nil && currentSelected == indexPath.row {
            cell.layer.cornerRadius = 16
            cell.contentView.layer.borderWidth = 0
            cell.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
//            cell.fontBold()
        } else {
            cell.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoryHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if previousSelected != nil {
            if let cell = collectionView.cellForItem(at: previousSelected!) {
                cell.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
                cell.contentView.layer.borderWidth = 1
                
            }
        }
        currentSelected = indexPath.row
        previousSelected = indexPath
        collectionView.reloadItems(at: [indexPath])
        
        delegate?.scrollCategory(index: indexPath)
    }
}

