//
//  Model Menu.swift
//  TestHammerSystem
//
//  Created by Vicodin on 13.10.2022.
//

import UIKit

struct MenuModel {
    let image: UIImage
    let name: String
    let description: String
    let price: String
    
    static func makeMenuModel() -> [MenuModel] {
        var model = [MenuModel]()
        model.append(MenuModel(image: UIImage(named: "vetchina")!, name: "Ветчина и грибы", description: "Ветчина, шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р"))
        model.append(MenuModel(image: UIImage(named: "bovarskie")!, name: "Баварские колбаски", description: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", price: "от 345 р"))
        model.append(MenuModel(image: UIImage(named: "losos")!, name: "Нежный лосось", description: "Лосось, томаты черри, моцарелла, соус песто", price: "от 345 р"))
        model.append(MenuModel(image: UIImage(named: "pizza4sira")!, name: "Пицца четыре сыра", description: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, Сыр Роккфорти, Сыр Чеддер (тёртый)", price: "от 345 р"))
        return model
    }
}
