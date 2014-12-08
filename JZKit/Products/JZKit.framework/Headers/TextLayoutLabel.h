


#import<Foundation/Foundation.h>
#import<UIKit/UIKit.h>

@interface TextLayoutLabel : UILabel
{
    NSInteger  mSpace;
    BOOL       mBoldText;
@private
    CGFloat characterSpacing_;       //字间距
    long linesSpacing_;              //行间距
    long paragraphSpacing_;          //段间距
}

@property (nonatomic, readwrite) NSInteger space;
@property (nonatomic) BOOL       boldText;
@property(nonatomic,assign) CGFloat characterSpacing;
@property(nonatomic,assign) long linesSpacing;
@property(nonatomic,assign) long paragraphSpacing;

+(CGFloat)getStringHei:(NSString *)str font:(UIFont *)font frame:(CGRect)frame linespace:(NSInteger)lineA paragraphspace:(NSInteger)paragA;

@end
