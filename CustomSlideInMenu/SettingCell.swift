//
//  SettingCell.swift
//  CustomSlideInMenu
//
//  Created by Tandem on 30/05/2018.
//  Copyright © 2018 Tandem. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    //MARK: All the variables that is required
    var settingObject: SettingObject? {
        didSet{
            nameLabel.text = settingObject?.name.rawValue //raw vale will get the string
            
            if let imageName = settingObject?.imageName {
                ivIcon.image = UIImage(named: imageName)
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let ivIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "setting")
        iv.contentMode = .scaleAspectFill //keep the ratio
        return iv
    }()
    
    //MARK: Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        addSubview(nameLabel)
        addSubview(ivIcon)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: ivIcon, nameLabel) // for the v0, which is the first view that passed in (ivIcon) has height 30, left 16px, right 8 px, then v1 expand all the way to the edge,
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel) //this is for vertical
        addConstraintsWithFormat(format: "V:[v0(30)]", views: ivIcon) //the icon has height of 30
        
        //set the image iv to verticall allign
        addConstraint(NSLayoutConstraint(item: ivIcon, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
//        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}


