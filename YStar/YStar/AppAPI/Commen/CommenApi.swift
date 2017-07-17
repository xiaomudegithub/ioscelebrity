//
//  CommenApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol CommenApi {
    // 登录(模型)
    func login(model: LoginRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    // 用户信息(模型)
    func userinfo(model: LoginModle, complete: CompleteBlock?, error: ErrorBlock?)
    // 获取短信验证码(模型)
    func sendVerificationCode(model:SendVerificationCodeRequestModel,complete : CompleteBlock? ,error: ErrorBlock?)
    // 是否绑定银行卡(模型)
    func bankCardList(model:BankCardListRequestModel,complete : CompleteBlock? ,error: ErrorBlock?)
    // 获取银行卡信息(模型)
    func bankCardInfo(model:BankCardInfoRequestModel,complete : CompleteBlock? ,error: ErrorBlock?)
    // 绑定银行卡(模型)
    func bindCard(model:BindCardRequestModel,complete :CompleteBlock?,error:ErrorBlock?)
    // 校验用户登录(模型)
    func CheckRegister(model: CheckRegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    // 发送验证码(模型)
    func SendVerificationCode(model: SendVerificationCodeRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    // 重置密码(模型)
    func Resetpwd(model: ResetPwdReqModel, complete: CompleteBlock?, error: ErrorBlock?)
    // 获取朋友圈
    func requestCircleList(requestModel:CircleListRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    // 评论朋友圈
    func commentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?)
    // 点赞朋友圈
    func approveCircle(requestModel:ApproveCircleModel,complete: CompleteBlock?, error: ErrorBlock?)
    // 发布朋友圈
    func sendCircle(requestModel:SendCircleRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    // 删除朋友圈
    func deleteCircle(requestModel:DeleteCircle, complete: CompleteBlock?, error: ErrorBlock?)
    // 明星评论朋友圈
    func starCommentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?)
    // 信息收益列表(模型)
    func requestEarningInfo(model:EarningRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    // 获取昨收今开(模型)
    func requestYesterdayAndTodayPrice(model:YesterdayAndTodayPriceRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
}
