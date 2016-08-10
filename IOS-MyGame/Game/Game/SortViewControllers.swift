//
//  SortViewControllers.swift
//  Game
//
//  Created by Mac02 on 16/8/4.
//  Copyright © 2016年 sike. All rights reserved.
//

import UIKit

class SortViewControllers: BaseNorMalViewController {
    
    var dataArray = NSMutableArray()
    
    var pag : Int = 0
    
    var listView1 = UIImageView()
    var listView2 = UIImageView()
    var listView3 = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setTitleName("排行榜")
        
        tableView = newTableView()
        tableView.backgroundColor = UIColor().colorWithHexStringSwift("#f5f5f5")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tableView)
        
        tableView.snp_remakeConstraints { (make) in
            make.left.equalTo(self.view.snp_left)
            make.top.equalTo(self.navigationView.snp_bottom)
            make.width.equalTo(KSCREENWIDTH)
            make.height.equalTo(KSCREENHEIGHT - 63)
            
        }
                
        getRequestData()
    }
    
    func getRequestData() {
        
        let request = AFHttpRequest()
        self.showProgressHUDWithMessageSwift("请稍候...", insideView: self.view);
        
        
        request.quertPhp("",
                         onCompletion: { (result) in
                            
                         //   print(result)
                            
                            if result.isKindOfClass(NSArray) {
                            
                                let getArray = result as! NSArray
                                
                                for dict in getArray {
                                    
                                    let  subModel = SortModels.init(coder: dict as! NSDictionary)
                                    
                                    self.dataArray.addObject(subModel!)
                                    
                                }
                                
                            }
            
                            self.tableView.reloadData()
                            //隐藏图标
                            self.hideProgressHUDSwift(true);
                            
            }) { (NSError) in
                //隐藏图标
                self.hideProgressHUDSwift(true);
        }
        
    }
    
    
    //pragma mark-
    //### *** pragma mark TableViewDelegate Method
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 45
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: SortCell? = nil//tableView.dequeueReusableCellWithIdentifier("SortCell") as? SortCell
        
        if (cell == nil) {
            cell = SortCell(style: .Default, reuseIdentifier: "SortCell")
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            
            
        }
        
        
            if indexPath.row == 0 {
            
                listView1 = UIImageView()
                listView1.image = UIImage(named: "list1")
                cell?.contentView.addSubview(listView1)
                
                
                listView1.snp_updateConstraints { (make) in
                    make.left.equalTo(10)
                    make.top.equalTo(5)
                    make.width.equalTo(46)
                    make.height.equalTo(33)
                }
                
            }else if indexPath.row == 1 {
                
                listView2 = UIImageView()
                listView2.image = UIImage(named: "list2")
                cell?.contentView.addSubview(listView2)
                
                
                listView2.snp_updateConstraints { (make) in
                    make.left.equalTo(10)
                    make.top.equalTo(5)
                    make.width.equalTo(46)
                    make.height.equalTo(33)
                }

            } else if indexPath.row == 2 {
                
                listView3 = UIImageView()
                listView3.image = UIImage(named: "list3")
                cell?.contentView.addSubview(listView3)
                
                
                listView3.snp_updateConstraints { (make) in
                    make.left.equalTo(10)
                    make.top.equalTo(5)
                    make.width.equalTo(46)
                    make.height.equalTo(33)
                }
        }
        
        if self.dataArray.count == 0 {
            listView1.hidden = true
            listView2.hidden = true
            listView3.hidden = true
        }else if self.dataArray.count == 1{
            listView1.hidden = false
            listView2.hidden = true
            listView3.hidden = true
        }else if self.dataArray.count == 2 {
            listView1.hidden = false
            listView2.hidden = false
            listView3.hidden = true
        }else if self.dataArray.count == 3 {
            listView1.hidden = false
            listView2.hidden = false
            listView3.hidden = false
        }


        
        if self.dataArray.count > 0 {
            
            cell?.sortmodel = self.dataArray.objectAtIndex(indexPath.row) as? SortModels
            
        }
        
        return cell!
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
