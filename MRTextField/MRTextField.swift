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
open class MRTextField: UITextField {
    
    fileprivate var rectangle:CGRect!
    
    fileprivate var highlightLayer = CAShapeLayer()
    fileprivate var normalLayer = CAShapeLayer()
    
    /** Adjust with respect to Drop Down Image and Icon Image*/
    fileprivate var padding:UIEdgeInsets {
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
    @IBInspectable internal var highlightLineColor:UIColor = UIColor.green
    
    /*Line Color*/
    @IBInspectable internal var lineColor:UIColor = UIColor.lightGray
    
    /*Line Width*/
    @IBInspectable internal var lineHeight:CGFloat = 1
    
    /*Hightlight animation*/
    @IBInspectable internal var highlightAnimation:Bool = true
    
    /*Place holder text color*/
    @IBInspectable internal var textColorPlaceHolder:UIColor = UIColor.lightGray
    
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
                bottomStyle = .line
            }else if style == 1 {
                bottomStyle = .squarebracket
            }else {
                bottomStyle = .line
            }
        }
    }
    
    fileprivate var bottomStyle:bottomLine = .line
    
    deinit{
        self.delegate = nil
    }
    
    /*Override DrawRect*/
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        rectangle = rect
        drawLine(normalLayer, isHighlight: false)
        
        if self.iconImage != nil {
            let imageView = UIImageView(frame: CGRect(x: 2, y: 1, width: 15, height: rect.height - 6))
            imageView.image = self.iconImage!
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            self.addSubview(imageView)
        }
        
        if dropDown != nil {
            let imageView = UIImageView(frame: CGRect(x: rect.width-15, y: 1, width: 15, height: rect.height - 6))
            imageView.image = dropDown
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            self.addSubview(imageView)
        }
    }
    
    /*draw bottom line*/
    fileprivate func drawLine(_ layer: CAShapeLayer, isHighlight: Bool){
        let path = getPath()
        
        layer.bounds = self.frame
        layer.position = self.center
        layer.path = path.cgPath
        
        layer.lineWidth = lineHeight
        layer.strokeColor = lineColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        if isHighlight {
            layer.strokeColor = highlightLineColor.cgColor
            if highlightAnimation {
                CATransaction.begin()
                let hlAnimation = CABasicAnimation(keyPath: "strokeEnd")
                hlAnimation.duration = 0.2
                hlAnimation.fromValue = 0.0
                hlAnimation.toValue = 1.0
                hlAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                hlAnimation.isRemovedOnCompletion = false
                hlAnimation.fillMode = kCAFillModeForwards
                CATransaction.setCompletionBlock({ () -> Void in
                })
                layer.add(hlAnimation, forKey: "strokeEnd")
                CATransaction.commit()
            }
        }
        
        self.layer.addSublayer(layer)
    }
    
    /*For removing Highlight*/
    fileprivate func removeHighlight(){
        if highlightAnimation {
            CATransaction.begin()
            let hlAnimation = CABasicAnimation(keyPath: "strokeEnd")
            hlAnimation.duration = 0.1
            hlAnimation.fromValue = 1.0
            hlAnimation.toValue = 0.0
            hlAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            hlAnimation.isRemovedOnCompletion = false
            hlAnimation.fillMode = kCAFillModeForwards
            CATransaction.setCompletionBlock({ () -> Void in
                self.highlightLayer.removeFromSuperlayer()
            })
            highlightLayer.add(hlAnimation, forKey: "strokeEnd")
            CATransaction.commit()
        }else{
            self.highlightLayer.removeFromSuperlayer()
        }
    }
    
    /*returns UIBezierPath*/
    fileprivate func getPath() -> UIBezierPath {
        let path = UIBezierPath()
        switch bottomStyle {
        case .squarebracket:
            path.move(to: CGPoint(x: 0, y: rectangle.height - 5))
            path.addLine(to: CGPoint(x: 0, y: rectangle.height))
            path.addLine(to: CGPoint(x: rectangle.width, y: rectangle.height))
            path.addLine(to: CGPoint(x: rectangle.width, y: rectangle.height - 5))
            break
        default:
            path.move(to: CGPoint(x: 0, y: rectangle.height))
            path.addLine(to: CGPoint(x: rectangle.width, y: rectangle.height))
            break
        }
        
        return path
    }
    
    // MARK: TextField BOUNDS
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
    
    /*Place Holder Setting*/
    override open func drawPlaceholder(in rect: CGRect) {
        let f = UIFont.systemFont(ofSize: textSizePlaceHolder)
        let attributes = [NSForegroundColorAttributeName: textColorPlaceHolder,
                          NSFontAttributeName: f] as [String : Any]
        self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: attributes)
        super.drawPlaceholder(in: rect)
    }
    
    enum bottomLine:Int {
        case line
        case squarebracket
    }
}
