//
//  QuestionsManagerVC.swift
//  YStar
//
//  Created by mu on 2017/8/28.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class QuestionsManagerVC: BaseTableViewController {

    
    @IBOutlet weak var titlesView: UIView!
    
    @IBOutlet weak var meetTypeButton: UIButton!
    
    @IBOutlet weak var meetOrderButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var selectedButton: UIButton?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        
        self.tableView.isScrollEnabled = false
        
        // 默认第一个[meetTypeButton]
        titleViewButtonAction(meetTypeButton)
        
    }
    
    func setupUI() {
        
        var scrollViewFrame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - titlesView.height - 64)
        scrollView.frame = scrollViewFrame
        scrollView.contentSize = CGSize.init(width: kScreenWidth * 2, height: scrollView.height)
        
        if let voiceVC = storyboard?.instantiateViewController(withIdentifier: VoiceManagerVC.className()) as? VoiceManagerVC{
            voiceVC.view.frame = scrollViewFrame
            voiceVC.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
            scrollView.addSubview(voiceVC.view)
            self.addChildViewController(voiceVC)
        }
        if let videoVC = storyboard?.instantiateViewController(withIdentifier: VideoManagerVC.className()) as? VideoManagerVC{
            scrollViewFrame.origin.x = kScreenWidth
            videoVC.view.frame = scrollViewFrame
            videoVC.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
            scrollView.addSubview(videoVC.view)
            self.addChildViewController(videoVC)
        }
    }
    
    
    @IBAction func titleViewButtonAction(_ sender: UIButton) {
        
        self.selectedButton?.isSelected = false
        
        self.selectedButton?.backgroundColor = UIColor.clear
        sender.backgroundColor = UIColor.init(rgbHex: 0xECECEC)
        
        self.selectedButton = sender
        
        let pointSizeOffset = CGPoint.init(x: kScreenWidth * CGFloat(sender.tag - 10), y: 0)
        scrollView.setContentOffset(pointSizeOffset, animated: true)
        scrollView.isPagingEnabled = true
        
    }
    
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == scrollView {
            
            let tag  = 10 + scrollView.contentOffset.x / kScreenWidth
            
            if let button = view.viewWithTag(Int(tag)) as? UIButton {
                titleViewButtonAction(button)
            }
        }
    }

}
