//
//  CMRefreshDefultFooter.swift
//  Pods
//
//  Created by Gesantung on 2017/5/4.
//
//

import UIKit

public class CMRefreshDefultFooter: UIView, CMRefreshViewProtocol {

    open var view: UIView { return self }
    
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    public var height: CGFloat = CMRefreshInfo.shared.height
    
    public var state: CMRefreshState = .idle
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "Loading more"
        addSubview(titleLabel)
        addSubview(indicatorView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let s = self.bounds.size
        let w = s.width
        let h = s.height
        
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint.init(x: w / 2.0, y: h / 2.0 - 5.0)
        indicatorView.center = CGPoint.init(x: titleLabel.frame.origin.x - 18.0, y: titleLabel.center.y)
    }
}

extension CMRefreshDefultFooter {
   public func refreshBegin(view: CMRefreshRootView) {
        indicatorView.startAnimating()
        titleLabel.text = "Loading..."
        indicatorView.isHidden = false
    }
    
   public func refreshEnd(view: CMRefreshRootView) {
        indicatorView.stopAnimating()
        titleLabel.text = "Loading more"
        indicatorView.isHidden = true
    }
    
    public func refresh(view: CMRefreshRootView, progress: CGFloat) {
    
    }
    
    public func refresh(view: CMRefreshRootView, state: CMRefreshState) {
        guard self.state != state else { return }
        self.state = state
        
        switch state {
        case .load:
            titleLabel.text = "Loading..."
            break
        case .no_more_data:
            titleLabel.text = "No more data"
            break
        case .idle:
            titleLabel.text = "Loading more"
            break
        default:
            break
        }
    }
}
