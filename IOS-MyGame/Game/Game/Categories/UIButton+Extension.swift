//
//  UIButton+Extension.swift
//  SaleCRM
//
//  Created by Mac02 on 16/7/27.
//  Copyright © 2016年 朱伊. All rights reserved.
//

import UIKit

extension UIButton{
    
    //创建按钮Button
    func createButton(normalBackGroundImage:String = "1",selectBackGroundImage:String = "1",title:String = "",titleSize:CGFloat = 10.0 ,action:Selector,addTarget:AnyObject,tag:NSInteger = 100) -> UIButton {
        
        let button = UIButton()
        button .addTarget(addTarget, action: action, forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.systemFontOfSize(titleSize)
        button.setBackgroundImage(UIImage(named: normalBackGroundImage), forState: .Normal)
        button.setBackgroundImage(UIImage(named: selectBackGroundImage), forState: UIControlState.Selected)
        button.setTitle(title, forState: .Normal)
        button.tag = tag
        
        return button
    }

}
