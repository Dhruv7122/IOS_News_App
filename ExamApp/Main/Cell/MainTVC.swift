//
//  MainTVC.swift
//  ExamApp
//
//  Created by STTL on 01/05/24.
//

import UIKit
//import SDWebImage

class MainTVC: UITableViewCell {

    //Outlets
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblTimeAndDate: UILabel!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    
    //Variables
    var recievedData : NewsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BorderFactory.addBorder(to: viewContainer, cornerRadius: 10.0, borderColor: nil, borderWidth: 0.0)
        BorderFactory.addBorder(to: imgNews, cornerRadius: 10.0, borderColor: nil, borderWidth: 0.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //Configuration of Cell
    //params: (data : NewsModel)
    func configCell(data:NewsModel){
        for newsid in CentralArray.shared.arrSource {
            if newsid == data.id {
                btnBookmark.isSelected.toggle()
            }
        }
        recievedData = data
        if let imgStr = data.imgUrl{
            if let urlStr = URL(string: imgStr){
                imgNews.loadImage(url:urlStr)
            }
        }
        
        lblCategory.text = data.category
        lblHeadline.text = data.headline
        lblTimeAndDate.text = data.readingTime
    }
    
    //bookmark Btn click Action
    @IBAction func btnBookmarkClickAction(_ sender: UIButton) {
        if btnBookmark.isSelected {
            CentralArray.shared.arrSource.removeAll { $0 == recievedData?.id }
        }else{
            CentralArray.shared.arrSource.append((recievedData?.id)!)
        }
        btnBookmark.isSelected.toggle()
    }
    
    
    //Sharebtn click action
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

