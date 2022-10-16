//
//  MenuViewController.swift
//  TestHammerSystem
//
//  Created by Vicodin on 13.10.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let arreyCity = ["Москва", "Калининград", "Санкт-Петербург", "Нижний Новгород", "Владимир"]
    
    private let headerCategory = CategoryHeaderView()
    
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
    
    private lazy var tableView: UITableView = {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundView = bgColorView
        $0.dataSource = self
        $0.delegate = self
        $0.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
        $0.register(BannersTableViewCell.self, forCellReuseIdentifier: BannersTableViewCell.identifier)
        $0.separatorInset = .zero
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
        view.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        layout()
        tapGesturesSwitch()
        headerCategory.delegate = self
    }
    
    private func layout() {
        
        [citySwitch, citySwitchImage, tableView, cityPickerView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            citySwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            citySwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            cityPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            cityPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            cityPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            citySwitchImage.topAnchor.constraint(equalTo: citySwitch.topAnchor, constant: 3),
            citySwitchImage.leadingAnchor.constraint(equalTo: citySwitch.trailingAnchor, constant: 8),
            citySwitchImage.bottomAnchor.constraint(equalTo: citySwitch.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: citySwitch.bottomAnchor),
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
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : menuModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstCell = tableView.dequeueReusableCell(withIdentifier: BannersTableViewCell.identifier, for: indexPath) as! BannersTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
        cell.setupCell(menuModel[indexPath.row])
        return indexPath.section == 0 ? firstCell : cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 1 ? headerCategory : UIView()
    }
}

//MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 1 ? 80 : 0
    }
}

//MARK: - CategoryCellDelegate
extension MenuViewController: CategoryCellDelegate {
    func scrollCategory(index: IndexPath) {
        var value: Int = 0
        switch index.item {
        case 0:
            value = 0
        case 1:
            value = 3
        case 2:
            value = 5
        case 3:
            value = 6
        case 4:
            value = 9
        case 5:
            value = 12
        case 6:
            value = 15
        case 7:
            value = 18
        case 8:
            value = 22
        default:
            break
        }
        tableView.scrollToRow(at: IndexPath(item: value, section: 1), at: .top, animated: true)
    }
    
    
}
