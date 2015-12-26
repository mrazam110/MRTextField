//
//  DocumentPickerViewController.swift
//  Documentation
//
//  Created by Muhammad Raza on 24/12/2015.
//  Copyright © 2015 Muhammad Raza Master. All rights reserved.
//

import UIKit

class DocumentPickerViewController: UIDocumentPickerExtensionViewController {

    @IBAction func openDocument(sender: AnyObject?) {
        let documentURL = self.documentStorageURL!.URLByAppendingPathComponent("Untitled.txt")
      
        // TODO: if you do not have a corresponding file provider, you must ensure that the URL returned here is backed by a file
        self.dismissGrantingAccessToURL(documentURL)
    }

    override func prepareForPresentationInMode(mode: UIDocumentPickerMode) {
        // TODO: present a view controller appropriate for picker mode here
    }

}
