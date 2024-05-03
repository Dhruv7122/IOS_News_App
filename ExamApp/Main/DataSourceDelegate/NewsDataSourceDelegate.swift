//
//  NewsDataSourceDelegate.swift
//  ExamApp
//
//  Created by STTL on 01/05/24.
//

import Foundation
import UIKit

//Table View Delegate Protocol
protocol TblViewDelegate {
    func didselect(tbl: UITableView, indexPath: IndexPath)
}


class NewsDataSourceDelegate: NSObject {
    
    //DataType Alias
    typealias T = NewsModel
    typealias tbl = UITableView
    typealias del = TblViewDelegate
    
    // Variables
    internal var arrSource: [T]
    internal var tblvw: tbl
    internal var delegate: del
    
    
    //MARK:- Initializers
    required init(arrData: [T], delegate: del, tbl: tbl) {
        arrSource = arrData
        tblvw = tbl
        self.delegate = delegate
        super.init()
        setupTbl()
    }
    
    //Setup Table Action
    fileprivate func setupTbl(){
        let nib = UINib(nibName: "MainTVC", bundle: nil)
        tblvw.register(nib, forCellReuseIdentifier: "MainTVC")
        tblvw.dataSource = self
        tblvw.delegate = self
        self.tblvw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tblvw.reloadData()
        
    }
    
    //Reload Table Action
    func reload(arr:[T ]){
        arrSource = arr
        tblvw.reloadData()
    }
    
}

//MARK: - Extenstion of Class With UITableViewDelegate
extension NewsDataSourceDelegate:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didselect(tbl: tblvw, indexPath: indexPath)
    }
   
}

//MARK: - Extension of Class With UITableViewDataSource
extension NewsDataSourceDelegate:UITableViewDataSource
{
    //No. of Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    //Values of Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblvw.dequeueReusableCell(withIdentifier: "MainTVC", for: indexPath)as! MainTVC
        cell.configCell(data: arrSource[indexPath.row])
        return cell
    }
    
    //Enable Editing of Row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Perform Editing of Row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tblvw.beginUpdates()
            arrSource.remove(at: indexPath.row)
            tblvw.deleteRows(at: [indexPath], with: .fade)
            tblvw.endUpdates()
        }
    }

}
