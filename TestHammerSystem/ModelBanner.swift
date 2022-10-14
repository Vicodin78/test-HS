//
//  ModelBanner.swift
//  TestHammerSystem
//
//  Created by Vicodin on 14.10.2022.
//

import UIKit

struct BannerModel {
    let image: UIImage
    
    static func makeCategoryModel() -> [BannerModel] {
        var model = [BannerModel]()
        model.append(BannerModel(image: UIImage(named: "banner1")!))
        model.append(BannerModel(image: UIImage(named: "banner2")!))
        model.append(BannerModel(image: UIImage(named: "banner3")!))
        model.append(BannerModel(image: UIImage(named: "banner4")!))
        return model
    }
}
