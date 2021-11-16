import UIKit

public class CollectionInputView<T>: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public let cellIdentifier = "CustomPinCodeCVC"
    
    let collectionView: UICollectionView = {
        var flowLayout: UICollectionViewFlowLayout {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return flowLayout
        }
        let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0)
    
    public var items: (() -> [T]) = { return [] }
    public var didSelect: ((T) -> Void)?
    public var didSelectLastIndex: ((T) -> Void)?
    public var text: ((T) -> String) = { _ in return "" }
    public var contains: ((T) -> Bool) = {_ in return false }
    public var font: UIFont = .systemFont(ofSize: 15)
    public var itemBackgroundColor: UIColor = .groupTableViewBackground
    public var selectionColor: UIColor = UIView().tintColor
    
    public required init(
        items: @escaping (() -> [T]) = { return [] },
        didSelect: ((T) -> Void)? = nil,
        text: @escaping ((T) -> String) = { _ in return "" },
        contains: @escaping ((T) -> Bool) = {_ in return false },
        font: UIFont = .systemFont(ofSize: 15),
        itemBackgroundColor: UIColor = .groupTableViewBackground,
        selectionColor: UIColor = UIView().tintColor,
        height: CGFloat 
    ) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        self.items = items
        self.didSelect = didSelect
        self.text = text
        self.contains = contains
        self.font = font
        self.itemBackgroundColor = itemBackgroundColor
        self.selectionColor = selectionColor
        translatesAutoresizingMaskIntoConstraints = true
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.register(CollectionInputViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        print("height123 \(height)... \(heightAnchor)")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.semanticContentAttribute = .forceLeftToRight
        collectionView.register(UINib(nibName: "CustomPinCodeCVC", bundle: nil), forCellWithReuseIdentifier: "CustomPinCodeCVC")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
//        layoutIfNeeded()
        
        collectionView.frame = bounds
        collectionView.layoutIfNeeded()
        
//        collectionView.frame = bounds
        print("FRAME \(collectionView.frame) ... \(bounds)")
        //CGRect(x: 20, y: 20, width: self.view.frame.width-20, height: self.view.frame.width-20)
        
//        collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 484)
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.height = 484
        collectionView.reloadData()
    }
    

    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return items().count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        )
        if let kcvc = cell as? CustomPinCodeCVC {
            kcvc.layoutIfNeeded()
            kcvc.numberLbl.text = text(items()[indexPath.row])
            kcvc.numberLbl.font = font
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        didSelect?(items()[indexPath.row])
        collectionView.reloadData()
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
       
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        
        return CGSize(width: widthPerItem, height: 121)
    }
    
    
    
}
