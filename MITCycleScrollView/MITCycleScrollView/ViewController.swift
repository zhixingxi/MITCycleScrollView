//
//  ViewController.swift
//  MITCycleScrollView
//
//  Created by MQL-IT on 2016/11/4.
//  Copyright © 2016年 MIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MITSycleScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mitView = MITSycleScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width / 2))
        mitView.currentPageColor = UIColor.red
        mitView.pageColor = UIColor.white
        mitView.placeHolderImage = #imageLiteral(resourceName: "zhanwei")
        mitView.timeSeconds = 2
        mitView.delegate = self
        view.addSubview(mitView)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            mitView.imageArray = ["http://bangimg1.dahe.cn/forum/201511/05/073002qffz5t9twjjbaz6m.jpg","http://tupian.enterdesk.com/2015/gha/09/1502/01.jpg","http://img.ithome.com/newsuploadfiles/2016/3/20160317_080446_325.jpg","http://bangimg1.dahe.cn/forum/201511/05/073002qffz5t9twjjbaz6m.jpg","http://tupian.enterdesk.com/2015/gha/09/1502/01.jpg","http://img.ithome.com/newsuploadfiles/2016/3/20160317_080446_325.jpg"]
        })
    
    }
    
    func didClickBannerIndex(index: Int) {
        print("点击了第\(index)个图片")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

