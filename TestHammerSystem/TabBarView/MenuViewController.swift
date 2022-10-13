//
//  MenuViewController.swift
//  TestHammerSystem
//
//  Created by Vicodin on 13.10.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let arreyCity = ["Москва", "Калининград", "Санкт-Петербург", "Нижний Новгород", "Владимир"]
    
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
//        $0.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.95)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        $0.alpha = 0.0
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UIPickerView())
    
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
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//    }
}
