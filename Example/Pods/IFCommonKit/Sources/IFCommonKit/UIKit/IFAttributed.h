//
//  IFAttributed.h
//  IFCommonKit
//
//  Created by MrGLZh on 2022/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFAttributed : NSObject
/*!默认为黑色*/
@property (nonatomic, strong) UIColor *normalColor;
/*!默认17号*/
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, copy) NSArray<NSValue*>* subRangs;
@property (nonatomic, copy) NSArray<UIColor*>* subColors;
@property (nonatomic, copy) NSArray<UIFont*>* subFonts;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, copy) NSString *text;

+ (instancetype)attributed;

@end

NS_ASSUME_NONNULL_END
