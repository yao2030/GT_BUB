//
//  ChatDatas.h
//  gt
//
//  Created by cookie on 2018/12/31.
//  Copyright © 2018 GT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatMessageLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatDatas : NSObject

/**
 获取单聊的初始会话
 
 @param sessionId 传入会话id
 @return 返回会话对象数组
 */
+(NSMutableArray *)LoadingMessagesStartWithChat:(NSString *)sessionId;




/**
 获取群聊的初始会话
 
 @param sessionId 传入会话id
 @return 返回会话对象数组
 */
+(NSMutableArray *)LoadingMessagesStartWithGroupChat:(NSString *)sessionId;



/**
 处理消息数组 一般进入聊天界面会初始化之前的消息展示
 
 @param messages 消息数组
 @return 返回消息模型布局后的数组
 */
+(NSMutableArray *)receiveMessages:(NSArray *)messages;




/**
 接收一条消息
 
 @param dic 消息内容
 @return 消息模型布局
 */
+(ChatMessageLayout *)receiveMessage:(NSDictionary *)dic;


/**
 消息内容生成消息布局模型
 这个接口可以直接将消息内容替换为环信、融云、网易云信生成的消息模型。
 将第三方消息直接转换成本地消息模型后可以统一生成布局。这里因为要处理demo模拟数据，
 全部用键值对来处理了。
 
 @param dic 消息内容
 @return 消息布局模型  <SSChatMessagelLayout>
 */
+(ChatMessageLayout *)getMessageWithDic:(NSDictionary *)dic;




/**
 发送消息回调
 
 @param layout 消息
 @param error 发送是否成功
 @param progress 发送进度
 */
typedef void (^MessageBlock)(ChatMessageLayout *layout, NSError *error, NSProgress *progress);


/**
 发送一条消息
 
 @param dict 消息主体
 @param sessionId 会话id
 @param messageType 消息类型
 @param messageBlock 发送消息回调
 */
+(void)sendMessage:(NSDictionary *)dict sessionId:(NSString *)sessionId messageType:(ChatMessageType)messageType messageBlock:(MessageBlock)messageBlock;

@end

NS_ASSUME_NONNULL_END
