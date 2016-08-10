//
//  RegisterViewControllers.swift
//  Game
//
//  Created by Mac02 on 16/8/3.
//  Copyright © 2016年 sike. All rights reserved.
//

import UIKit
import AdSupport



class RegisterViewControllers: BaseNorMalViewController,UITextFieldDelegate {
    
    var isState : Bool = false
    
    var userName = String()
    var uuid = String()
    var userType = String()
    var maxLevel = String()
    
    var userNameTextField = UITextField()   //新注册的名字
    
    var modifyNameTextField = UITextField() //修改名字
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if Utils.loadDataFrom(kSaveInfo) !== nil {
            
            let getSaveDict = Utils.loadDataFrom(kSaveInfo) as! NSMutableDictionary
            
            userName = getSaveDict[kUserName] as! String
            
            uuid = getSaveDict[kUDID] as! String
            
            userType = getSaveDict[kUserType] as! String
            
            maxLevel = getSaveDict[kScore] as! String

        }
        
       
        
        self.setTitleName("天平Go Online")
        
        
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
        
        
        let inputImageView = UIImageView()
        inputImageView.image = UIImage(named: "Input")
        inputImageView.userInteractionEnabled = true
        self.view.addSubview(inputImageView)
        
        
        inputImageView.snp_updateConstraints { (make) in
            make.left.equalTo(self.view.snp_left).offset(43)
            make.top.equalTo(titleLabel.snp_bottom).offset(55)
            make.right.equalTo(self.view.snp_centerX).offset(-12)
            make.height.equalTo(45)
        }
        
        //注册的text
        userNameTextField = UITextField().createTextField("请输入您的姓名", font: 14.0)
        userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        userNameTextField.delegate = self
        inputImageView.addSubview(userNameTextField)
        
        userNameTextField.snp_updateConstraints { (make) in
            make.left.equalTo(inputImageView.snp_left).offset(8)
            make.right.equalTo(inputImageView.snp_right).offset(-8)
            make.top.equalTo(inputImageView.snp_top).offset(13)
            make.height.equalTo(20)
        
        }
        
        //注册按钮
        let registerButton = UIButton().createButton("register", selectBackGroundImage: "1",  action: #selector(registerButtonAction(_:)), addTarget: self)
        self.view.addSubview(registerButton)
        
        
        registerButton.snp_updateConstraints { (make) in
            make.right.equalTo(self.view.snp_right).offset(-43)
            make.top.equalTo(titleLabel.snp_bottom).offset(55)
            make.left.equalTo(self.view.snp_centerX).offset(12)
            make.height.equalTo(45)
        }
        
        //修改的Text
        modifyNameTextField = UITextField().createTextField("请输入修改姓名", font: 14.0)
        modifyNameTextField.text = userName
        modifyNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        modifyNameTextField.delegate = self
        inputImageView.addSubview(modifyNameTextField)
        
        modifyNameTextField.snp_updateConstraints { (make) in
            make.left.equalTo(inputImageView.snp_left).offset(8)
            make.right.equalTo(inputImageView.snp_right).offset(-8)
            make.top.equalTo(inputImageView.snp_top).offset(13)
            make.height.equalTo(20)
            
        }
        
        //修改按钮
        let modifyButton = UIButton().createButton("modify", selectBackGroundImage: "1",  action: #selector(modifyButtonButtonAction(_:)), addTarget: self)
        self.view.addSubview(modifyButton)
        
        
        modifyButton.snp_updateConstraints { (make) in
            make.right.equalTo(self.view.snp_right).offset(-43)
            make.top.equalTo(titleLabel.snp_bottom).offset(55)
            make.left.equalTo(self.view.snp_centerX).offset(12)
            make.height.equalTo(45)
        }


        
        if isState == true {
            
            userNameTextField.hidden = true
            registerButton.hidden = true
            leftButton.hidden = false  ///隐藏返回按钮
            
        } else if isState == false {
            
            modifyNameTextField.hidden = true
            modifyButton.hidden = true
            leftButton.hidden = true  ///显示返回按钮

        }

    }
    
    
    //注册按钮 
    func registerButtonAction(btn : UIButton)  {
        
        if userNameTextField.text?.trimSwift().characters.count == 0 {
    
            let alertController = UIAlertController(title: "提示",message: "用户名不得为空!",preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定",style: .Default,handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)

            return
            
        } else if userNameTextField.text?.trimSwift().characters.count >= 16 {
            
            let alertController = UIAlertController(title: "提示",message: "用户名不要太长!",preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定",style: .Default,handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        var getUUIDs = String()
        
        getUUIDs = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        
        let request = AFHttpRequest()
        
        
        showProgressHUDWithMessageSwift("load...", insideView: self.view);
        
        request.insertUpdate(userNameTextField.text,
                          score: "0",
                          type:  kDefaultType,
                          udid: getUUIDs,
                          onCompletion: { (result) in
                            
                            guard  Utils.loadDataFrom(kSaveInfo) == nil else {
                                
                                
                                return
                            }
                            
                            let getSaveDict = NSMutableDictionary()
                            
                            //姓名
                            getSaveDict.setValue(self.userNameTextField.text, forKey: kUserName)
                            
                            //UDID
                            getSaveDict.setValue(getUUIDs, forKey: kUDID)
                            
                            //得分
                            getSaveDict.setValue(kDefaultType, forKey: kScore)
                            
                            //类型
                            getSaveDict.setValue(kDefaultType, forKey: kUserType);
                            
                            Utils.saveData(getSaveDict, to: kSaveInfo)
                            
                            
                            
                            //隐藏图标
                            self.hideProgressHUDSwift(true);
                            
                            self.dismissViewControllerAnimated(true) {
                                
                            }

                            
               
                            
            }) { (NSError) in
                //隐藏图标
                self.hideProgressHUDSwift(true);
                
        }
        
    }
    
    
    //修改按钮
    
    func modifyButtonButtonAction(btn : UIButton)  {
        print("修改姓名")
        
        if modifyNameTextField.text?.trimSwift().characters.count == 0 {
            
            let alertController = UIAlertController(title: "提示",message: "用户名不得为空!",preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定",style: .Default,handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
            
        } else if modifyNameTextField.text?.trimSwift().characters.count >= 16 {
            
            let alertController = UIAlertController(title: "提示",message: "用户名不要太长!",preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定",style: .Default,handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        let request = AFHttpRequest()
        showProgressHUDWithMessageSwift("load...", insideView: self.view);
        
        request.updateName(modifyNameTextField.text,
                             score: maxLevel,
                             type:  userType,
                             udid: uuid,
                             onCompletion: { (result) in
                                
                                let getSaveDict = NSMutableDictionary()
                                
                                //姓名
                                getSaveDict.setValue(self.modifyNameTextField.text, forKey: kUserName)
                                
                                //UDID
                                getSaveDict.setValue(self.uuid, forKey: kUDID)
                                
                                //得分
                                getSaveDict.setValue(self.maxLevel, forKey: kScore)
                                
                                //类型
                                getSaveDict.setValue(self.userType, forKey: kUserType);
                                
                                Utils.saveData(getSaveDict, to: kSaveInfo)
                                
                                //隐藏图标
                                self.hideProgressHUDSwift(true);
                                
                                self.navigationController?.popViewControllerAnimated(true)
                                
                                
                                
        }) { (NSError) in
            //隐藏图标
            self.hideProgressHUDSwift(true);
            
        }


    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
