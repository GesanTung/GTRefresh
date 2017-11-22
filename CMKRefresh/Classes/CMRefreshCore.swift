//
//  CMRefreshCore.swift
//  Pods
//
//  Created by Gesantung on 2017/5/3.
//
//

import UIKit

typealias CMRefreshCore = UIScrollView

private var cmHeaderKey = "CM.REFRESH.HEADER"

private var cmFooterKey = "CM.REFRESH.FOOTER"


protocol CMRefreshCoreProtocol {
    /// 头部控件
    var header: CMRefreshHeaderView? {set get}
    /// 头部控件
    var footer: CMRefreshFooterView? {set get}
    
}

extension CMRefreshCore : CMRefreshCoreProtocol {
    
    var header: CMRefreshHeaderView? {
        get {
            return (objc_getAssociatedObject(self, &cmHeaderKey) as? CMRefreshHeaderView)
        }
        set {
            objc_setAssociatedObject(self, &cmHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
     var footer: CMRefreshFooterView? {
        get {
            return (objc_getAssociatedObject(self, &cmFooterKey) as? CMRefreshFooterView)
        }
        set {
            objc_setAssociatedObject(self, &cmFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func addHeaderRefresh(custom: CMRefreshViewProtocol = CMRefreshDefultHeader(), action: @escaping CMRefreshAction) {
        let header = CMRefreshHeaderView(custom: custom, action: action)
        let headerH = header.custom?.height ?? 0.0
        header.frame = CGRect.init(x: 0.0, y: -headerH , width: self.bounds.size.width, height: headerH)
        self.addSubview(header)
        self.header = header
    }
    
    public func startHeaderRefresh() {
        header?.startRefreshing()
    }
    
    public func stopHeaderRefresh() {
        header?.stopRefreshing()
    }
    
    public func stopHeaderRefresh(noMore:Bool = false) {
        header?.stopRefreshing()
        if noMore { header?.noticeNoMoreData() }
    }
    
    public func setHideHeader(flag:Bool){
        header?.isHidden = flag
    }
    
    public func resetHeadNoMore() {
        header?.resetNoMoreData()
    }
    
    public func removeHeader() {
        self.header?.stopRefreshing()
        self.header?.removeFromSuperview()
        self.header = nil
    }
    
    public func addFooterRefresh(custom: CMRefreshViewProtocol = CMRefreshDefultFooter(), action: @escaping CMRefreshAction) {
        let footer = CMRefreshFooterView(custom: custom, action: action)
        let footerH = footer.custom?.height ?? 0.0
        footer.frame = CGRect.init(x: 0.0, y: self.contentSize.height + self.contentInset.bottom, width: self.bounds.size.width, height: footerH)
        self.addSubview(footer)
        self.footer = footer
    }
    
    public func startFooterRefresh() {
        footer?.startRefreshing()
    }
    
    public func stopFooterRefresh(noMore:Bool = false) {
        footer?.stopRefreshing()
        if noMore { footer?.noticeNoMoreData() }
    }
    
    public func resetNoMore() {
        footer?.resetNoMoreData()
    }
    
    public func setHideFooter(flag:Bool){
        footer?.isHidden = flag
    }
    
    public func removeFooter() {
        self.footer?.stopRefreshing()
        self.footer?.removeFromSuperview()
        self.footer = nil
    }
}

