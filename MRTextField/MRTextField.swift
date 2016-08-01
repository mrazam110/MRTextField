/**
 *  MRTextField - Customized UITextField for iOS Developers
 *
 *  For usage, see documentation of the classes/symbols listed in this file, as well
 *  as the guide available at: github.com/johnsundell/wrap
 *
 *  Copyright (c) Muhammad Raza Master. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */
//

import UIKit

@IBDesignable
public class MRTextField:UITextField, UITextFieldDelegate {
    
    private var textFrame:CGRect!
    private var viewY:CGFloat!
    
    internal var parentView: UIView! {
        didSet {
            self.viewY = parentView.frame.origin.y
        }
    }
    
    private var rectangle:CGRect!
    
    private var highlightLayer = CAShapeLayer()
    private var normalLayer = CAShapeLayer()
    
    var myDelegate:MRTextFieldDelegate?
    
    /// Adjust with respect to Drop Down Image and Icon Image
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
    
    /// Highlight Line Color
    @IBInspectable internal var highlightLineColor:UIColor = UIColor.greenColor()
    
    /// Line Color
    @IBInspectable internal var lineColor:UIColor = UIColor.lightGrayColor()
    
    /// Line Width
    @IBInspectable internal var lineHeight:CGFloat = 1
    
    /// Hightlight animation
    @IBInspectable internal var highlightAnimation:Bool = true
    
    /// Place holder text color
    @IBInspectable internal var textColorPlaceHolder:UIColor = UIColor.lightGrayColor()
    
    /// Place holder text size
    @IBInspectable internal var textSizePlaceHolder:CGFloat = 12.0
    
    /// Drop Down Icon's UIImage
    @IBInspectable internal var dropDown:UIImage? = nil
    
    /// Image Icon
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
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /*Override DrawRect*/
    override public func drawRect(rect: CGRect) {
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
    
    // MARK :- TextField Bounds Setting
    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override public func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
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
    
    /**
     Drawing of the placeholder
     
     - parameter rect: rect of UITextField
     */
    override public func drawPlaceholderInRect(rect: CGRect) {
        let f = UIFont.systemFontOfSize(textSizePlaceHolder)
        let attributes = [NSForegroundColorAttributeName: textColorPlaceHolder,
                          NSFontAttributeName: f]
        self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: attributes)
        super.drawPlaceholderInRect(rect)
    }
    
    // MARK :- UITextFieldDelegate Functions
    public func textFieldDidBeginEditing(textField: UITextField) {
        
        drawLine(highlightLayer, isHighlight: true)
        self.myDelegate?.MRTextFieldDidBeginEditing?(self)
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        self.removeHighlight()
        self.myDelegate?.MRTextFieldDidEndEditing?(self)
    }
    
    
    /**
     Delegate function of UITextField to open keyboard on user visible screen.
     
     - parameter textField: selected textField
     
     - returns: Whether you want to open it or not
     */
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        /**
         Add Observer for Keyboard Show and Hide
         */
        func addObserver(){
            // Please check parent view should not be nil.
            if parentView != nil {
                textFrame = CGRect(origin: textField.convertPoint(textField.frame.origin, toView: parentView), size: CGSize(width: 40, height: rectangle.height))
                
                if textFrame.origin.y > parentView.frame.height {
                    textFrame = textField.frame
                }
                
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MRTextField.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MRTextField.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
            }
        }
        
        if let delegate = self.myDelegate {
            if !(delegate.MRTextFieldShouldBeginEditing(textField as! MRTextField)) {
                return false
            }
        }
        
        addObserver()
        
        return true
    }
    
    enum bottomLine:Int {
        case LINE
        case SQUAREBRACKET
    }
    
    /**
     Adjust Height of the View with respect to Keyboard Size and TextField position
     
     - parameter show:         If keyboard is going to show then show must be true otherwise false
     - parameter notification: keyboard values in the notification
     */
    private func adjustingHeight(show: Bool, notification:NSNotification) {
        let userInfo = notification.userInfo!
        
        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        
        if notification.name == UIKeyboardWillShowNotification {
            print("keyboardSize \(keyboardSize)")
            print(textFrame.origin.y + textFrame.height)
            print(textFrame)
            if (textFrame.origin.y + textFrame.height + 25) >= keyboardSize.origin.y {
                print("keyboardSize \(keyboardSize)")
                parentView.frame.origin.y = (keyboardSize.origin.y-(textFrame.origin.y + textFrame.height)) // move up
            }
        }
        else {
            parentView.frame.origin.y = self.viewY // move down
        }
        
        parentView.setNeedsUpdateConstraints()
        let options = UIViewAnimationOptions(rawValue: curve << 16)
        
        UIView.animateWithDuration(duration, delay: 0, options: options,
                                   
                                   animations: {
                                    self.parentView.layoutIfNeeded()
            },
                                   completion: nil
        )
    }
    
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(false, notification: notification)
    }
}

@objc protocol MRTextFieldDelegate {
    optional func MRTextFieldDidBeginEditing(textField: MRTextField)
    optional func MRTextFieldDidEndEditing(textField: MRTextField)
    func MRTextFieldShouldBeginEditing(textField: MRTextField) -> Bool
}