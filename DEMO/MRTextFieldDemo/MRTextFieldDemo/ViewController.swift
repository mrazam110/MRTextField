//
//  ViewController.swift
//  MRTextFieldDemo
//
//  Created by Muhammad Raza on 25/07/2016.
//  Copyright © 2016 Muhammad Raza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MRTextFieldDelegate {

    @IBOutlet weak var bottomRightTextField: MRTextField!
    @IBOutlet weak var textfield: MRTextField!
    @IBOutlet weak var underView: MRTextField!
    @IBOutlet weak var subUnderView: MRTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textfield.parentView = self.view
        textfield.myDelegate = self
        underView.myDelegate = self
        subUnderView.myDelegate = self
        underView.parentView = self.view
        subUnderView.parentView = self.view
        
        bottomRightTextField.parentView = self.view
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func MRTextFieldShouldBeginEditing(textField: MRTextField) -> Bool {
        return true
    }

    func MRTextFieldDidEndEditing(textField: MRTextField) {
        print(#function)
    }
    
    func MRTextFieldDidBeginEditing(textField: MRTextField) {
        print(#function)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

}

