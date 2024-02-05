//
//  FadeTransition.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 15/05/2023.
//

import UIKit
import SwiftUICoordinator

class FadeTransition: NSObject, Transitionable {
    
    func isEligible(from fromRoute: NavigationRoute,
                    to toRoute: NavigationRoute,
                    operation: NavigationOperation) -> Bool {
        (fromRoute as? MainRoute == .main)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toView: UIView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView: UIView = transitionContext.containerView
        toView.alpha = 0.0
        
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
