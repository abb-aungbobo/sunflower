//
//  AppRouter.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 04/03/2024.
//

import UIKit

final class AppRouter {
    func routeToProductDetail(from sourceViewController: UIViewController, product: ProductResponse) {
        let destinationViewController = ProductDetailScene.create(product: product)
        sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func routeToCart(from sourceViewController: UIViewController) {
        let destinationViewController = CartScene.create()
        sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
