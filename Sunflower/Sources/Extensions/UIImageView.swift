//
//  UIImageView.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import SDWebImage
import UIKit

extension UIImageView {
    func setImage(with url: URL?, placeholderImage placeholder: UIImage? = nil) {
        sd_setImage(with: url, placeholderImage: placeholder)
    }
}
