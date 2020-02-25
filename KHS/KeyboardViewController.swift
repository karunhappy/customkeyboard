//
//  KeyboardViewController.swift
//  KHS
//
//  Created by Karun Aggarwal on 04/10/19.
//  Copyright © 2019 Karun Aggarwal. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    //: - IBOutlets
        @IBOutlet var nextKeyboardButton: UIButton!
        @IBOutlet weak var stackviewMain: UIStackView!
        @IBOutlet var buttonsCollection: [KeyboardButton]!
        @IBOutlet var viewSymbols: UIView!
        
        //: - Properties
        var selectedState = true
        var keyinput: UIKeyInput?
        
        
        override func updateViewConstraints() {
            super.updateViewConstraints()
            
            // Add custom view sizing constraints here
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let nib = UINib(nibName: "KeyboardView", bundle: nil)
            let objects = nib.instantiate(withOwner: self, options: nil)
            view = objects[0] as? UIView
            
            keyinput = (textDocumentProxy as UIKeyInput)
            self.viewSymbols.isHidden = true
            buttonsCollection.forEach({
                $0.setTitle($0.title(for: .normal)?.lowercased(), for: .normal)
            })
            
            // Perform custom UI setup here
    //        self.nextKeyboardButton = UIButton(type: .system)
    //
    //        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
    //        self.nextKeyboardButton.sizeToFit()
    //        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
    //
    //        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    //
    //        self.view.addSubview(self.nextKeyboardButton)
    //
    //        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    //        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
        
        override func viewWillLayoutSubviews() {
    //        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
            super.viewWillLayoutSubviews()
        }
        
        override func textWillChange(_ textInput: UITextInput?) {
            // The app is about to change the document's contents. Perform any preparation here.
        }
        
        override func textDidChange(_ textInput: UITextInput?) {
            // The app has just changed the document's contents, the document context has been updated.
            
            var textColor: UIColor
            let proxy = self.textDocumentProxy
            if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
                textColor = UIColor.white
            } else {
                textColor = UIColor.black
            }
    //        self.nextKeyboardButton.setTitleColor(textColor, for: [])
        }

        @IBAction func keyPressed(_ sender: KeyboardButton) {
            let string = sender.titleLabel!.text
            keyinput!.insertText(string!)
            
            sender.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 2, y: 2)
            }) { (completion) in
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
        /// backspace button
        @IBAction func buttonBackspaceAction(_ sender: UIButton) {
            keyinput!.deleteBackward()
        }
        
        /// Return button
        @IBAction func buttonReturnAction(_ sender: UIButton) {
            keyinput!.insertText("\n")
        }
        
        /// Shift button
        @IBAction func buttonShiftAction(_ sender: UIButton) {
            self.selectedState = !self.selectedState
            sender.isSelected = self.selectedState
            buttonsCollection.forEach({
                if self.selectedState {
                    $0.setTitle($0.title(for: .normal)?.uppercased(), for: .normal)
                } else {
                    $0.setTitle($0.title(for: .normal)?.lowercased(), for: .normal)
                }
            })
        }
        
        /// Globe Change Keyboard button
        @IBAction func buttonGlobeAction(_ sender: UIButton) {
            advanceToNextInputMode()
        }
        
        /// SpaceBar button
        @IBAction func buttonSpaceAction(_ sender: UIButton) {
            keyinput!.insertText(" ")
        }
        
        @IBAction func buttonSymbolAction(_ sender: UIButton) {
            if self.viewSymbols.isHidden {
                self.viewSymbols.isHidden = false
                sender.setTitle("ABC", for: .normal)
            } else {
                self.viewSymbols.isHidden = true
                sender.setTitle("#+=", for: .normal)
            }
        }

}
