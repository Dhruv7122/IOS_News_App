//
//  NewsBlogVC.swift
//  ExamApp
//
//  Created by STTL on 01/05/24.
//

import UIKit

class NewsBlogVC: UIViewController {

    //Outlets
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblReadTIme: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblBlog: UILabel!
    @IBOutlet weak var lblPhotoCredit: UILabel!
    @IBOutlet weak var horizontalCV: UICollectionView!
    @IBOutlet weak var constraintHeightHCV: NSLayoutConstraint!
    
    //Variables
    var newsData : NewsModel?
    var horizontalDatasourceDelegate : HorizontalDataSourceDelegate!
    var arrData : [NewsModel] = []
    var webService = NewsWebService()
    
    //Main Action
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHeadline.text = newsData?.headline ?? ""
        lblCategory.text = newsData?.category ?? "general"
        lblDate.text = newsData?.date ?? "not available"
        lblTime.text = newsData?.time ?? "not available"
        lblReadTIme.text = newsData?.readingTime ?? "not available"
        lblBlog.text = newsData?.blog ?? "Sorry, Blog not Available!"
        lblPhotoCredit.text = newsData?.photoCredit ?? "(Photo Credit : Not Available)"
        
        if let imgStr = newsData?.imgUrl{
            if let urlStr = URL(string: imgStr){
                imgNews.loadImage(url:urlStr)
            }
        }
        for newsid in CentralArray.shared.arrSource {
            if newsid == newsData?.id {
                btnBookmark.isSelected.toggle()
            }
        }
        getData()
    }
    
    //Function For Getting Data from JSON
    func getData(){
        webService.getNewsList { arr in
            arrData = arr
        }
        setUpHorizontalCollectionView()
    }
    
    // Set up Horizontal collection View
    func setUpHorizontalCollectionView() {
        let width = (horizontalCV.frame.width) / 1.5
        let height = (width / 2) + 68
        let lineHeight = "abc".height(withConstrainedWidth: width, font: .systemFont(ofSize: 16, weight: .semibold))
        let lineHeight2 = "abc".height(withConstrainedWidth: width, font: .systemFont(ofSize: 12, weight: .regular))
        let finalHeight = height + (lineHeight*3) + lineHeight2 + 10
        constraintHeightHCV.constant = finalHeight
        if horizontalDatasourceDelegate == nil {
            horizontalDatasourceDelegate = .init(arrData: arrData, delegate: self, col: horizontalCV,vc:self, height: Float(finalHeight),category : newsData?.category ?? "",id : (newsData?.id)!)
        }
    }
    
    //bookmark btn click action
    @IBAction func btnBookmarkClickAction(_ sender: Any) {
        if btnBookmark.isSelected {
            CentralArray.shared.arrSource.removeAll { $0 == newsData?.id }
        }else{
            CentralArray.shared.arrSource.append((newsData?.id)!)
        }
        btnBookmark.isSelected.toggle()
    }
    
    // back Btn Click Action
    @IBAction func btnBackClickAction(_ sender: Any) {
        
        // Clear the navigation stack
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
        // Navigate to the target view controller
        Navigation.navigateToOtherController("Main", "ViewController", from: self)
    }
    
    //share btn click action
    @IBAction func shareButtonClicked(_ sender: UIButton) {
        
        guard let viewController = parentViewController else {
            print("Parent view controller not found.")
            return
        }
        
        let textToShare = newsData?.blog
        let activityViewController = UIActivityViewController(activityItems: [textToShare ?? ""], applicationActivities: nil)
        viewController.present(activityViewController, animated: true, completion: nil)
    }
}

//MARK:- Extension for ColViewDelegate
extension NewsBlogVC: ColViewDelegate {
    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
}
