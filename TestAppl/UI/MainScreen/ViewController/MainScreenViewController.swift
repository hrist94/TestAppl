//
//  MainScreenViewController.swift
//  TestApp
//
//  Created by Kirill Khristenko on 28.08.2022.
//

import UIKit
import Combine

final class MainScreenViewController<View: MainScreenView>: BaseViewController<View> {
    
    private let viewModel: MainScreenViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: MainScreenViewModel = MainScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        
        viewModel.fetchData()
    }
    
    

}

