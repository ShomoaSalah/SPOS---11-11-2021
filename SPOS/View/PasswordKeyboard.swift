//
//  PasswordKeyboard.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/10/21.
//
import UIKit
protocol KeyboardDelegate {
    func keyWasTapped(character: String)
}

class PasswordKeyboard: UIView , UICollectionViewDataSource , UICollectionViewDelegate {

    @IBOutlet var mCollectionView: UICollectionView!
     var delegate: KeyboardDelegate?
    
    
    var numbers = [
        "1", "2", "3",
        "4", "5", "6",
        "7", "8", "9",
        "", "0", "إزالة",
    ]
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }

    func initializeSubviews() {
        let lBundle = Bundle(for: type(of: self))
     //   let lKeyboardNib = UINib(nibName: "PasswordKeyboard", bundle: lBundle)
        let lCellNib = UINib(nibName: "CustomPinCodeCVC", bundle: lBundle)
    //    let lKeyboardNibView = lKeyboardNib.instantiate(withOwner: self, options: nil).first as! UIView
  //      self.addSubview(lKeyboardNibView)
    //    lKeyboardNibView.frame = self.bounds

        mCollectionView.dataSource = self
        mCollectionView.delegate = self

        mCollectionView.register(lCellNib, forCellWithReuseIdentifier: "CustomPinCodeCVC")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
   {
        return numbers.count
   }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomPinCodeCVC", for: indexPath as IndexPath) as! CustomPinCodeCVC
        //        cell.numberLbl.text = String(describing: indexPath.item) //TODO Randomize this
        let item = numbers[indexPath.row]
        cell.numberLbl.text = item
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomPinCodeCVC
    
        self.delegate?.keyWasTapped(character: cell.numberLbl.text!)


    }
}
