
NS_ASSUME_NONNULL_BEGIN

@interface EventOneTypeViewController : UIViewController
+ (instancetype)pushFromVC:(UIViewController *)rootVC requestParams:(id )requestParams success:(DataBlock)block;
@end

NS_ASSUME_NONNULL_END
