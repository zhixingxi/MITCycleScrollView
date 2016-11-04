 **MITSycleScrollView** 
1. Swift实现的无限循环网络图片轮播器;
2. 使用Kingfisher加载网络图片;
3. 支持自动轮播时间间隔,pageControl颜色等设置;
4. 支持通过代理实现图片的点击事件
- 使用示例:


> let mitView = MITSycleScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width / 2))
>         mitView.currentPageColor = UIColor.red
>         mitView.timeSeconds = 2
>         mitView.pageColor = UIColor.white
>         mitView.delegate = self
>         view.addSubview(mitView)
>         mitView.imageArray = ["http://bangimg1.dahe.cn/forum/201511/05/073002qffz5t9twjjbaz6m.jpg","http://tupian.enterdesk.com/2015/gha/09/1502/01.jpg","http://img.ithome.com/newsuploadfiles/2016/3/20160317_080446_325.jpg","http://bangimg1.dahe.cn/forum/201511/05/073002qffz5t9twjjbaz6m.jpg","http://tupian.enterdesk.com/2015/gha/09/1502/01.jpg","http://img.ithome.com/newsuploadfiles/2016/3/20160317_080446_325.jpg"]
