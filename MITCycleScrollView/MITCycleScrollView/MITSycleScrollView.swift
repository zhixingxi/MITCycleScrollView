//
//  MITSycleScrollView.swift
//  MQLWeibo
//
//  Created by MQL-IT on 2016/11/3.
//  Copyright © 2016年 MQL-IT. All rights reserved.
//

import UIKit

protocol MITSycleScrollViewDelegate: NSObjectProtocol {
    
    func didClickBannerIndex(index: Int)
    
}

class MITSycleScrollView: UIView {
    ///代理对象
    weak var delegate: MITSycleScrollViewDelegate?
    /// 占位图
    var placeHolderImage: UIImage?
    /// 宽
    fileprivate var kWidth: CGFloat = 0
    /// 高
    fileprivate var kHeight: CGFloat = 0
    /// 滚动时间间隔
    var timeSeconds: TimeInterval = 3
    /// 定时器
    fileprivate var timer: Timer?
    /// 图片数组
    var imageArray: [String]? {
        didSet {
            setupUI()
            pages.numberOfPages = imageArray?.count ?? 0
        }
    }
    /// pageControll的颜色 
    var pageColor: UIColor = UIColor.gray {
        didSet {
            pages.pageIndicatorTintColor = pageColor
        }
    }
    var currentPageColor: UIColor = UIColor.white {
        didSet {
            pages.currentPageIndicatorTintColor = currentPageColor
        }
    }
    /// pageControll
    fileprivate lazy var pages: UIPageControl = {
        let page = UIPageControl()
        page.hidesForSinglePage = true
        return page
    }()
    ///滚动的ScrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView(frame: self.bounds)
        view.delegate = self
        view.autoresizesSubviews = true
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    /// 放图片的imageView
    fileprivate var rollImageView: UIImageView? {
        didSet {
            rollImageView?.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapBanner))
            rollImageView?.addGestureRecognizer(tap)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        kWidth = self.bounds.size.width
        kHeight = self.bounds.size.height
        addSubview(scrollView)
        addSubview(pages)
    }
    /// 定时器执行的方法
    @objc fileprivate func nextPage() {
        if self.superview == nil {
            removeTimer()
        } else {
            self.scrollView.scrollRectToVisible(CGRect(x:self.scrollView.contentOffset.x + self.kWidth, y: 0, width: self.kWidth, height: self.kHeight), animated: true)
        }
    }
    /// 点击轮播图执行的方法
    @objc private func tapBanner() {
        
        self.delegate?.didClickBannerIndex(index: (pages.currentPage + 1))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    deinit {
//        printLog(message: "我轮播图也要释放了")
//    }

}

/// 界面布局
extension MITSycleScrollView {
    fileprivate func setupUI() {
        if scrollView.subviews.count > 0 {
            for v in scrollView.subviews {
                v.removeFromSuperview()
            }
        }
        self.backgroundColor = UIColor.gray
        guard let imageArray = imageArray else { return }
        let count = imageArray.count
        //设置pageControl
        pages.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: pages, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: pages, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5))
        
        ///第一个放最后一个图片
        var urls = imageArray[count - 1]
        rollImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight))
        rollImageView?.kf.setImage(with: URL(string: urls), placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
        scrollView.addSubview(rollImageView!)
        if count > 1 {
            scrollView.contentSize = CGSize(width: (CGFloat(count) + 2) * kWidth, height: kHeight)
            scrollView.contentOffset = CGPoint(x: kWidth, y: 0)
            
            //最后一个放第一张图片
            urls = imageArray[0]
            rollImageView = UIImageView(frame: CGRect(x: (CGFloat(count) + 1) * kWidth, y: 0, width: kWidth, height: kHeight))
            rollImageView?.kf.setImage(with: URL(string: urls), placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
            scrollView.addSubview(rollImageView!)
            
            for i in 0..<count {
                urls = imageArray[i]
                rollImageView = UIImageView(frame: CGRect(x: kWidth * CGFloat(i + 1), y: 0, width: kWidth, height: kHeight))
                rollImageView?.kf.setImage(with: URL(string: urls), placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
                scrollView.addSubview(rollImageView!)
            }
        } else {
            scrollView.contentSize = CGSize(width: (CGFloat(count)) * kWidth, height: kHeight)
            scrollView.contentOffset = CGPoint(x:0, y: 0)
        }
        if timer == nil {
            addTimer()
        }
    }
    
    
    
    /// 添加定时器
    fileprivate func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeSeconds, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        
        
        
    }
    /// 移除定时器
    fileprivate func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}
//MARK: - 'UIScrollViewDelegate'
extension MITSycleScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        guard let count = imageArray?.count else {
            return
        }
        if scrollView.contentOffset.x == 0 {
            self.scrollView.contentOffset = CGPoint(x: CGFloat(count) * kWidth, y: 0)
        } else if scrollView.contentOffset.x == (CGFloat(count) + 1) *   kWidth {
            self.scrollView.contentOffset = CGPoint(x: kWidth, y: 0)
        } else {
            //修改pageControl的偏移
            let pageNum = Int(scrollView.contentOffset.x / kWidth) - 1
            pages.currentPage = pageNum
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}



