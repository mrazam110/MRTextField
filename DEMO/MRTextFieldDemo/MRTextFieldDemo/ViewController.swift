//
//  ViewController.swift
//  MRTextFieldDemo
//
//  Created by Muhammad Raza on 25/07/2016.
//  Copyright © 2016 Muhammad Raza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MRTextFieldIBDelegate {

    @IBOutlet weak var textfield: MRTextFieldIB!
    
    @IBOutlet weak var underView: MRTextFieldIB!
    
    @IBOutlet weak var subUnderView: MRTextFieldIB!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textfield.parentView = self.view
        underView.parentView = self.view
        subUnderView.parentView = self.view
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func MRTextFieldDidEndEditing(textField: MRTextFieldIB) {
        print(#function)
    }
    
    func MRTextFieldDidBeginEditing(textField: MRTextFieldIB) {
        print(#function)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

