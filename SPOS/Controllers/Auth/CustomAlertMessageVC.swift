//
//  CustomAlertMessageVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/27/21.
//

import UIKit

class CustomAlertMessageVC: UIViewController {
    
    @IBOutlet weak var messageLbl: UILabel!
    
    
    var backOfficeURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 20
        paragraphStyle.lineSpacing = 25
        
        
        let attributedString = NSMutableAttributedString(string: "There is no available in this store\n\n sign out from one of your devices\n\n or add one more pos in the back office")
        
        let linkRange = NSRange(location: 101, length: 11)
        
        let linkAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        attributedString.setAttributes(linkAttributes, range: linkRange)
        
        messageLbl.attributedText = attributedString
        
        messageLbl.isUserInteractionEnabled = true
        messageLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel)))
        
    }
    
    
    @objc func handleTapOnLabel(tapGesture: UITapGestureRecognizer?){
        
        let linkRange = NSRange(location: 101, length: 11)
        
        if tapGesture!.didTapAttributedTextInLabel(label: messageLbl, inRange: linkRange) {
            print("Tapped targetRange1")
            
            if let url = URL(string: backOfficeURL) {
                UIApplication.shared.open(url)
            }
            
        } else {
            print("Tapped none")
        }
        
    }
    
    
    
    @IBAction func hideView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        )
        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x - textContainerOffset.x,
            y: locationOfTouchInLabel.y - textContainerOffset.y
        )
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

