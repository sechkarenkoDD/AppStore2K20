//
//  FeaturedAppController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import SwiftUI

class TodayController: UIViewController {
    
    let todayViewHC = UIHostingController(rootView: TodayView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(todayViewHC)
        view.addSubview(todayViewHC.view)
        todayViewHC.didMove(toParent: self)
        todayViewHC.view.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
}
