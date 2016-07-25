//
//  MRTextFieldController.swift
//  MRMViewControllerDemo
//
//  Created by Muhammad Raza on 24/12/2015.
//  Copyright © 2015 Muhammad Raza. All rights reserved.
//

import UIKit

@IBDesignable
class MRTextFieldIB:UITextField, UITextFieldDelegate {
    
    private var rectangle:CGRect!
    
    private var highlightLayer = CAShapeLayer()
    private var normalLayer = CAShapeLayer()
    
    var myDelegate:MRTextFieldIBDelegate?
    
    /** Adjust with respect to Drop Down Image and Icon Image*/
    private var padding:UIEdgeInsets {
        get {
            if iconImage == nil {
                if dropDown != nil {
                    return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 20)
                }
                return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            }else{
                if dropDown != nil {
                    return UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 20)
                }
                return UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 5)
            }
        }
    }
    
    /*Line Color*/
    @IBInspectable internal var highlightLineColor:UIColor = UIColor.greenColor()
    
    /*Line Color*/
    @IBInspectable internal var lineColor:UIColor = UIColor.lightGrayColor()
    
    /*Line Width*/
    @IBInspectable internal var lineHeight:CGFloat = 1
    
    /*Hightlight animation*/
    @IBInspectable internal var highlightAnimation:Bool = true
    
    /*Place holder text color*/
    @IBInspectable internal var textColorPlaceHolder:UIColor = UIColor.lightGrayColor()
    
    /*Place holder text size*/
    @IBInspectable internal var textSizePlaceHolder:CGFloat = 12.0
    
    /** Drop Down Icon's UIImage */
    @IBInspectable internal var dropDown:UIImage? = nil
    
    /**Image Icon*/
    @IBInspectable internal var iconImage:UIImage?
    
    /*Text Field Style
     *0 for Line
     *1 for Square bracket style at the bottom*/
    @IBInspectable var style:Int = 0 {
        didSet{
            if style == 0 {
                bottomStyle = .LINE
            }else if style == 1 {
                bottomStyle = .SQUAREBRACKET
            }else {
                bottomStyle = .LINE
            }
        }
    }
    
    private var bottomStyle:bottomLine = .LINE
    
    deinit{
        self.delegate = nil
    }
    
    /*Override DrawRect*/
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.delegate = self
        
        rectangle = rect
        drawLine(normalLayer, isHighlight: false)
        
        if self.iconImage != nil {
            let imageView = UIImageView(frame: CGRect(x: 2, y: 1, width: 15, height: rect.height - 6))
            imageView.image = self.iconImage!
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            self.addSubview(imageView)
        }
        
        if dropDown != nil {
            let imageView = UIImageView(frame: CGRect(x: rect.width-15, y: 1, width: 15, height: rect.height - 6))
            imageView.image = dropDown
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            self.addSubview(imageView)
        }
    }
    
    /*draw bottom line*/
    private func drawLine(layer: CAShapeLayer, isHighlight: Bool){
        let path = getPath()
        
        layer.bounds = self.frame
        layer.position = self.center
        layer.path = path.CGPath
        
        layer.lineWidth = lineHeight
        layer.strokeColor = lineColor.CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        
        if isHighlight {
            layer.strokeColor = highlightLineColor.CGColor
            if highlightAnimation {
                CATransaction.begin()
                let hlAnimation = CABasicAnimation(keyPath: "strokeEnd")
                hlAnimation.duration = 0.2
                hlAnimation.fromValue = 0.0
                hlAnimation.toValue = 1.0
                hlAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                hlAnimation.removedOnCompletion = false
                hlAnimation.fillMode = kCAFillModeForwards
                CATransaction.setCompletionBlock({ () -> Void in
                })
                layer.addAnimation(hlAnimation, forKey: "strokeEnd")
                CATransaction.commit()
            }
        }
        
        self.layer.addSublayer(layer)
    }
    
    /*For removing Highlight*/
    private func removeHighlight(){
        if highlightAnimation {
            CATransaction.begin()
            let hlAnimation = CABasicAnimation(keyPath: "strokeEnd")
            hlAnimation.duration = 0.1
            hlAnimation.fromValue = 1.0
            hlAnimation.toValue = 0.0
            hlAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            hlAnimation.removedOnCompletion = false
            hlAnimation.fillMode = kCAFillModeForwards
            CATransaction.setCompletionBlock({ () -> Void in
                self.highlightLayer.removeFromSuperlayer()
            })
            highlightLayer.addAnimation(hlAnimation, forKey: "strokeEnd")
            CATransaction.commit()
        }else{
            self.highlightLayer.removeFromSuperlayer()
        }
    }
    
    /*returns UIBezierPath*/
    private func getPath() -> UIBezierPath {
        let path = UIBezierPath()
        switch bottomStyle {
        case .SQUAREBRACKET:
            path.moveToPoint(CGPointMake(0, rectangle.height - 5))
            path.addLineToPoint(CGPointMake(0, rectangle.height))
            path.addLineToPoint(CGPointMake(rectangle.width, rectangle.height))
            path.addLineToPoint(CGPointMake(rectangle.width, rectangle.height - 5))
            break
        default:
            path.moveToPoint(CGPointMake(0, rectangle.height))
            path.addLineToPoint(CGPointMake(rectangle.width, rectangle.height))
            break
        }
        
        return path
    }
    
    // MARK: TextField BOUNDS
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
    
    //UITextFieldDelegate Functions
    func textFieldDidBeginEditing(textField: UITextField) {
        
        drawLine(highlightLayer, isHighlight: true)
        self.myDelegate?.MRTextFieldDidBeginEditing?(self)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.removeHighlight()
        self.myDelegate?.MRTextFieldDidEndEditing?(self)
    }
    
    enum bottomLine:Int {
        case LINE
        case SQUAREBRACKET
    }
}

@objc protocol MRTextFieldIBDelegate {
    optional func MRTextFieldDidBeginEditing(textField: MRTextFieldIB)
    optional func MRTextFieldDidEndEditing(textField: MRTextFieldIB)
}