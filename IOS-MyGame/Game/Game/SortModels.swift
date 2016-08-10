//
//  SortModels.swift
//  Game
//
//  Created by Mac02 on 16/8/4.
//  Copyright © 2016年 sike. All rights reserved.
//

import UIKit

class SortModels: NSObject {

    var  username : String?    //名称
    
    var udid : String?         //UUID
    
    var score : String?        //积分
    
    var type : String?         //类型
    
    
    
    
    init?(coder aDecoder: NSDictionary) {
        
        username = aDecoder.objectForKey("username") as? String
        udid = aDecoder.objectForKey("udid") as? String
        score = aDecoder.objectForKey("score") as? String
        type = aDecoder.objectForKey("type") as? String
    }

}
