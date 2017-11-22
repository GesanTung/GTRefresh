//
//  CMRefreshProtocol.swift
//  Pods
//
//  Created by Gesantung on 2017/5/3.
//
//

import UIKit

public protocol CMRefreshViewProtocol {
    
    var view: UIView { get }
    
    var insets: UIEdgeInsets {set get}
    
    var state: CMRefreshState {set get}
    
    var height: CGFloat  {set get}
    
    func refreshBegin(view: CMRefreshRootView)
    
    func refreshEnd(view: CMRefreshRootView)
    
    func refresh(view: CMRefreshRootView, progress: CGFloat)
    
    func refresh(view: CMRefreshRootView, state: CMRefreshState)
}
