# CMKRefresh
Swift实现轻量级的下拉刷新上拉加载更多组件，简单易用，支持UIScrollView、UITableView、UICollectionView、UIWebView，支持自定义加载动画

####  安装
pod 'CMKRefresh'
#### 使用方法
1  默认下拉刷新

```swift
mutable.addHeaderRefresh { [weak self] in
    self?.mutable.reloadData()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
    self?.mutable.stopHeaderRefresh()
}

}
```

//开始刷新
```swift
mutable.startHeaderRefresh()
```

2  默认加载更多

```swift
//默认自带效果
mutable.addHeaderRefresh { [weak self] in
    self?.mutable.reloadData()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
    self?.mutable.stopHeaderRefresh()
}
}
```
3 自定义动画加载更多
```swift
mutable.addFooterRefresh(custom:CMRefreshFMAnimationFooter()) { [weak self] in
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        self?.mutable.stopFooterRefresh(noMore: true)
        self?.count = 40
        self?.mutable.reloadData()
    }
}
```

#### Communication

Email : tungleungs@gmail.com
公众号 :iostips
QQ  : 603482184
