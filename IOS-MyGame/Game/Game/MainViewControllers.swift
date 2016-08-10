//
//  MainViewControllers.swift
//  Game
//
//  Created by Mac02 on 16/8/3.
//  Copyright © 2016年 sike. All rights reserved.
//

import UIKit

class MainViewControllers: BaseNorMalViewController {

    
    var isStart :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTitleName("天平Go Online")
        
        leftButton.hidden = true  ///隐藏返回按钮
        
        //人物图片
        let peopleImageView = UIImageView()
        peopleImageView.image = UIImage(named: "people")
        self.view.addSubview(peopleImageView)
        
        peopleImageView.snp_updateConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.bottom.equalTo(self.view.snp_centerY).offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(130)
        }
        
        //欢迎Label
        let titleLabel = UILabel().createLabel("      欢迎您！   \n天平Go Online", textColor: UIColor().colorWithHexStringSwift("#333333"), font: 17.0)
        titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping  //自动换行
        titleLabel.numberOfLines = 2
        self.view.addSubview(titleLabel)
        
        titleLabel.snp_updateConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.equalTo(peopleImageView.snp_bottom).offset(30)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        //排行榜按钮 
        let listButton = UIButton().createButton("list", selectBackGroundImage: "1",  action: #selector(listButtonAction(_:)), addTarget: self)
        self.view.addSubview(listButton)
        
        
        listButton.snp_updateConstraints { (make) in
            make.left.equalTo(self.view.snp_left).offset(43)
            make.top.equalTo(titleLabel.snp_bottom).offset(55)
            make.right.equalTo(self.view.snp_centerX).offset(-12)
            make.height.equalTo(45)
        }
        
        //修改昵称按钮
        let modifytButton = UIButton().createButton("modify", selectBackGroundImage: "1",  action: #selector(modifyButtonAction(_:)), addTarget: self)
        self.view.addSubview(modifytButton)
        
        
        modifytButton.snp_updateConstraints { (make) in
            make.right.equalTo(self.view.snp_right).offset(-43)
            make.top.equalTo(titleLabel.snp_bottom).offset(55)
            make.left.equalTo(self.view.snp_centerX).offset(12)
            make.height.equalTo(45)
        }
        
        
        //开始按钮
        let startButton = UIButton().createButton("start", selectBackGroundImage: "1",  action: #selector(startButtonAction(_:)), addTarget: self)
        self.view.addSubview(startButton)
        
        
        startButton.snp_updateConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.equalTo(modifytButton.snp_bottom).offset(10)
            make.height.equalTo(45)
        }
        
        
        
        //取出保存的字典
        guard  Utils.loadDataFrom(kSaveInfo) == nil else {
            
            
        
            return
        }
            let registerVC = RegisterViewControllers()
            self.presentViewController(registerVC, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    //排行榜
    func listButtonAction( btn : UIButton) {
        let SortVC = SortViewControllers()
        self.navigationController?.pushViewController(SortVC, animated: true)
        
    }
    
    
    //修改昵称
    func modifyButtonAction(btn : UIButton)  {

        let registerVC = RegisterViewControllers()
        registerVC.isState = true
        self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    //开始游戏
    func startButtonAction(btn : UIButton) {
        
        let GameVC = GameViewController()
        self.navigationController?.pushViewController(GameVC, animated: true)

    }

    
    //默认动画
    func defaultAnimal() -> Void {
        //启动动画
        let gameIcon = SKSplashIcon(image: UIImage(named: "twitterIcon.png"), animationType:.Bounce);
        
        let gameColor = UIColor().colorWithHexStringSwift("#ffffff");
        
        
        let gameView = SKSplashView(splashIcon: gameIcon, backgroundColor: gameColor, animationType: .Bounce);
        
        gameView.animationDuration = 3.2;
        
        self.view.addSubview(gameView);
        
        gameView.startAnimation(); //启动动画
    }
    
    
    
    //每次出现时 调用
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true);

        if !isStart {
            self.defaultAnimal();
            isStart = true;
        }
        
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
