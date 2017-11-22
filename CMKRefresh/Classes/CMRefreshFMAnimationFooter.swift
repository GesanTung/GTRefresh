//
//  CMRefreshFMAnimationFooter.swift
//  Pods
//
//  Created by Gesantung on 2017/5/5.
//
//

import UIKit

public class CMRefreshFMAnimationFooter:UIView, CMRefreshViewProtocol {
    
    public var view: UIView { return self }
    
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    public var height: CGFloat = CMRefreshInfo.shared.height
    
    public var state: CMRefreshState = .idle
    
    lazy var images = UIImage.gifImgWithName("pull_refresh_day")
    
    public let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    public let animation: UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "上拉加载更多"
        addSubview(titleLabel)
        addSubview(animation)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let s = self.bounds.size
        let w = s.width
        let h = s.height
        
        titleLabel.frame = CGRect.init(x: 0, y: 0, width:bounds.size.width, height: 21.0)
        animation.frame = CGRect.init(x: 0, y: 0, width: 52.0, height: 21.0)
        titleLabel.center = CGPoint.init(x: w / 2.0, y: h / 2.0 + 15.0)
        animation.center = CGPoint.init(x: w / 2.0, y: h / 2.0 - 15.0)
    }
}

extension CMRefreshFMAnimationFooter {
    public func refreshBegin(view: CMRefreshRootView) {
        animation.animationImages = images
        animation.startAnimating()
        titleLabel.text = "正在加载更多的数据..."
    }
    
    public func refreshEnd(view: CMRefreshRootView) {
        animation.stopAnimating()
    }
    
    public func refresh(view: CMRefreshRootView, progress: CGFloat) {
        
    }
    
    public func refresh(view: CMRefreshRootView, state: CMRefreshState) {
        guard self.state != state else { return }
        self.state = state
        
        switch state {
        case .load:
            titleLabel.text = "正在加载更多的数据..."
            break
        case .no_more_data:
            titleLabel.text = "没有更多数据"
            break
        case .idle:
            titleLabel.text = "上拉加载更多"
            break
        default:
            break
        }
    }
}
