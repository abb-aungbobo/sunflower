//
//  BaseViewController.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 07/03/2024.
//

import UIKit

class BaseViewController: UIViewController {
    func clearContentUnavailableConfiguration() {
        contentUnavailableConfiguration = nil
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    func showLoading() {
        contentUnavailableConfiguration = UIContentUnavailableConfiguration.loading()
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    func showErrorAlert(error: AppError) {
        let alertController = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismiss)
        present(alertController, animated: true)
    }
}
