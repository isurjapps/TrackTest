//
//  UITextFieldExt.swift
//  CarTrack
//
//  Created by Prashant Singh on 11/5/21.
//

import UIKit

extension UITextField {
    
    enum PaddingToApply {
        case left(CGFloat)
        case right(CGFloat)
    }
    
    func addPadding(padding: PaddingToApply) {
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
            case .left(let spacing):
                let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.leftView = leftPaddingView
                self.leftViewMode = .always

            case .right(let spacing):
                let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.rightView = rightPaddingView
                self.rightViewMode = .always
        }
    }
}
