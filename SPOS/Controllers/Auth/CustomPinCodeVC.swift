//
//  CustomPinCodeVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/6/21.
//

import UIKit
import IQKeyboardManagerSwift
import OTPInputView


/*
class CustomPinCodeVC: UIViewController, KeyboardDelegate {
    func keyWasTapped(character: String) {
        //passwordField.insertText(character)
        
        otpTF.forEach { field in
            field.insertText(character)
        }
        
        
    }
    
    
//    func keyWasTapped(character: String) {
//        // required method for keyboard delegate protocol
//
//        print("character 0 \(character)")
//
//        otpTF.forEach { field in
//            print("character \(character)")
//            field.insertText(character)
//        }
//
//    }
    
 

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet var otpTF: [UITextField]!
    
    var maximumDigits: Int = 5
    var delegateOTP: OTPViewDelegate?
    
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0)
    
    
    var numbers = [
        "1", "2", "3",
        "4", "5", "6",
        "7", "8", "9",
        "", "0", "إزالة",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardView = PasswordKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
             keyboardView.delegate = self
           
        
        
//        // initialize custom keyboard
//        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 5))
//
//        keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped
//
//        otpTF.forEach { field in
//            // replace system keyboard with custom keyboard
//            field.inputView = keyboardView
//        }
        
                 
        otpTF.forEach { field in
          //  field.isUserInteractionEnabled = false
            field.delegate = self
            field.inputView = keyboardView
            field.backgroundColor = .white
            field.setBorder(width: 1, color: "C3C5CE".cgColor)
            field.cornerRadius = 4
            field.textColor = "0CA7EE".color
            field.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        }
        
        self.view.endEditing(true)
        initCV()
        otpTF[0].resignFirstResponder()
        otpTF[0].becomeFirstResponder()
        otpTF[0].setBorder(width: 1, color: "0CA7EE".cgColor)
        otpTF[0].backgroundColor = "0CA7EE".color.withAlphaComponent(0.1)
        otpTF[0].cornerRadius = 4
        otpTF[0].textColor = "0CA7EE".color
        
       
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        
        textField.setBorder(width: 1, color: "0CA7EE".cgColor)
        textField.backgroundColor = "0CA7EE".color.withAlphaComponent(0.1)
        textField.cornerRadius = 4
        textField.textColor = "0CA7EE".color
        
        let text = textField.text
        let index = textField.tag + 1
        
        if text?.utf16.count == 1 && index < 4 {
            otpTF[index].becomeFirstResponder()
        } else if text?.utf16.count == 1 {
            self.view.endEditing(true)
        }
    }
    
    
    func getCode() -> String {
        var code = ""
        
        for tf in otpTF {
            if let number = tf.text {
                code += number
            }
        }
        print("NewCode \(code)")
        return code
    }
    
   
 


}


extension CustomPinCodeVC: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.view.endEditing(true)
        if let char = string.cString(using: String.Encoding.utf8) {
               let isBackSpace = strcmp(char, "\\b")
               if (isBackSpace == -92) {
                   print("Backspace was pressed")
               }
           }
           return true
        
    }
    

}



//MARK: - Collection View
extension CustomPinCodeVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func initCV()  {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CustomPinCodeCVC", bundle: nil), forCellWithReuseIdentifier: "CustomPinCodeCVC")

    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  numbers.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomPinCodeCVC", for: indexPath) as! CustomPinCodeCVC
        let item = numbers[indexPath.row]
        cell.numberLbl.text = item
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // let cell = collectionView.cellForItem(at: indexPath) as! CustomPinCodeCVC
       
        let item = numbers[indexPath.row]
        
        switch item {
        case "1":
            otpTF[0].text = item
            if otpTF[0].resignFirstResponder() {
                print("isFirstResponder 0")
                otpTF[0].text = item
                otpTF[1].becomeFirstResponder()
                otpTF[0].resignFirstResponder()
            }else if otpTF[1].isFirstResponder {
                print("isFirstResponder 1")
                otpTF[1].text = item
                otpTF[2].becomeFirstResponder()
                otpTF[2].resignFirstResponder()
            }else if otpTF[2].isFirstResponder {
                print("isFirstResponder 2")
                otpTF[2].text = item
                otpTF[3].becomeFirstResponder()
                otpTF[3].resignFirstResponder()
            }else if otpTF[3].isFirstResponder {
                print("isFirstResponder 3")
                otpTF[3].text = item
//                otpTF[1].becomeFirstResponder()

            }
            break
        case "2":
            break
        case "3":
            break
        case "4":
            break
        case "5":
            break
        case "6":
            break
        case "7":
            break
        case "8":
            break
        case "9":
            break
        case "10":
            break
        case "11":
            break
        case "12":
            
            if otpTF[0].isFirstResponder {
                print("isFirstResponder 0")
                otpTF[0].becomeFirstResponder()
                otpTF[0].text = ""
            }else if otpTF[1].isFirstResponder {
                print("isFirstResponder 1")
                otpTF[0].becomeFirstResponder()
                otpTF[0].text = ""
                
            }else if otpTF[2].isFirstResponder {
                print("isFirstResponder 2")
                otpTF[1].becomeFirstResponder()
                otpTF[1].text = ""
            }else if otpTF[3].isFirstResponder {
                print("isFirstResponder 3")
                otpTF[2].becomeFirstResponder()
                otpTF[2].text = ""

            }
            
            break
       
        default:
            break
        }
     
    }
    
 

}


extension CustomPinCodeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
      print("widthPerItem \(widthPerItem)")
        return CGSize(width: widthPerItem, height: 121)
        
    }
    
  
}


*/
