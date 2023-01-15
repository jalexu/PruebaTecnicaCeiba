//
//  BaseViewModel.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import RappleProgressHUD

class BaseViewModel: ErrorProcessorType {
    
    weak var errorHandler: ErrorHandlerType?
    
    init() { }
    
    var loading: Bool = false {
        didSet {
            if loading {
                RappleActivityIndicatorView.startAnimating()
            } else {
                RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Completed.", completionTimeout: 1.0)
            }
        }
    }
    
    func handleException(error: Error) {
        handleExceptionError(error: error)
    }
}
