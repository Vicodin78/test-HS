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
        $0.text = arreyCity[0]
        $0.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
        return $0
    }(UILabel())
    
    private let citySwitchImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = .black
//        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private lazy var cityPickerView: UIPickerView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UIPickerView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        layout()
    }
    
    private func layout() {
        [citySwitch, citySwitchImage, cityPickerView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            citySwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            citySwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            cityPickerView.topAnchor.constraint(equalTo: citySwitch.bottomAnchor),
            cityPickerView.leadingAnchor.constraint(equalTo: citySwitch.leadingAnchor),
            
            citySwitchImage.topAnchor.constraint(equalTo: citySwitch.topAnchor, constant: 3),
            citySwitchImage.leadingAnchor.constraint(equalTo: citySwitch.trailingAnchor, constant: 8),
            citySwitchImage.bottomAnchor.constraint(equalTo: citySwitch.bottomAnchor)
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
    }
}
