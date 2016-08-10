//
//  BaseNorMalViewController.swift
//  Game
//
//  Created by Mac02 on 16/8/3.
//  Copyright © 2016年 sike. All rights reserved.
//

import UIKit
import SnapKit

let KSCREENWIDTH = UIScreen.mainScreen().bounds.width
let KSCREENHEIGHT = UIScreen.mainScreen().bounds.height
let kNavigationBarHeight = 44
let kTabBarHeight = 49     //tabBar高度
let kTopHeight = 64        //获得navigation高度

var request = AFHttpRequest()   //网络请求

class BaseNorMalViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
       
    
    var tableView:UITableView!

    var navigationView = UIView()               //导航栏
    var  titleNames = UILabel()                 //title 文字
    var leftButton = UIButton()                 //返回按钮
    
    var currentProgressView = UIView()          //背景图
    var circumrotateImageView = UIImageView()   //旋转View
    var currentShowText = UILabel() //显示的文字

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default  //导航栏字体颜色默认为黑色
        
        //导航栏颜色
        navigationView = UIView()
        navigationView.backgroundColor = UIColor().colorWithHexStringSwift("#ffffff")
        view.addSubview(navigationView)
        
        
        navigationView.snp_remakeConstraints { (make) in
            make.left.equalTo(view.snp_left)
            make.top.equalTo(0)
            make.width.equalTo(KSCREENWIDTH)
            make.height.equalTo(kTopHeight)
        }
        
        //导航栏title
        titleNames = UILabel()
        titleNames.textColor = UIColor().colorWithHexStringSwift("#333333")
        titleNames.font = UIFont.systemFontOfSize(17.0)
        navigationView.addSubview(titleNames)
        
        titleNames.snp_remakeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(navigationView.snp_centerY)
            make.height.equalTo(20)
        }
        
        
        //返回按钮
        leftButton = UIButton()
        leftButton.setImage(UIImage (named: "back"), forState: .Normal)
        self.view.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(modeChange), forControlEvents: .TouchUpInside)
        
        leftButton.snp_remakeConstraints { (make) in
            make.left.equalTo(view.snp_left).offset(0)
            make.top.equalTo(view.snp_top).offset(30)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        //细线
        let lineView = UIView()
        lineView.backgroundColor = UIColor().colorWithHexStringSwift("#bababa")
        view.addSubview(lineView)
        
        lineView.snp_remakeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(63)
            make.right.equalTo(-0)
            make.height.equalTo(0.5)
        }
        
        //界面的背景颜色
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor().colorWithHexStringSwift("#f4f4f4")
        self.view.addSubview(backgroundView)
        
        backgroundView.snp_remakeConstraints { (make) in
            make.left.equalTo(self.view.snp_left)
            make.top.equalTo(lineView.snp_top).offset(1)
            make.right.equalTo(self.view.snp_right)
            make.height.equalTo(KSCREENHEIGHT)
            
        }

        
    }
    
    func newTableView() -> UITableView {
        
        let newTableView = UITableView.init(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height - 64), style: UITableViewStyle.Plain)
        newTableView.delegate = self
        newTableView.backgroundColor = UIColor().colorWithHexStringSwift("#f4f4f4")
        newTableView.dataSource = self
        newTableView.separatorStyle = .SingleLineEtched
        newTableView.showsVerticalScrollIndicator = false
        view.addSubview(newTableView)
        return newTableView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cellIdentifier")
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cellIdentifier")
            
        }
        
        return cell!
    }

    
    //返回按钮点击事件
    func modeChange(btn:UIButton ) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //设置标题栏字体
    func setTitleName(titleName : String) {
        
        self.titleNames.text = titleName
        
    }
    
    
    //图标旋转
    func showProgressHUDWithMessageSwift(message : String ,insideView : UIView) {
        
        if currentProgressView == true {
            currentProgressView.removeFromSuperview()
        }
        
        //遮挡view
        currentProgressView.frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT)
        currentProgressView.userInteractionEnabled = true
        currentProgressView.backgroundColor = UIColor.whiteColor()
        currentProgressView.alpha = 0.72
        view.addSubview(currentProgressView)
        
        
        if circumrotateImageView == true {
            circumrotateImageView.removeFromSuperview()
        }
        
        //等待图标
        circumrotateImageView.frame = CGRectMake(0, 0, 140/2, 142/2)
        circumrotateImageView.image = UIImage(named: "Wait")
        circumrotateImageView.center = currentProgressView.center
        currentProgressView.addSubview(circumrotateImageView)
        
        //旋转
        var rotationAnimation = CABasicAnimation()
        rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber.init(float: -3.14159265358979323846264338327950288 * 2.0)
        rotationAnimation.duration = 2.0
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = 0x1.fffffep+127
        
        circumrotateImageView.layer .addAnimation(rotationAnimation, forKey: "rotationAnimation")
        
        if currentShowText == true {
            
            currentShowText.removeFromSuperview()
        }
        
        //显示文字
        currentShowText.frame = CGRectMake(0, 0, 200, 20)
        currentShowText.text = message
        currentShowText.font = UIFont.systemFontOfSize(13.0)
        currentShowText.textColor = UIColor.blackColor()
        currentShowText.textAlignment = NSTextAlignment.Center
        currentShowText.center = CGPointMake(CGRectGetMaxX(currentProgressView.bounds)*0.5, circumrotateImageView.center.y + 70)
        currentProgressView.addSubview(currentShowText)
        
        
    }
    
    //在当前的view上显示MBProgressHUD
    func showProgressHUDWithMessageSwift(message : String) {
        
        currentShowText.text = message
    }
    
    //隐藏MBProgressHUD
    func hideProgressHUDSwift(animated : Bool) {
        
        circumrotateImageView.stopAnimating()
        
        currentProgressView.removeFromSuperview()
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
