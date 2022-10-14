//
//  MenuViewController.swift
//  TestHammerSystem
//
//  Created by Vicodin on 13.10.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    var previousSelected : IndexPath?
    var currentSelected : Int?
    
    private let arreyCity = ["Москва", "Калининград", "Санкт-Петербург", "Нижний Новгород", "Владимир"]
    
    private let bannersModel = BannerModel.makeCategoryModel()
    
    private let categoryModel = CategoryModel.makeCategoryModel()
    
    private let menuModel = MenuModel.makeMenuModel()
    
    private lazy var citySwitch: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.text = arreyCity[0]
        $0.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
        return $0
    }(UILabel())
    
    private let citySwitchImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = .black
        return $0
    }(UIImageView())
    
    private lazy var cityPickerView: UIPickerView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        $0.alpha = 0.0
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UIPickerView())
    
    private lazy var collectionViewBanners: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 112)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(BannersCollectionViewCell.self, forCellWithReuseIdentifier: BannersCollectionViewCell.identifier)
        return collection
    }()
    
    private lazy var collectionViewCategory: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 88, height: 32)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(CollectionViewCellCategory.self, forCellWithReuseIdentifier: CollectionViewCellCategory.identifier)
        return collection
    }()
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
        return $0
    }(UITableView())
    
    private func tapGesturesSwitch() {
        let tapGestImage = UITapGestureRecognizer(target: self, action: #selector(tapActionSwitch))
        citySwitchImage.addGestureRecognizer(tapGestImage)
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapActionSwitch))
        citySwitch.addGestureRecognizer(tapGest)
    }

    @objc private func tapActionSwitch() {
        if cityPickerView.isHidden == false {
            UIView.animate(withDuration: 0.2) {
                self.cityPickerView.alpha = 0.0
            } completion: { _ in
                self.cityPickerView.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.cityPickerView.isHidden = false
                self.cityPickerView.alpha = 1.0
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        layout()
        tapGesturesSwitch()
    }
    
    private func layout() {
        
        [citySwitch, citySwitchImage, collectionViewBanners, collectionViewCategory, tableView, cityPickerView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            citySwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            citySwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            citySwitch.bottomAnchor.constraint(equalTo: collectionViewBanners.topAnchor),
            
            cityPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            cityPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            cityPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            citySwitchImage.topAnchor.constraint(equalTo: citySwitch.topAnchor, constant: 3),
            citySwitchImage.leadingAnchor.constraint(equalTo: citySwitch.trailingAnchor, constant: 8),
            citySwitchImage.bottomAnchor.constraint(equalTo: citySwitch.bottomAnchor),
            
            collectionViewBanners.topAnchor.constraint(equalTo: citySwitch.bottomAnchor),
            collectionViewBanners.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionViewBanners.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionViewBanners.bottomAnchor.constraint(equalTo: collectionViewCategory.topAnchor),
            collectionViewBanners.heightAnchor.constraint(equalToConstant: 112),
            
            collectionViewCategory.topAnchor.constraint(equalTo: collectionViewBanners.bottomAnchor),
            collectionViewCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionViewCategory.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionViewCategory.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            collectionViewCategory.heightAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: collectionViewCategory.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

//MARK: - UIPickerViewDataSource
extension MenuViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arreyCity.count
    }
}

//MARK: - UIPickerViewDelegate
extension MenuViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        arreyCity[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = arreyCity[row]
        citySwitch.text = text
        UIView.animate(withDuration: 0.2) {
            self.cityPickerView.alpha = 0.0
        } completion: { _ in
            self.cityPickerView.isHidden = true
        }
    }
}

//MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
        cell.setupCell(menuModel[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {

}

//MARK: - UICollectionViewDataSource
extension MenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategory {
            return categoryModel.count
        } else {
            return bannersModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategory {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellCategory.identifier, for: indexPath) as! CollectionViewCellCategory
            cell.setupCell(categoryModel[indexPath.item])
            
            if currentSelected != nil && currentSelected == indexPath.row {
                cell.layer.cornerRadius = 16
                cell.contentView.layer.borderWidth = 0
                cell.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
            } else {
                cell.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannersCollectionViewCell.identifier, for: indexPath) as! BannersCollectionViewCell
            cell.setupCell(bannersModel[indexPath.item])
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MenuViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = CGSize(width: 88, height: 32)
//
//        if collectionView == collectionViewCategory {
//            return size
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        1
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 24, left: 0, bottom: 50, right: 0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        1
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if previousSelected != nil {
            if let cell = collectionView.cellForItem(at: previousSelected!) {
                cell.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
                cell.contentView.layer.borderWidth = 1
            }
        }
        currentSelected = indexPath.row
        previousSelected = indexPath
        collectionView.reloadItems(at: [indexPath])
    }
}
