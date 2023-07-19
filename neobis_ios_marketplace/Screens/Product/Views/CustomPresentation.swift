//
//  CustomPresentation.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 14/7/23.
//

import Foundation
import UIKit

class CustomPresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        
        let popupHeight: CGFloat = 168
        let popupWidth = containerView.bounds.width
        
        return CGRect(x: 0, y: containerView.bounds.height - popupHeight, width: popupWidth, height: popupHeight)
    }
    
//    override func dismissalTransitionDidEnd(_ completed: Bool) {
//        super.dismissalTransitionDidEnd(completed)
//
//
//        blurEffectView?.removeFromSuperview()
//    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        
//        // Dismiss the presented view controller when tapping outside
//        presentedViewController.dismiss(animated: true, completion: nil)
//    }
}
