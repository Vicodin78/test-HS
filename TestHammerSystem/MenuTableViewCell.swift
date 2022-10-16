//
//  MenuTableViewCell.swift
//  TestHammerSystem
//
//  Created by Vicodin on 13.10.2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    private let whiteView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private let pizzaImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let namePizza: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
        $0.textColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        return $0
    }(UILabel())
    
    private let descriptionPizza: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = UIFont(name: "SFUIDisplay-Medium", size: 13)
        $0.textColor = UIColor(red: 0.665, green: 0.668, blue: 0.679, alpha: 1)
        return $0
    }(UILabel())
    
    private let pricePizza: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "SFUIDisplay-Medium", size: 13)
        $0.textColor = UIColor(named: "AccentColor")
        $0.textAlignment = .center
        $0.layer.cornerRadius = 6
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ model: Menu) {
        
//        if let url = URL(string: model.image_url) {
//            if let data = try? Data(contentsOf: url) {
//                self.pizzaImage.image = UIImage(data: data)
//            }
//        }
    
    let url = URL(string: model.image_url)
        do {
            if let url = url {
                Task{@MainActor in
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    self.pizzaImage.image = UIImage(data: data)
                    self.namePizza.text = model.name
                    self.descriptionPizza.text = model.description
                    self.pricePizza.text = "от 345 р"
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    private func layout() {
        [whiteView, pizzaImage, namePizza, descriptionPizza, pricePizza].forEach {contentView.addSubview($0)}
        
        let pizzaSize: CGFloat = 132
        let pizzaInsert: CGFloat = 16
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            whiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            pizzaImage.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: pizzaInsert),
            pizzaImage.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: pizzaInsert),
            pizzaImage.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -pizzaInsert),
            pizzaImage.widthAnchor.constraint(equalToConstant: pizzaSize),
            pizzaImage.heightAnchor.constraint(equalToConstant: pizzaSize),
            
            namePizza.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: pizzaInsert),
            namePizza.leadingAnchor.constraint(equalTo: pizzaImage.trailingAnchor, constant: 32),
            namePizza.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionPizza.topAnchor.constraint(equalTo: namePizza.bottomAnchor, constant: 8),
            descriptionPizza.leadingAnchor.constraint(equalTo: namePizza.leadingAnchor),
            descriptionPizza.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            
            pricePizza.topAnchor.constraint(equalTo: descriptionPizza.bottomAnchor, constant: 16),
            pricePizza.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            pricePizza.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -16),
            pricePizza.widthAnchor.constraint(equalToConstant: 87),
            pricePizza.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

}
