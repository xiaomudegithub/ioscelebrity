//
//  MeetTypeCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// 自定义布局数据源方法
protocol CustomLayoutDataSource: class {
    func numberOfCols(_ customLayout: CustomLayout) -> Int
    func numberOfRols(_ customLayout: CustomLayout) -> Int
}
// MARK: - 自定义布局
class CustomLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: CustomLayoutDataSource?
    
    fileprivate lazy var rols: Int? = {
        return self.dataSource?.numberOfRols(self)
    }()
    
    fileprivate lazy var cols: Int? = {
        return self.dataSource?.numberOfCols(self)
    }()
    
    fileprivate lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        //        let page = indexPath.item%(rols*cols) == 0 ? indexPath.item/(rols*cols) : (indexPath.item/(cols*rols) + 1)
        guard let rols = dataSource?.numberOfRols(self), let cols = dataSource?.numberOfCols(self) else {
            fatalError("请实现对应的数据源方法(行数和列数)")
        }
        let page = indexPath.item / (cols * rols)//页数
        let cellW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(cols - 1) * minimumInteritemSpacing)) / CGFloat(cols)
        let itemRow = CGFloat((indexPath.item - page*(cols*rols)) / cols)//行数
        let itemCol = CGFloat((indexPath.item - page*(cols*rols)) % cols)//列数
        let cellX = CGFloat(page) * collectionView!.bounds.width + CGFloat(itemCol) * (cellW + 10) + sectionInset.left
        let cellH: CGFloat = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - (CGFloat(rols - 1)) * minimumLineSpacing) / CGFloat(rols)
        let cellY = itemRow * (cellH + sectionInset.top) + sectionInset.top
        attribute.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
        return attribute
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        for i in 0..<itemCount {
            let attr = layoutAttributesForItem(at: IndexPath(item: i, section: 0))
            attrsArray.append(attr!)
        }
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        guard let rols = dataSource?.numberOfRols(self), let cols = dataSource?.numberOfCols(self) else {
            fatalError("请实现对应的数据源方法(行数和列数)")
        }
        let page = itemCount%(cols*rols) == 0 ? itemCount/(cols*rols) : itemCount/(cols*rols) + 1
        
        return CGSize(width: CGFloat(page) * collectionView!.bounds.width, height: 0)
    }
}


// MARK: - UICollectionViewCell
class MeetTypeItemCell: UICollectionViewCell {
    
    // 约见类型图片
    @IBOutlet weak var meetTypeImageView: UIImageView!
    
    // 约见类型Label
    @IBOutlet weak var meetTypeLabel: UILabel!
    
    // 约见类型价格Label
    @IBOutlet weak var meetTypePriceLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // 随机颜色测试
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
        
        self.backgroundColor = colorRun
    }
    
    func setMeetTypeItem() {
        meetTypeImageView.backgroundColor = UIColor.blue
        meetTypeLabel.text = "录制节目"
        meetTypePriceLabel.text = "600秒"
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
    }
}

private let KMeetTypeItemCellID = "MeetTypeItemCell"

class MeetTypeCell: UITableViewCell,CustomLayoutDataSource,UICollectionViewDataSource,UICollectionViewDelegate{

    @IBOutlet weak var meetTypeCollectionViewCell: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    let  meetTypeArryCount = 15
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupInit()
    }

    func setupInit() {
        
        self.meetTypeCollectionViewCell.dataSource = self
        self.meetTypeCollectionViewCell.delegate = self
        
        let customLayout = CustomLayout()
        customLayout.dataSource = self
        customLayout.scrollDirection = .horizontal
        
        customLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        self.meetTypeCollectionViewCell.collectionViewLayout = customLayout
        self.meetTypeCollectionViewCell.showsVerticalScrollIndicator = false
        self.meetTypeCollectionViewCell.showsHorizontalScrollIndicator = false
        self.meetTypeCollectionViewCell.isPagingEnabled = true
        
    }

    
    // MRAK: -UICollectionView  DataSource AND Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if meetTypeArryCount == 0 {
            return 1
        }
        
        // 分页
        let pageNum = (meetTypeArryCount - 1) / 8 + 1
        if meetTypeArryCount == 0 {
            pageControl.numberOfPages = 0
        } else {
            pageControl.numberOfPages = pageNum
        }
        
        return meetTypeArryCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if meetTypeArryCount == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMeetTypeItemCellID, for: indexPath) as! MeetTypeItemCell
            return cell
        }
        let meetTypeItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: KMeetTypeItemCellID, for: indexPath) as! MeetTypeItemCell
        meetTypeItemCell.setMeetTypeItem()
        
        return meetTypeItemCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let view = super.hitTest(point, with: event)
        
        if view == self.meetTypeCollectionViewCell {
            
            return self.meetTypeCollectionViewCell
        }
        return view
    }
    
    
    
    // CustomLayoutDataSource
    func numberOfCols(_ customLayout: CustomLayout) -> Int {
        return 4
    }
    func numberOfRols(_ customLayout: CustomLayout) -> Int {
        return 2
    }
    

}
