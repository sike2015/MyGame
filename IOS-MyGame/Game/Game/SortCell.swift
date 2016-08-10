//
//  SortCell.swift
//  Game
//
//  Created by Mac02 on 16/8/4.
//  Copyright © 2016年 sike. All rights reserved.
//

import UIKit

class SortCell: UITableViewCell {
    
    var scoreLabel = UILabel()   //积分
    
    var usernameLabel = UILabel()    //姓名
    
    var titleArray = NSMutableArray()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
        //姓名
        usernameLabel = UILabel().createLabel("第一名", textColor: UIColor().colorWithHexStringSwift("#333333"), font:13.0)
        contentView.addSubview(usernameLabel)
        
        
        usernameLabel.snp_updateConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(65)
            make.top.equalTo(contentView.snp_top).offset(13)
            make.height.equalTo(20)
        }

        
        //积分
        scoreLabel  = UILabel().createLabel("90分", textColor: UIColor().colorWithHexStringSwift("#e900000"), font:14.0)
        contentView.addSubview(scoreLabel)
        
        scoreLabel.snp_updateConstraints { (make) in
            make.right.equalTo(contentView.snp_right).offset(-10)
            make.top.equalTo(contentView.snp_top).offset(13)
            make.height.equalTo(20)
        }
        
        
        //分割线
        let lineView = UIView()
        lineView.backgroundColor = UIColor().colorWithHexStringSwift("#e9e9e9")
        contentView.addSubview(lineView)
        
        lineView.snp_remakeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(scoreLabel.snp_bottom).offset(11)
            make.right.equalTo(contentView.snp_right).offset(-10)
            make.height.equalTo(0.5)
        }

    }
    
    var sortmodel : SortModels? {
        
        didSet  {  //didSet：设置属性后被调用
            
            usernameLabel.text =  self.sortmodel?.username
            
            scoreLabel.text = (self.sortmodel?.score)! + "分"
            
           // print(self.sortmodel?.type )
            
            if (self.sortmodel?.type)! == "1" {
                
                usernameLabel.textColor = UIColor().colorWithHexStringSwift("#e900000")
                
            }else if (self.sortmodel?.type)! == "2" {
                
                usernameLabel.textColor = UIColor().colorWithHexStringSwift("#0000FF")
            
            }else if (self.sortmodel?.type)! == "3" {
                
                usernameLabel.textColor = UIColor().colorWithHexStringSwift("#00FF00")
            
            }else if (self.sortmodel?.type)! == "4" {
             
                usernameLabel.textColor = UIColor().colorWithHexStringSwift("#A020F0")
            
            }else if (self.sortmodel?.type)! == "5" {
            
                usernameLabel.textColor = UIColor().colorWithHexStringSwift("#FF6100")
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
