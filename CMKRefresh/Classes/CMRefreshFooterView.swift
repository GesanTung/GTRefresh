//
//  CMRefreshFooterView.swift
//  Pods
//
//  Created by Gesantung on 2017/5/3.
//
//

import UIKit

class CMRefreshFooterView: CMRefreshRootView {
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        insets = scrollView?.contentInset ?? UIEdgeInsets.zero
        scrollView?.contentInset.bottom = insets.bottom + bounds.size.height
        frame.origin.y = scrollView?.contentSize.height ?? 0.0
    }
    
    override func start() {
        super.start()
        guard let scrollView = scrollView else { return }
        self.isHidden = false
        custom?.refreshBegin(view: self)
        let x = scrollView.contentOffset.x
        let y = max(0.0, scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
        UIView.animate(withDuration: CMRefreshInfo.shared.animation_duration, delay: 0.0, options: .curveLinear, animations: {
            scrollView.contentOffset = .init(x: x, y: y)
        }, completion: { (animated) in
            self.action?()
        })
    }
    
    override func stop() {
        super.stop()
        guard scrollView != nil else { return }
        UIView.animate(withDuration: CMRefreshInfo.shared.animation_duration, delay: 0, options: .curveLinear, animations: {
        }, completion: { (finished) in
            self.custom?.refreshEnd(view: self)
            self.custom?.refresh(view: self, state: self.noMoreData ? .no_more_data: .idle)
        })
    }
    
    override func sizeChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
        super.sizeChangeAction(object: object, change: change)
        guard let scrollView = scrollView else { return }
        let y = scrollView.contentSize.height + insets.bottom
        if self.frame.origin.y != y {
            var rect = self.frame
            rect.origin.y = y
            self.frame = rect
        }
    }

    override func offsetChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
        super.offsetChangeAction(object: object, change: change)
        guard let scrollView = scrollView else { return }
        guard isRefresh == false && noMoreData == false else {
            return
        }
        
        if scrollView.contentSize.height <= 0.0 || scrollView.contentOffset.y + scrollView.contentInset.top <= 0.0 {
            alpha = 0.0
            return
        } else {
            alpha = 1.0
        }
        
        if scrollView.contentSize.height + scrollView.contentInset.top > scrollView.bounds.size.height {
            if scrollView.contentSize.height - scrollView.contentOffset.y + scrollView.contentInset.bottom  <= scrollView.bounds.size.height {
                self.startRefreshing()
                self.custom?.refresh(view: self, state: .load)
            }
        } else {
            if scrollView.contentOffset.y + scrollView.contentInset.top >= (custom?.height ?? 0.0) / 2.0 {
                self.startRefreshing()
                self.custom?.refresh(view: self, state: .load)
            }
        }
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
