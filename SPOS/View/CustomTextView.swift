//
//  CustomTextView.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/14/21.
//

import UIKit


class CustomTextView: UITextView {
    
    private let linksAttributes = [NSAttributedString.Key.link]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.onTapAction))
        self.addGestureRecognizer(tapGest)
    }
    
    @objc private func onTapAction(_ tapGest: UITapGestureRecognizer) {
        let location = tapGest.location(in: self)
        let charIndex = self.layoutManager.characterIndex(for: location, in: self.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if charIndex < self.textStorage.length {
            var range = NSMakeRange(0, 0)
            
            for linkAttribute in linksAttributes {
                if let link = self.attributedText.attribute(linkAttribute, at: charIndex, effectiveRange: &range) as? String {
                    guard let url = URL(string: link) else { return }
                    _ = self.delegate?.textView?(self, shouldInteractWith: url, in: range, interaction: .invokeDefaultAction)
                }
            }
        }
    }
    
    
}
