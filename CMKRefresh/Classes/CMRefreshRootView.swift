//
//  CMRefreshRootView.swift
//  Pods
//
//  Created by Gesantung on 2017/5/3.
//
//

import UIKit

public typealias CMRefreshAction = (() -> ())

public class CMRefreshRootView: UIView {
    
    fileprivate var isObserve = false
    
    public var isRefresh = false
    
    public var noMoreData = false
    
    public var isIgnore = false{
        didSet {
            scrollView?.isScrollEnabled = !isIgnore
        }
    }
    
    public var insets: UIEdgeInsets = .zero
    
    weak var scrollView: UIScrollView?
    
    public var action: CMRefreshAction?
    
    public var custom: CMRefreshViewProtocol?

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin]
    }
    
    public convenience init(custom: CMRefreshViewProtocol, action: @escaping CMRefreshAction) {
        self.init(frame: .zero)
        self.custom  = custom
        self.action = action
        self.addSubview(custom.view)
    }
    
    //MARK: UIView methods
    
    open override func willMove(toSuperview newSuperview: UIView!) {
        super.willMove(toSuperview: newSuperview)
        removeObserver()
        if let scrollView = newSuperview as? UIScrollView {
           insets  = scrollView.contentInset
           self.scrollView = scrollView
           addObserver(scrollView)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let s = bounds.size
        let w = s.width
        let h = s.height
        let view = custom?.view
        let inset = custom?.insets ?? .zero
        view?.frame = CGRect(x: inset.left,
                            y: inset.top,
                            width:w - inset.left - inset.right,
                            height: h - inset.top - inset.bottom)
        view?.autoresizingMask = [
            .flexibleWidth,
            .flexibleTopMargin,
            .flexibleHeight,
            .flexibleBottomMargin
        ]
    }
    
    
    public  func startRefreshing() -> Void {
        guard !isRefresh else { return }
        self.start()
    }
    
    public  func stopRefreshing() -> Void {
        guard isRefresh else { return }
        self.stop()
    }
    
    public func start() {
        self.isRefresh = true
    }
    
    public func stop() {
        self.isRefresh = false
    }
    
    //  ScrollView contentSize change action
    public func sizeChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
        
    }
    
    //  ScrollView offset change action
    public func offsetChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
        
    }
    
}

private var cmContextKey = "CM_REFRESH_CONTEXT"

private var cmOffsetKey = "contentOffset"

private var cmSizeKey = "contentSize"

extension CMRefreshRootView {
    fileprivate func addObserver(_ view: UIView?) {
        if let scrollView = view as? UIScrollView, !isObserve {
            scrollView.addObserver(self, forKeyPath: cmOffsetKey, options:  [.initial, .new], context: &cmContextKey)
            scrollView.addObserver(self, forKeyPath: cmSizeKey, options:  [.initial, .new], context: &cmContextKey)
            isObserve = true
        }
    }
    
    fileprivate func removeObserver() {
        if let scrollView = superview as? UIScrollView, isObserve {
            scrollView.removeObserver(self, forKeyPath: cmOffsetKey, context: &cmContextKey)
            scrollView.removeObserver(self, forKeyPath: cmSizeKey, context: &cmContextKey)
            isObserve = false
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &cmContextKey {
            guard isUserInteractionEnabled == true && isHidden == false else {
                return
            }
            if keyPath == cmSizeKey {
                if isIgnore == false {
                    sizeChangeAction(object: object as AnyObject?, change: change)
                }
            } else if keyPath == cmOffsetKey {
                if isIgnore == false {
                    offsetChangeAction(object: object as AnyObject?, change: change)
                }
            }
        } else {
            
        }
    }
}

///* Action */
//public extension CMRefreshRootView  {
//    
//    public  func startRefreshing() -> Void {
//        guard !isRefresh else { return }
//        self.start()
//    }
//    
//    public  func stopRefreshing() -> Void {
//        guard isRefresh else { return }
//        self.stop()
//    }
//    
//    public func start() {
//        self.isRefresh = true
//    }
//    
//    public func stop() {
//        self.isRefresh = false
//    }
//    
//    //  ScrollView contentSize change action
//    public func sizeChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
//        
//    }
//    
//    //  ScrollView offset change action
//    public func offsetChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
//        
//    }
//    
//}

