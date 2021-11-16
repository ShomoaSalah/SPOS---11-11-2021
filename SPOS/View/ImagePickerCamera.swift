//
//  ImagePickerCamera.swift
//  Bookeeping
//
//  Created by شموع صلاح الدين on 12/21/20.
//  Copyright © 2020 شموع صلاح الدين. All rights reserved.
//

import Foundation
import UIKit
import VisionKit
import SVProgressHUD


public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
    func didSelect(video: URL?)
}

open class ImagePickerCamera: NSObject, VNDocumentCameraViewControllerDelegate {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    var files = [URL]()
    var filesData : Data?
    var viewCon: UIViewController?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.presentationController?.preferredContentSize = .zero
        self.delegate = delegate
        self.pickerController.delegate = self
        self.pickerController.mediaTypes = ["public.image", "public.movie"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    
    private func action2(title: String) -> UIAlertAction? {
      
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            let vc = VNDocumentCameraViewController()
            vc.delegate = self
            self.presentationController?.present(vc, animated: true)
        }
      
    }
    
    
    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Take photo".localized) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll".localized) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library".localized) {
            alertController.addAction(action)
        }
        
//        if let action = self.action2(title: "Scan".localized){
//            alertController.addAction(action)
//        }
        
        /*
         let vc = VNDocumentCameraViewController()
         vc.delegate = self
         present(vc, animated: true)
         */

        alertController.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(image: image)
    }

}

extension ImagePickerCamera: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {

            if mediaType  == "public.image" {
                let image = info[.originalImage] as? UIImage
                self.delegate?.didSelect(image: image)
                print("Image Selected")
            }

            if mediaType == "public.movie" {
                
                let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
                self.delegate?.didSelect(video: videoURL as URL?)
                print("Video Selected \(videoURL)")
            }
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}

extension ImagePickerCamera: UINavigationControllerDelegate {

    
   
    
    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        print("Found \(scan.pageCount)") 
    }
    
}
