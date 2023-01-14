//
//  BaseViewModel.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import RappleProgressHUD

class BaseViewModel {
    
    init() { }
    
    static var loading: Bool = false {
        didSet {
            if loading {
                RappleActivityIndicatorView.startAnimating()
            } else {
                RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Completed.", completionTimeout: 1.0)
            }
        }
    }
}

