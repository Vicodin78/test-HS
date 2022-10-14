//
//  ModelCategory.swift
//  TestHammerSystem
//
//  Created by Vicodin on 14.10.2022.
//

import UIKit

struct CategoryModel {
    let name: String
    
    static func makeCategoryModel() -> [CategoryModel] {
        var model = [CategoryModel]()
        model.append(CategoryModel(name: "Пицца"))
        model.append(CategoryModel(name: "Комбо"))
        model.append(CategoryModel(name: "Десерты"))
        model.append(CategoryModel(name: "Напитки"))
        model.append(CategoryModel(name: "Снеки"))
        model.append(CategoryModel(name: "Соки"))
        model.append(CategoryModel(name: "Фреши"))
        model.append(CategoryModel(name: "Кофе"))
        return model
    }
}
