//
//  HorizontalDataSourceDelegate.swift
//  ExamApp
//
//  Created by STTL on 01/05/24.
//

import Foundation
import UIKit


//Protocol for selection of Row
protocol ColViewDelegate {
    func didSelect(colView: UICollectionView, indexPath: IndexPath)
}

class HorizontalDataSourceDelegate: NSObject {

    //Datatype Alias
    //    typealias T = UserModel
    typealias T = NewsModel
    typealias col = UICollectionView
    typealias del = ColViewDelegate
    typealias vc = UIViewController

    //Variables
    internal var height: Float
    internal var arrSource: [T]
    internal var colvw: col
    internal var delegate: del
    internal weak var vc:vc?

    //Variables with Declaration
    let kNumberOfItemsInOneRow: CGFloat = 1
    let kEdgeInset:CGFloat = 2
    let minimumInterItemandLinespacing:CGFloat = 12
    let widthhr:CGFloat = 289

    //MARK:- Initializers
    required init(arrData: [T], delegate: ColViewDelegate, col: UICollectionView,vc:vc, height: Float, category : String, id: Int) {
        arrSource = arrData
        colvw = col
        self.height = height
        self.delegate = delegate
        self.vc = vc
        super.init()
        filterData(category: category, id : id)
        setupCol()
    }
    
    //For Filerting Data
    //params: (category : String, id: int)
    func filterData(category: String,id:Int){
        arrSource = arrSource.filter({ news in
            return news.category == category  && news.id != id
        })
    }
    
    //Setup Collection View
    fileprivate func setupCol(){
        let nib = UINib(nibName: "MainCVC", bundle: nil)
        colvw.register(nib, forCellWithReuseIdentifier: "MainCVC")
        colvw.dataSource = self
        colvw.delegate = self
        colvw.reloadData()
    }

    //Reload Collection View
    func reload(arr:[T]){
        arrSource = arr
        colvw.reloadData()
    }
}

//MARK:- Collection View Delegate Extension
extension HorizontalDataSourceDelegate:UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelect(colView: colvw, indexPath: indexPath)
    }

}

//MARK:- Collection View Datasource Extension
extension HorizontalDataSourceDelegate:UICollectionViewDataSource {

    //No. of Items in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }

    //Set value of cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVC", for: indexPath) as! MainCVC
        
        BorderFactory.addShadow(to: cell,shadowRadius: 2.0, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.2, shadowOffset: CGSize(width: 0, height: 0))
        
        cell.configCell(data: arrSource[indexPath.row])
        return cell
    }
}


//MARK:- UICollectionViewDelegateFlowLayout Methods
extension HorizontalDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    //Minimum Line Spacing For Section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemandLinespacing
    }

    //Minimum Spacing Between Items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemandLinespacing
    }

    //Size of an Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 14) / 1.5
        return .init(width: width, height: CGFloat(height))
    }

    //Whole Section Padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: kEdgeInset, left: kEdgeInset, bottom: kEdgeInset, right: kEdgeInset)
    }
}
