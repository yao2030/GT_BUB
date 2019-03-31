//
//  NSString+YBCodec.m
//  Aa
//
//  Created by Aalto on 2018/11/20.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "NSString+Extras.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extras)
//ios oc 判断输入的数是否是另一个的整数倍
+(BOOL)judgeIsDoubleStr:(NSString *)str1 with:(NSString *)str2
{
    int str1Int=[str1 intValue];
    
    double str2Double=[str2 doubleValue];
    int str2Int=[str2 intValue];
    
    if (str2Double/str1Int-str2Int/str1Int  > 0) {
        return NO;
    }
    return YES;
}
/*
 分开来注释一下：
 ^ 匹配一行的开头位置
 (?![0-9]+$) 预测该位置后面不全是数字
 (?![a-zA-Z]+$) 预测该位置后面不全是字母
 [0-9A-Za-z] {8,16} 由8-16位数字或这字母组成
 $ 匹配行结尾位置
 
 注：(?!xxxx) 是正则表达式的负向零宽断言一种形式，标识预该位置后不是xxxx字符。
 https:blog.csdn.net/w6524587/article/details/56279494
密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)：
 ^[a-zA-Z]\w{5,17}$
强密码(必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间)：
 ^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$

 */
+(BOOL)isContainAllCharType:(NSString*)originString{
    NSString * regex = @"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{4,16}$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

//    NSString * regexLower = @"[a-z]+$";
//
//    NSPredicate *predLower = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexLower];
//
//    NSString * regexNumber = @"[^0-9]+$";
//
//    NSPredicate *predNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexNumber];
    
    BOOL isMatch = ([pred evaluateWithObject:originString]
                    );//&&[predLower evaluateWithObject:originString]
//    &&![predNumber evaluateWithObject:originString]
    return isMatch;
    
//    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z0-9]*" options:NSRegularExpressionCaseInsensitive error:nil];
//    NSInteger count = [numberRegular numberOfMatchesInString:originString options:NSMatchingReportProgress range:NSMakeRange(0, originString.length)];//count是str中包含[A-Za-z0-9]数字的个数，只要count>0，说明str中包含数字
//    if (count > 0) {
//        return YES;
//
//    }
//    return NO;
    

    
}
+(InputCharType)getInputCharType:(NSString*)originString{
    if ([NSString isEmpty:originString]) {
        return InputCharNone;
    }
    NSString *testString = originString;
    
    InputCharType charType = InputCharNone;
    
//    NSPredicate *predAll = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[A-Za-z0-9]+$"];
//
//    BOOL isMatchAll = [predAll evaluateWithObject:testString];
    
    NSPredicate *predUpper = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![A-Z]+$)[0-9A-Za-z]{8,16}$"];
    
    BOOL isMatchUpper = [predUpper evaluateWithObject:testString];
    //不全是大写
    NSPredicate *predLower = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![a-z]+$)[0-9A-Za-z]{8,16}$"];
    
    BOOL isMatchLower = [predLower evaluateWithObject:testString];
    //不全是小写
    
//    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
//    NSInteger count = [numberRegular numberOfMatchesInString:testString options:NSMatchingReportProgress range:NSMakeRange(0, testString.length)];
//
//    BOOL isMatchNumber = count > 0?YES:NO;
    NSPredicate *predNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)[0-9A-Za-z]{8,16}$"];

    BOOL isMatchNumber = [predNumber evaluateWithObject:testString];
    //不全是数字
    
    
        if(isMatchLower
           &&isMatchNumber){
            NSLog(@"字符串中缺大写英文字母");
            charType = InputCharLoseUpperEnglish;
            
        }else if(isMatchUpper
                 &&isMatchNumber){
            NSLog(@"字符串中缺小写英文字母");
            charType = InputCharLoseLowerEnglish;
        }else if(isMatchUpper
                 &&isMatchLower){
            NSLog(@"字符串中缺有数字");
            charType = InputCharLoseNumber;
        }
        else if(!isMatchUpper){
            
            NSLog(@"字符串中只含有大写英文字母");
            charType = InputCharOnlyUpperEnglish;
        }else if(!isMatchLower){
            
            NSLog(@"字符串中只含有小写英文字母");
            charType = InputCharOnlyLowerEnglish;
        }else if(!isMatchNumber){

            NSLog(@"字符串中只含有数字");
            charType = InputCharOnlyNumber;
        }
    
    return charType;
}

+(NSString*)getPaywayAppendingString:(NSString*)payString{
    NSMutableArray *pays = [NSMutableArray arrayWithCapacity:3];
    
    NSArray  *paymentways = [NSArray array];
    if ([payString containsString:@","]) {
        paymentways = [payString componentsSeparatedByString:@","];
    }else{
        paymentways = @[payString];
    }
    
    for (NSString * data in paymentways) {
        PaywayType type = [data intValue];
        switch (type) {
            case PaywayTypeWX:
            {
                [pays addObject:@"微信"];
            }
                break;
                
            case PaywayTypeZFB:
            {
                [pays addObject:@"支付宝"];
            }
                break;
                
            case PaywayTypeCard:
            {
                [pays addObject:@"银行卡"];
            }
                break;
            default:
                break;
        }
        
        
    }
    NSString *string = [[pays mutableCopy] componentsJoinedByString:@"、"];
    return string;
}
- (NSString *)yb_encodingUTF8 {
    NSString *result = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self, NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
    return result;
}

- (NSString *)yb_MD5 {
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    
    NSString *finalStr = [ret lowercaseString];
    return finalStr;
}

- (BOOL)match:(NSString *)express {
    return [self isMatchedByRegex:express];
}

+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}


+(BOOL)isHaveWhiteSpace:(NSString *)text
{
    NSRange _range = [text rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return true;
    }else {
        
        //没有空格
        return false;
    }
//    return false;
}

+(NSString* )getTimeString:(NSString *)timeStampString{
    // timeStampString 是服务器返回的13位时间戳
    // iOS 生成的时间戳是10位
    
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+(BOOL)isEmpty:(NSString *)text
{
    if ([[NSString isValueNSStringWith:text] isEqualToString:@""] ||
        [NSString isValueNSStringWith:text] == nil)
    {
        return true;
    }
    return false;
}

+(id)isValueNSStringWith:(NSString *)str{
    NSString *resultStr = nil;
    str =[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str isEqual:[NSNull null]]
        ||[NSString stringWithFormat:@"%@",str]==nil
        ||[NSString stringWithFormat:@"%@",str].length==0
        ||[[NSString stringWithFormat:@"%@",str] isEqual:@"(null)"]
        ||[[NSString stringWithFormat:@"%@",str] isEqual:@"*null*"]
        ||[[NSString stringWithFormat:@"%@",str] isEqual:@"null"]
        ||[str stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0
        ) {
        resultStr = @"";
    }else{
        resultStr = [NSString stringWithFormat:@"%@",str];
    }
    return resultStr;
}
+(BOOL)getLNDataSuccessed:(NSDictionary *)dic
{
    if ([NSObject isNSDictionaryClass:dic]) {
        int successed = [dic intForKey:@"code"];
        if (successed == 200) {
            return YES;
        } else {
            return NO;
        }
    } else {
        //        (@"后台返回数据有错误：%s",dic.description.UTF8String);
        return NO;
    }
}
+(BOOL)getDataSuccessed:(NSDictionary *)dic
{
    if ([NSObject isNSDictionaryClass:dic]) {
        int successed = [dic intForKey:@"errcode"];
        if (successed == 1) {
            return YES;
        } else {
            return NO;
        }
    } else {
//        (@"后台返回数据有错误：%s",dic.description.UTF8String);
        return NO;
    }
}

+ (NSString*)fliterLeadingZeroInString:(NSString*)originString{
    if (originString.length>0) {
        NSMutableArray* carries = [NSMutableArray array];
        for (int i=0; i<originString.length; i++) {
            char s = [originString characterAtIndex:i];
            if(s == '0'){
                NSString *tempString = [NSString stringWithUTF8String:&s];
                [carries addObject:tempString];
            }
        }
        
    }
    return NO;
}

+ (BOOL)isAllZeroInString:(NSString*)originString{
    if (originString.length>0) {
        NSMutableArray* carries = [NSMutableArray array];
        for (int i=0; i<originString.length; i++) {
            char s = [originString characterAtIndex:i];
            if(s == '0'){
                NSString *tempString = [NSString stringWithUTF8String:&s];
                [carries addObject:tempString];
            }
        }
        if (carries.count == originString.length) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}
+ (NSString*)getAnonymousString:(NSString* )originString{
    if (originString.length<2) {
        return originString;
    }
    NSMutableArray* carries = [NSMutableArray array];
    for (int i=1; i<originString.length-1; i++) {
        char s = [originString characterAtIndex:i];
        s = '*';
        NSString *tempString = [NSString stringWithUTF8String:&s];
        [carries addObject:tempString];
    }
    NSString *string = [carries componentsJoinedByString:@""];
    
    NSString *anonymousString = [originString stringByReplacingCharactersInRange:NSMakeRange(1, originString.length-2) withString:string];
    return anonymousString;
    
}
#pragma mark -将秒数转换为字符串格式
+ (NSString *)timeWithSecond:(NSInteger)second{
    NSString *time;
    if (second < 60) {
        time = [NSString stringWithFormat:@"00:%02ld",(long)second];//00:00:%02ld
    }
    else {
        if (second < 3600) {
            time = [NSString stringWithFormat:@"%02ld:%02ld",second/60,second%60];//00:%02ld:%02ld
        }
        else {
            time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",second/3600,(second-second/3600*3600)/60,second%60];
        }
    }
    return time;
}
// 截取字符串方法封装// 截取字符串方法封装
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString{
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
}
#pragma mark -绘制AttributeString与NSTextAttachment不同大小颜色
+ (NSMutableAttributedString *)attributedReverseStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont numInSubColor:(UIColor*)numInSubColor numInSubFont:(UIFont*)numInSubFont
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\.?\\d*)" options:0 error:NULL];//)个
    
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:subString options:0 range:NSMakeRange(0, [subString length])];
    
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
    
    NSMutableAttributedString *subAttributedStr = [[NSMutableAttributedString alloc] initWithString:subString attributes:subAttributes];
    
    for (int i = 0; i < ranges.count; i++) {
        [subAttributedStr setAttributes:@{NSForegroundColorAttributeName : numInSubColor,NSFontAttributeName:numInSubFont} range:ranges[i].range];
    }
    
    [subAttributedStr appendAttributedString:attributedStr];
    
    
    return subAttributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont numInSubColor:(UIColor*)numInSubColor numInSubFont:(UIFont*)numInSubFont
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\.?\\d*)" options:0 error:NULL];//)个
    
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:subString options:0 range:NSMakeRange(0, [subString length])];
    
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
    
    NSMutableAttributedString *subAttributedStr = [[NSMutableAttributedString alloc] initWithString:subString attributes:subAttributes];
    
    for (int i = 0; i < ranges.count; i++) {
        [subAttributedStr setAttributes:@{NSForegroundColorAttributeName : numInSubColor,NSFontAttributeName:numInSubFont} range:ranges[i].range];
    }
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSMutableAttributedString *subAttributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", subString]];
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
    [subAttributedStr setAttributes:subAttributes range:NSMakeRange(0,subAttributedStr.length)];
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont subStringUnderlineColor:(UIColor*)underlineColor
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSMutableAttributedString *subAttributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", subString]];
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor,NSUnderlineStyleAttributeName:@1,NSUnderlineColorAttributeName:underlineColor};
    [subAttributedStr setAttributes:subAttributes range:NSMakeRange(0,subAttributedStr.length)];
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ ", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSTextAttachment *attachment=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image=image;
    attachment.bounds=CGRectMake(0,-8 , image.size.width, image.size.height);
    NSAttributedString *imageStr=[NSAttributedString attributedStringWithAttachment:attachment];
    
    
    
    [attributedStr insertAttributedString:imageStr atIndex:0];
    
    
    return attributedStr;
}
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image isImgPositionOnlyLeft:(BOOL)isOnlyLeft
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@  ", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSTextAttachment *attachment=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image=image;
    attachment.bounds=CGRectMake(0,-8 , image.size.width, image.size.height);
    NSAttributedString *imageStr=[NSAttributedString attributedStringWithAttachment:attachment];
    
    NSTextAttachment *attachment0=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image0 = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUpMirrored];
    attachment0.image=isOnlyLeft?image:image0;
    attachment0.bounds=CGRectMake(0,isOnlyLeft?-2:3, image.size.width, image.size.height);
    NSAttributedString *imageStr0=[NSAttributedString attributedStringWithAttachment:attachment0];
    
    [attributedStr insertAttributedString:imageStr0 atIndex:0];
    
    if(!isOnlyLeft)[attributedStr insertAttributedString:imageStr atIndex:attributedStr.length];
    
    return attributedStr;
}
#pragma mark -限宽计算AttributeString与String的高度
+ (CGFloat)getAttributeContentHeightWithAttributeString:(NSAttributedString*)atributedString withFontSize:(float)fontSize boundingRectWithWidth:(CGFloat)width{
    float height = 0;
    CGSize lableSize = CGSizeZero;
//    if(IS_IOS7)
    if ([atributedString respondsToSelector:@selector(boundingRectWithSize:options:context:)]){
        CGSize sizeTemp = [atributedString boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                                        options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           
                                                        context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    height = lableSize.height;
    return height;
}

+ (CGFloat)getContentHeightWithParagraphStyleLineSpacing:(CGFloat)lineSpacing fontWithString:(NSString*)fontWithString fontOfSize:(CGFloat)fontOfSize boundingRectWithWidth:(CGFloat)width {
    float height = 0;
    CGSize lableSize = CGSizeZero;
//    if(IS_IOS7)
    if([fontWithString respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = lineSpacing;
        CGSize sizeTemp = [fontWithString boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                                       options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes: @{NSFontAttributeName:
                                                                      [UIFont systemFontOfSize:fontOfSize],
                                                                  NSParagraphStyleAttributeName:
                                                                      paragraphStyle}
                                                       context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    
    height = lableSize.height;
    return height;
}

#pragma mark -限高计算AttributeString与String的宽度
+(CGFloat)getTextWidth:(NSString *)string withFontSize:(UIFont *)font withHeight:(CGFloat)height
{
    float width = 0;
    CGSize lableSize = CGSizeZero;
    if([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName];
        CGSize sizeTemp = [string boundingRectWithSize: CGSizeMake(MAXFLOAT, height)
                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes: stringAttributes
                                               context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    width = lableSize.width;
    return width;
}

#pragma mark -限宽计算AttributeString与String的宽度
+(CGFloat)calculateTextWidth:(NSString *)string withFontSize:(float)fontSize withWidth:(float)width
{
    float resultWidth = 0;
    CGSize lableSize = CGSizeZero;
    if([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey: NSFontAttributeName];
        CGSize sizeTemp = [string boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes: stringAttributes
                                               context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    resultWidth = lableSize.width;
    return resultWidth;
}

+(CGFloat)calculateAttributeTextWidth:(NSAttributedString *)atributedString withFontSize:(float)fontSize withWidth:(float)width
{
    float resultWidth = 0;
    CGSize lableSize = CGSizeZero;
    if([atributedString respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        
        //        [atributedString setAttributes:@{ NSFontAttributeName:kFontSize(fontSize)} range:NSMakeRange(0,atributedString.length)];
        
        CGSize sizeTemp = [atributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                        context:nil].size;
        
        
        
        //                           boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
        //                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        //                                            attributes: stringAttributes
        //                                               context: nil].size;//string
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    resultWidth = lableSize.width;
    return resultWidth;
}
// 字典转json字符串方法//==[dic mj_JSONString]
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
                returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                returnValue =YES;
            }
            
        }
    }];
    return returnValue;
}
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++){
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
//去除表情
+ (NSString *)disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}
@end
