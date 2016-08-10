//
//  String+Extension.swift
//  SaleCRM
//
//  Created by Mac02 on 16/7/29.
//  Copyright © 2016年 朱伊. All rights reserved.
//

import UIKit

extension String {
    
    func trimSwift() -> String {  //去前后空格
        
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    func trimMiddleSwift() -> String {  //去中间空格
        
        return self.stringByReplacingOccurrencesOfString(" ", withString: "")
    }
}