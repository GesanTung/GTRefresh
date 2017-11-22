//
//  CMRefreshState.swift
//  Pods
//
//  Created by Gesantung on 2017/5/3.
//
//

import Foundation

public enum CMRefreshState {
    /// 普通闲置状态
    case idle
    /// 即将开始刷新的状态
    case pull
    /// 正在开始刷新的状态
    case load
    /// 刷新结束的状态
    case finish
    /// 没有更多的状态
    case no_more_data
    
    public var description: String {
        switch self {
        case .idle: return "idle"
        case .pull: return "pull"
        case .load: return "load"
        case .finish: return "finish"
        case .no_more_data: return "no_more_data"
        }
    }
}
