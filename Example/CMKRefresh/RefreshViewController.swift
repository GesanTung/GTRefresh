//
//  RefreshViewController.swift
//  CMKRefresh
//
//  Created by Gesantung on 2017/5/9.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import CMKRefresh

class RefreshViewController: UIViewController {
    
    let back = UIButton()
    
    let mutable = UITableView()
    
    var count = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mutable.frame = self.view.frame
        self.view.addSubview(mutable)
        mutable.delegate   = self
        mutable.dataSource = self
        //默认自带效果
        mutable.addHeaderRefresh { [weak self] in
            self?.mutable.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.mutable.stopHeaderRefresh()
            }
        }
        mutable.startHeaderRefresh()
        //        mutable.addFooterRefresh { [weak self] in
        //            self?.mutable.reloadData()
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        //                self?.mutable.stopFooterRefresh()
        //            }
        //        }
        //自定义效果封面加载更多
        mutable.addFooterRefresh(custom:CMRefreshFMAnimationFooter()) { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.mutable.stopFooterRefresh(noMore: true)
                self?.count = 40
                self?.mutable.reloadData()
            }
        }
        
        back.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        
        back.addTarget(self, action: #selector(self.backaction), for: .touchUpInside)
        self.view.addSubview(back)
    }
    
    @objc func backaction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RefreshViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

