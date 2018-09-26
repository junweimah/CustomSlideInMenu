//
//  Settings.swift
//  CustomSlideInMenu
//
//  Created by Tandem on 30/05/2018.
//  Copyright © 2018 Tandem. All rights reserved.
//

import UIKit

//a class to hold the collection view objects
class SettingObject: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String){
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Settting = "Setting"
    case TnC = "Terms and privacy policy"
    case sendFeedback = "Send feedback"
    case help = "Help"
    case switchAccount = "Switch Account"
    case cancel = "Cancel"
}

class Settings: NSObject {
    
    //this needs to be global so that both func and access it
    let blackView = UIView()
    
    let heightPerRow: CGFloat = 50
    
    //create cv programmatically
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    
    let settingsObject: [SettingObject] = {
        
        return [SettingObject(name: .Settting, imageName: "setting"),
                SettingObject(name: .TnC, imageName: "privacy"),
                SettingObject(name: .sendFeedback, imageName: "feedback"),
                SettingObject(name: .help, imageName: "help"),
                SettingObject(name: .switchAccount, imageName: "account"),
                SettingObject(name: .cancel, imageName: "cancel")]
    }()
    
    func showSettings() {
        //show menu
        
        //this is for the black view to cover the entire screen instead of just this vc
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.alpha = 0
            blackView.frame = window.frame
            
            //add gesture recognizer to dismiss
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            
            //add the collection view after the black view so that it is above of the black view
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settingsObject.count) * heightPerRow
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                //animate the collection view to slide up from bottom
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        print("handle dismiss here")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }, completion: nil)
    }
    
    override init() {
        super.init()
        //start doing things here
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}

extension Settings: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        cell.settingObject = settingsObject[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.width, height: heightPerRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let settingSelected = settingsObject[indexPath.item]
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            print("setting number and name : " , indexPath.item, settingSelected.name)
            
            //indexPath.item != self.settingsObject.count - 1
            //can use the above checking for if also, that is to get the last row of the collection view, if last, cancel
            
            //this is a safer way, using enum
            if settingSelected.name != .cancel{
                let refreshAlert = UIAlertController(title: "you selected cell # \(indexPath.item) with title \(settingSelected.name)", message: "this is in animation callback", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                if var topController = UIApplication.shared.keyWindow?.rootViewController { //this to get top most, which i think is get the current vc
                    //need this because only vc can call .present to transition to other page,
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController// topController should now be your topmost view controller
                    }
                    topController.present(refreshAlert, animated: true, completion: nil)
                }
            }
        }
    }
}
