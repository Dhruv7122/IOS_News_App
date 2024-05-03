//
//  MainCVC.swift
//  ExamApp
//
//  Created by STTL on 01/05/24.
//

import UIKit

class MainCVC: UICollectionViewCell {

    //Outlets
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblReadTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    
    //Variable
    var recievedData : NewsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BorderFactory.addBorder(to: viewContainer, cornerRadius: 10.0, borderColor: nil, borderWidth: 0.0)
    }
    
    //Configuration of Cell
    func configCell(data:NewsModel){
        recievedData = data
        if let imgStr = data.imgUrl{
            if let urlStr = URL(string: imgStr){
                imgNews.loadImage(url:urlStr)
            }
        }
        lblCategory.text = data.category
        lblHeadline.text = data.headline
        lblReadTime.text = data.readingTime
        lblDate.text = data.date
    }
    
    //Share Btn Click Action
    @IBAction func shareButtonClicked(_ sender: UIButton) {
        
        guard let viewController = parentViewController else {
            print("Parent view controller not found.")
            return
        }
        let textToShare = recievedData?.blog
        let activityViewController = UIActivityViewController(activityItems: [textToShare ?? ""], applicationActivities: nil)
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
}
