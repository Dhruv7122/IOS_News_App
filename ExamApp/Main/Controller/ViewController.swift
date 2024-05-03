//
//  ViewController.swift
//  ExamApp
//
//  Created by STTL on 01/05/24.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var tblView: UITableView!
    
    //Variables
    var webService = NewsWebService()
    var newsDataSourceDelegate : NewsDataSourceDelegate!
    var arrData : [NewsModel] = []
    
    //main action
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    //Function For Getting Data from JSON
    func getData(){
        webService.getNewsList { arr in
            arrData = arr
        }
        setupTblView()
    }
    
    //SetUP Table Aciton
    func setupTblView(){
        if newsDataSourceDelegate == nil {
            newsDataSourceDelegate = .init(arrData: arrData, delegate: self, tbl: tblView)
        }
    }
}

//MARK:- ViewController Extension
extension ViewController : TblViewDelegate{
    func didselect(tbl: UITableView, indexPath: IndexPath) {
        let selectedItem = arrData[indexPath.row]
        print(selectedItem)
        Navigation.navigateWithData("NewsBlog", "NewsBlogVC", data: selectedItem, from: self)
    }
}


