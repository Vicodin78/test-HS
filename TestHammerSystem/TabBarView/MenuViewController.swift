//
//  MenuViewController.swift
//  TestHammerSystem
//
//  Created by Vicodin on 13.10.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let arreyCity = ["Москва", "Калининград", "Санкт-Петербург", "Нижний Новгород", "Владимир"]
    
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
        $0.alpha = 0.0
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UIPickerView())
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
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
        view.backgroundColor = .systemGray5
        layout()
        tapGesturesSwitch()
    }
    
    private func layout() {
        
        [citySwitch, citySwitchImage, cityPickerView, tableView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            citySwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            citySwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            cityPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cityPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

//MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    
}
