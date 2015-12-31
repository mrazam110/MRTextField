## MRTextField

![Screenshot](https://github.com/mrazam110/MRTextField/blob/master/screenshots/screenshot03.png)

#Requirements
* iOS 8.0+
* ARC

#Installation
From [CocoaPods](https://www.cocoapods.org/):

````ruby
# For Latest release in cocoapods
pod 'MRTextField'
````

Without CocoaPods:

1. *Why not CocoaPods?*
2. Drag all **.swift** file to your project

##Quick Tips

#You can use IBDesignable

Step 1. Drag and Drop the UITextField

Step 2. In Identity Text, in Custom class, change UITextField to MRTextFieldIB

Step 3. In Attributes Inspector, you can view properties

**Properties:
*Highlight Line Color: UIColor* UIColor.greenColor()
*Line Color: UIColor* default: UIColor.lightGrayColor()
*Line Height: CGFloat* default: 1.0
*Highlight Animation: Bool* default: True
*Text Color Place Holder: UIColor* default: UIColor.lightGrayColor()
*Text Size Place Holder: CGFloat* default: 12.0

*For changing the style of Text Field*

Set Value of `Style` to 0 (LINE) or 1 (SQUARE BRACKET at the Bottom)

and ENJOY!!

#You can use without IBDesignable

Step 1. Drag and Drop the UITextField

Step 2. In Identity Text, in Custom class, change UITextField to MRTextField

All the properties will work same as the UITextField
````swift
// For changing the bottom line color : Default: UIColor.lightGrayColor()
textField.lineColor = UIColor.lightGrayColor()

// For change the Place Holder text color : Default: UIColor.lightGrayColor()
textField.textColorPlaceHolder = UIColor.lightGrayColor()

// For changing the size of Place Holder text : Default: 12.0
textField.textSizePlaceHolder = 12.0

// For changing the bottom line highlight color : Default: UIColor.lightGrayColor()
textField.highlightLineColor = UIColor.greenColor

//For Boldness of Bottom line : Default: 1.0
textField.lineHeight = 1.0

//For Hightlight animation : Default : true
/*True for ON and false for OFF*/
textField.highlightAnimation = true

/* For changing the style of Text Field
.LINE for Line and
.SQAUREBRACKET for different shape at the bottom
by default it is .LINE*/
textField.style = .SQUAREBRACKET
````

##Questions & Help

Use [Issues](https://github.com/mrazam110/MRTextField/issues) for that. Before asking a question, see if it has already been answered

**NOTE:** Please try to avoid emailing me with questions. I prefer to keep questions and their answers open-source

##License

`MRTextField` is released under [MIT License](https://github.com/mrazam110/MRTextField/blob/master/LICENSE)

*Please provide attribution, it is greatly appreciated*
