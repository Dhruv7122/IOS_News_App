//
//  Navigation.swift
//  ExamApp
//
//  Created by STTL on 01/05/24.
//

import UIKit

class Navigation{
    
    //Navigation Function : Use to navigate to Other StoryBoard
    //params : (storyboard , viewController , currentViewControlller)
    static func navigateToOtherController(_ storyBoard : String,_ viewController: String, from currentViewController: UIViewController) {
        let sb = UIStoryboard(name:storyBoard,bundle: nil)
        let vc = sb.instantiateViewController(identifier: viewController)
        currentViewController.navigationController?.pushViewController(vc, animated: false)
    }
    
    //Navigation Function : Use to navigate to Other StoryBoard
    //params : (storyboard , viewController , currentNavigationController)
    static func navigateToOtherControllerTableView(_ storyBoard : String,_ viewController: String, from currentNavigationController: UINavigationController) {
        let sb = UIStoryboard(name:storyBoard,bundle: nil)
        let vc = sb.instantiateViewController(identifier: viewController)
        currentNavigationController.pushViewController(vc, animated: true)
    }
    
    //Navigation Function : Use to navigate to Other StoryBoard
    //params : (storyboard , viewController , data , currentViewControlller)
    static func navigateWithData(_ storyBoard : String,_ viewController: String,data: NewsModel, from currentViewController: UIViewController) {
        let sb = UIStoryboard(name:storyBoard,bundle: nil)
        if viewController == "NewsBlogVC"{
            let vc = sb.instantiateViewController(identifier: "NewsBlogVC") as! NewsBlogVC
            vc.newsData = data
            currentViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

