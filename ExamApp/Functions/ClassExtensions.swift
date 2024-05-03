//
//  ClassExtensions.swift
//  ExamApp
//
//  Created by STTL on 01/05/24.
//

import Foundation
import UIKit

extension UIImageView {
    //load image from url link
    //params : (image url: URL)
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//MARK:- Extension of String Class for Text Height
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}

//MARK:- Extension of UIResponder Class for Shareing content
extension UIResponder {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            parentResponder = responder.next
        }
        return nil
    }
}


//MARK:- class for bookmark
class CentralArray {
    static let shared = CentralArray()
    var arrSource: [Int] = []

    private init() {}
}
