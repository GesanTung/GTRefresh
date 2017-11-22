//
//  CMRefreshHeaderView.swift
//  Pods
//
//  Created by Gesantung on 2017/5/3.
//
//

import UIKit

class CMRefreshHeaderView: CMRefreshRootView {
    
    fileprivate var preOffsetY: CGFloat = 0.0
    
    override func start() {
        super.start()
        guard let scrollView = scrollView else { return }
        
        self.isIgnore = true
        
        scrollView.bounces = false
        
        self.custom?.refreshBegin(view: self)
        
        var insets = scrollView.contentInset
        self.insets.top = insets.top
        insets.top += (custom?.height) ?? 0.0
        
        scrollView.contentOffset.y = preOffsetY
        
        UIView.animate(withDuration: CMRefreshInfo.shared.animation_duration, delay: 0.0, options: .curveLinear, animations: {
            scrollView.contentInset = insets
            scrollView.contentOffset.y = -insets.top
        }, completion: { (finished) in
            self.action?()
            scrollView.bounces = true
            self.isIgnore = false
        })
    }
    
    override func stop() {
        super.stop()
        guard let scrollView = scrollView else { return }
        
        self.custom?.refreshEnd(view: self)
        
        UIView.animate(withDuration: CMRefreshInfo.shared.animation_duration, delay: 0, options: .curveLinear, animations: {
            scrollView.contentInset.top = self.insets.top
        }, completion: { (finished) in
            self.custom?.refresh(view: self, state: .idle)
            scrollView.contentInset.top = self.insets.top
        })
    }
    
    override func offsetChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
        super.offsetChangeAction(object: object, change: change)
        guard let scrollView = scrollView else {
            return
        }
        guard self.isRefresh == false  else {
            let top = insets.top
            let offsetY = scrollView.contentOffset.y
            let height = self.frame.size.height
            var scrollingTop = (-offsetY > top) ? -offsetY : top
            scrollingTop = (scrollingTop > height + top) ? (height + top) : scrollingTop
            
            scrollView.contentInset.top = scrollingTop
            
            return
        }
        
        let offsets = preOffsetY + insets.top
        if offsets < -(self.custom?.height ?? 0.0) {
     
            if isRefresh == false {
                if scrollView.isDragging == false {
         
                    self.startRefreshing()
                    self.custom?.refresh(view: self, state: .load)
                } else {
               
                    self.custom?.refresh(view: self, state: .pull)
                }
            }
        } else if offsets < 0 {
            // Pull to refresh!
            if isRefresh == false  {
                self.custom?.refresh(view: self, state: .idle)
            }
        } else {
            // idle state
        }
        
        preOffsetY = scrollView.contentOffset.y
        let percent = -(preOffsetY + insets.top) / (self.custom?.height ?? 1.0)
        self.custom?.refresh(view: self, progress: percent)
    }
    
    func noticeNoMoreData() {
        noMoreData = true
        self.custom?.refresh(view: self, state: .no_more_data)
    }
    
    func resetNoMoreData() {
        noMoreData = false
        self.custom?.refresh(view: self, state: .idle)
    }
}
