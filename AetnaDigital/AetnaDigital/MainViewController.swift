//
//  ViewController.swift
//  AetnaDigital
//
//  Created by Mark Hoyt on 3/29/17.
//  Copyright © 2017 Mark Hoyt. All rights reserved.
//

import UIKit
import BoltsSwift

class MainViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    var currentSearchString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSearchTextField()
        self.initSubmitButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func initSearchTextField() {
        searchTextField = UITextField()
        searchTextField.delegate = self
        view.addSubview(searchTextField)
    }

    fileprivate func initSubmitButton() {
        submitButton = UIButton()
        view.addSubview(submitButton)
    }
    
    @IBAction func performSearch() {
    }
}

extension MainViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        currentSearchString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       return true
    }

}

