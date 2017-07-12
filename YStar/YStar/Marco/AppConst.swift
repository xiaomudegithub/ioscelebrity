//
//  AppConfig.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit

typealias CompleteBlock = (AnyObject?) ->()?
typealias ErrorBlock = (NSError) ->()?
typealias paramBlock = (AnyObject?) ->()?
//MARK: --正则表达
func isTelNumber(num: String)->Bool
{
    let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^1[3|4|5|7|8][0-9]\\d{8}$")
    return predicate.evaluate(with: num)
}


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
// 密码校验
func isPassWord(pwd: String) ->Bool {
    let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "(^[A-Za-z0-9]{6,20}$)")
    return predicate.evaluate(with: pwd)
}

class AppConst {
    
    static let pwdKey = "yd1742653sd"
    
    enum KVOKey: String {
        case selectProduct = "selectProduct"
        case allProduct = "allProduct"
        case currentUserId = "currentUserId"
        case balance = "balance"
    }
    
    enum NoticeKey: String {
        case logoutNotice = "LogoutNotice"
        case updateSoftware = "updateSoftware"
    }
    
    class Network {
        #if true //是否是开发环境
        static let TcpServerIP:String = "139.224.34.22";
        static let TcpServerPort:UInt16 = 16060
        static let TttpHostUrl:String = "http://139.224.34.22";
        #else
        static let TcpServerIP:String = "i.flight.dlgrme.com";
        static let TcpServerPort:UInt16 = 16205;
        static let HttpHostUrl:String = "http://i.flight.dlgrme.com";
        #endif
        static let TimeoutSec:UInt16 = 10
        static let qiniuHost = "http://ofr5nvpm7.bkt.clouddn.com/"
    }


    enum Action:UInt {
        case callPhone = 10001
        case handleOrder = 11001
    }
    
    enum BundleInfo:String {
        case CFBundleDisplayName = "CFBundleDisplayName"
        case CFBundleShortVersionString = "CFBundleShortVersionString"
        case CFBundleVersion = "CFBundleVersion"
    }
    
    enum ColorKey: UInt32 {
        case main = 0x8c0808
        case bgColor = 0xfafafa
        case label6 = 0x666666
        case label3 = 0x333333
        case label9 = 0x999999
        case closeColor = 0xFFFFFF
    }
    
    enum iconFontName: String {
        case backItem = "\u{e61a}"
        case closeIcon = "\u{e62b}"
        case newsIcon = "\u{e629}"
        case userPlaceHolder = "\u{e60d}"
        case thumpUpIcon = "\u{e624}"
        case newsPlaceHolder = "\u{e603}"
    }
    
    enum UserDefaultKey: String {
        case uid = "uid"
        case phone = "phone"
        case token = "token"
    }
  
}
