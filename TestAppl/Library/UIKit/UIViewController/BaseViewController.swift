//
//  BaseViewController.swift
//  TestApp
//
//  Created by Kirill Khristenko on 28.08.2022.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    var rootView: View { view as! View }
    
    
    override func loadView() {
        view = View()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   
    
}
