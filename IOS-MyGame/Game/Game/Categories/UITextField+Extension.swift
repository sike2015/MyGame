//
//  UITextField+Extension.swift
//  SaleCRM
//
//  Created by Mac02 on 16/7/29.
//  Copyright © 2016年 朱伊. All rights reserved.
//

import UIKit

extension UITextField {
    
    func createTextField(text:String , font:CGFloat, tag:NSInteger = 100) -> UITextField {
        
        let textField = UITextField()
        textField.placeholder = text
        textField.font = UIFont.systemFontOfSize(font)
        textField.tag = tag
        
        return textField
        
    }
}
