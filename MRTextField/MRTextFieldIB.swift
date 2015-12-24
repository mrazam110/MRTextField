//
//  MRTextFieldController.swift
//  MRMViewControllerDemo
//
//  Created by Muhammad Raza on 24/12/2015.
//  Copyright © 2015 Muhammad Raza. All rights reserved.
//

import UIKit

@IBDesignable
class MRTextFieldIB:UITextField {
    
    /*Padding Left and Right //UIEdgeInsets(0,5,0,5) TLBR*/
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    /*Line Color*/
    @IBInspectable var lineColor:UIColor = UIColor.blueColor() {
        didSet{
        }
    }
    
    /*Place holder text color*/
    @IBInspectable var textColorPlaceHolder:UIColor = UIColor.lightGrayColor() {
        didSet{
        }
    }
    
    /*Place holder text size*/
    @IBInspectable var textSizePlaceHolder:CGFloat = 12.0 {
        didSet{
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        /*Designing Bottom Line*/
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, rect.height - 5))
        path.addLineToPoint(CGPointMake(0, rect.height))
        path.addLineToPoint(CGPointMake(rect.width, rect.height))
        path.addLineToPoint(CGPointMake(rect.width, rect.height-5))
        
        lineColor.setStroke()
        path.stroke()
        
        path.lineWidth = 2
    }
    
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    private func newBounds(bounds: CGRect) -> CGRect {
        
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
    
    /*Place Holder Setting*/
    override func drawPlaceholderInRect(rect: CGRect) {
        let f = UIFont.systemFontOfSize(textSizePlaceHolder)
        let attributes = [NSForegroundColorAttributeName: textColorPlaceHolder,
            NSFontAttributeName: f]
        self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: attributes)
        super.drawPlaceholderInRect(rect)
    }
    
}
