//
//  CMRefreshDefultHeader.swift
//  Pods
//
//  Created by Gesantung on 2017/5/3.
//
//

import UIKit

public class CMRefreshDefultHeader:UIView , CMRefreshViewProtocol {
    
    public let imageView: UIImageView = {
        let imageView = UIImageView.init()
        guard let path = Bundle.init(for: CMRefreshDefultHeader.self).path(forResource: "refresh_arrow@3x", ofType: "png") else {
            return imageView
        }
        imageView.image = UIImage(contentsOfFile: path)

        return imageView
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 0.625, alpha: 1.0)
        label.textAlignment = .left
        return label
    }()
    
    public let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "下拉加载更多"
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(indicatorView)
    }
    
    open var view: UIView { return self }
    
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    public var height: CGFloat = CMRefreshInfo.shared.height
    
    public var state: CMRefreshState = .idle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let s = bounds.size
        let w = s.width
        let h = s.height
        
        UIView.performWithoutAnimation {
            titleLabel.sizeToFit()
            titleLabel.center = .init(x: w / 2.0, y: h / 2.0)
            indicatorView.center = .init(x: titleLabel.frame.origin.x - 16.0, y: h / 2.0)
            imageView.frame = CGRect.init(x: titleLabel.frame.origin.x - 28.0, y: (h - 18.0) / 2.0, width: 18.0, height: 18.0)
        }
    }
}

extension CMRefreshDefultHeader {
    public func refreshBegin(view: CMRefreshRootView) {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        imageView.isHidden     = true
        titleLabel.text        = "正在刷新数据中..."
        imageView.transform    = CGAffineTransform(rotationAngle: 0.000001 - CGFloat(Double.pi))
    }
    
    public func refreshEnd(view: CMRefreshRootView) {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        imageView.isHidden = false
        titleLabel.text        = "下拉可以刷新"
        imageView.transform = CGAffineTransform.identity
    }
    
    public func refresh(view: CMRefreshRootView, progress: CGFloat) {
    }
    
    public func refresh(view: CMRefreshRootView, state: CMRefreshState) {
        switch state {
        case .load:
            titleLabel.text = "正在刷新数据中..."
            setNeedsLayout()
            break
        case .pull:
            titleLabel.text = "松开立即刷新"
            self.setNeedsLayout()
            UIView.animate(withDuration: CMRefreshInfo.shared.animation_duration, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                [weak self] in
                self?.imageView.transform = CGAffineTransform(rotationAngle: 0.000001 - CGFloat(Double.pi))
            }) { (animated) in }
            break
        case .idle:
            titleLabel.text = "下拉可以刷新"
            self.setNeedsLayout()
            UIView.animate(withDuration: CMRefreshInfo.shared.animation_duration, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                [weak self] in
                self?.imageView.transform = CGAffineTransform.identity
            }) { (animated) in }
            break
        default:
            break
        }

    }
}



