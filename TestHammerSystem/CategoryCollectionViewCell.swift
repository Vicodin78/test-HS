//
//  CollectionViewCellCategory.swift
//  TestHammerSystem
//
//  Created by Vicodin on 14.10.2022.
//

import UIKit

class CollectionViewCellCategory: UICollectionViewCell {
    
    private let titleCell: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
        $0.font = UIFont(name: "SFUIDisplay-Light", size: 13)
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ model: CategoryModel) {
        titleCell.text = model.name
    }
    
    private func customizeCell() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
    }
    
    private func layout() {
        contentView.addSubview(titleCell)
        
        NSLayoutConstraint.activate([
            titleCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
