//
//  UILabel+Extension.swift
//  SaleCRM
//
//  Created by Mac02 on 16/7/27.
//  Copyright © 2016年 朱伊. All rights reserved.
//

import UIKit

extension UILabel{
    
    //创建控件Label
    func createLabel(text:String,textColor: UIColor,font:CGFloat,tag:NSInteger = 100) -> UILabel{
        
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFontOfSize(font)
        label.tag = tag
        
        return label
    }
}