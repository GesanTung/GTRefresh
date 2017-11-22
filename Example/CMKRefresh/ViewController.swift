//
//  ViewController.swift
//  CMKRefresh
//
//  Created by gesan on 04/17/2017.
//  Copyright (c) 2017 gesan. All rights reserved.
//

import UIKit
import CMKRefresh

class ViewController: UIViewController {
    
    let mutable = UITableView()
    
    var count = 20
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mutable.frame = self.view.frame
        self.view.addSubview(mutable)
        mutable.delegate   = self
        mutable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return GTTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = RefreshViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

class GTTableViewCell:UITableViewCell {
    let title = UILabel()
    let btn = UIButton.init(type: .custom)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildView()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    func buildView() {
        title.text = "1234"
        title.textColor = .red
        title.frame = self.bounds
        btn.frame = self.bounds
        btn.setTitle("click", for:UIControlState())
        self.contentView.addSubview(title)
        self.contentView.addSubview(btn)
        btn.addTarget(self, action: #selector(self.click), for: .touchUpInside)
    }
    
    @objc func click () {
        title.text = "23456"
    }
}

