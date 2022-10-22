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

//    class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
//
//    private let todayID = "todayID"
//    private var appList: AppGroup?
//
//    private var appFullscreenController: AppFullscreenController?
//
//    private var topConstraint: NSLayoutConstraint?
//    private var leadingConstraint: NSLayoutConstraint?
//    private var wightConstraint: NSLayoutConstraint?
//    private var heightConstraint: NSLayoutConstraint?
//
//    private var startingFrame: CGRect?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)
//
//        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: todayID)
//        //showApp()
//    }
//
//    // MARK: - CollectionViewDataSourse
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        4
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: todayID, for: indexPath) as! TodayCell
//
//        return cell
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let appFullscreenController = AppFullscreenController()
//        appFullscreenController.dismissHandler = {
//            self.handelRemoveAppFullscreenView()
//        }
//
//        let fullscreenView = appFullscreenController.view!
//
//        view.addSubview(fullscreenView)
//        addChild(appFullscreenController)
//
//        self.appFullscreenController = appFullscreenController
//
//        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
//
//        //abcolute coodindates of cell
//        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
//
//        self.startingFrame = startingFrame
//
//        //auto layout constraint animation
//        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
//        topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
//        leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
//        wightConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
//        heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
//        [topConstraint, leadingConstraint, wightConstraint, heightConstraint].forEach { $0?.isActive = true }
//        self.view.layoutIfNeeded()
//
//        appFullscreenController.view.layer.cornerRadius = 16
//
//        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
//            self.topConstraint?.constant = 0
//            self.leadingConstraint?.constant = 0
//            self.wightConstraint?.constant = self.view.frame.width
//            self.heightConstraint?.constant = self.view.frame.height
//
//            self.navigationController?.isNavigationBarHidden = true
//
//
//            self.view.layoutIfNeeded() //starts animation
//        }
//        //setTabBarHidden(true)
//    }
//
//    @objc func handelRemoveAppFullscreenView() {
//        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
//
//            guard let startingFrame = self.startingFrame else { return }
//            self.topConstraint?.constant = startingFrame.origin.y
//            self.leadingConstraint?.constant = startingFrame.origin.x
//            self.wightConstraint?.constant = startingFrame.width
//            self.heightConstraint?.constant = startingFrame.height
//
//            self.navigationController?.isNavigationBarHidden = false
//
//            self.view.layoutIfNeeded() //starts animation
//
//        }, completion: { _ in
//            self.appFullscreenController?.view.removeFromSuperview()
//            self.appFullscreenController?.removeFromParent()
//        })
//        //setTabBarHidden(false)
//    }
//
//    // MARK: - UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: view.frame.width - 64, height: 350)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        32
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        .init(top: 0, left: 0, bottom: 16, right: 0)
//    }
//
//    }

//extension TodayController {
//
//    func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.7) {
//        if animated {
//            if let frame = self.tabBarController?.tabBar.frame {
//                let factor: CGFloat = hidden ? 1 : -1
//                let y = frame.origin.y + (frame.size.height * factor)
//                UIView.animate(withDuration: duration,
//                               delay: 0,
//                               usingSpringWithDamping: 0.7,
//                               initialSpringVelocity: 0.7,
//                               options: .curveEaseOut) {
//                    self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
//                }
//                return
//            }
//        }
//        self.tabBarController?.tabBar.isHidden = hidden
//    }
//
//}

