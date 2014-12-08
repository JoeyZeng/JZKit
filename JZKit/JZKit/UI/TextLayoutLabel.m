#import "TextLayoutLabel.h"
#import<CoreText/CoreText.h>

#define kLinesSpacing                        5.0f
#define kParagraphSpacing                    13.0f

@implementation TextLayoutLabel
@synthesize space = mSpace;
@synthesize boldText = mBoldText;
@synthesize characterSpacing = characterSpacing_;
@synthesize linesSpacing = linesSpacing_;
@synthesize paragraphSpacing = paragraphSpacing_;

-(id)initWithFrame:(CGRect)frame
{//初始化字间距、行间距
    if(self =[super initWithFrame:frame])
    {
        self.characterSpacing = 1.0f;
        self.linesSpacing = kLinesSpacing;
        self.paragraphSpacing = kParagraphSpacing;
        self.boldText = NO;
    }
    return self;
}

-(void)setCharacterSpacing:(CGFloat)characterSpacing //外部调用设置字间距
{
    characterSpacing_ = characterSpacing;
    [self setNeedsDisplay];
}

-(void)setLinesSpacing:(long)linesSpacing  //外部调用设置行间距
{
    linesSpacing_ = linesSpacing;
    [self setNeedsDisplay];
}

-(void)setParagraphSpacing:(long)paragraphSpacing  //外部调用设置段间距
{
    paragraphSpacing_ = paragraphSpacing;
    [self setNeedsDisplay];
}

-(void)drawTextInRect:(CGRect)requestedRect
{
    if(!self.text)
        return;
        
    //创建AttributeString
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc]initWithString:self.text];
    //设置字体及大小
    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);    
    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[string length])];
    
//    if(self.characterSpacing)
//    {
//        long number = self.characterSpacing;
//        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
//        CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
//        
//        [string addAttribute:(id)kCTKernAttributeName value:(id)num range:NSMakeRange(0, [string length])];
//        
//        CFRelease(num);
//    }
     
    //设置字体颜色
    [string addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0,[string length])];
    
    if(!mBoldText)
    {
        //让字变细
        CGFloat widthValue = -1.3;
        CFNumberRef strokeWidth = CFNumberCreate(NULL,kCFNumberFloatType,&widthValue);
        
        [string addAttribute:(NSString*)(kCTStrokeWidthAttributeName) value:(__bridge id)strokeWidth range:NSMakeRange(0,[string length])];
        
        [string addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor whiteColor]CGColor] range:NSMakeRange(0,[string length])];
        
//        [string addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor whiteColor]CGColor] range:NSMakeRange(0,[string length])];
    }
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTLeftTextAlignment;
    if(self.textAlignment == NSTextAlignmentCenter)
    {
        alignment = kCTCenterTextAlignment;
    }
    if(self.textAlignment == NSTextAlignmentRight)
    {
        alignment = kCTRightTextAlignment;
    }
    
    alignment = kCTJustifiedTextAlignment;
    
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    
    CGFloat   headSpace = self.font.pointSize * 2;//38;   //此处应该用两个字符根据字体的大小来算出宽度，
    CTParagraphStyleSetting linehead;
    linehead.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    linehead.valueSize = sizeof(headSpace);
    linehead.value = &headSpace;
    
    //设置文本行间距
    CGFloat lineSpace = self.linesSpacing;
    CTParagraphStyleSetting lineSpaceStyle;
    
    //ios4.3以上系统才支持kCTParagraphStyleSpecifierLineSpacingAdjustment，并且
    //kCTParagraphStyleSpecifierLineSpacing不推荐使用
    float version = [[[UIDevice currentDevice] systemVersion] floatValue]; 
    if (version >= 4.299)   //ios 4.3以上
    { 
        lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;      
    }
    else 
    {
        lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacing;
    }
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value =&lineSpace;
    
    //设置文本段间距
    CGFloat paragraphSpacing = self.paragraphSpacing;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(CGFloat);
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    //创建设置数组
    CTParagraphStyleSetting settings[] ={alignmentStyle,linehead, lineSpaceStyle, paragraphSpaceStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings , sizeof(settings)/sizeof(CTParagraphStyleSetting));
    
    //给文本添加设置
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [string length])];
    
    //排版
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
        
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(mSpace , 0 ,self.bounds.size.width - mSpace*2, self.bounds.size.height));
    
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    
    //翻转坐标系统（文本原来是倒的要翻转下）
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    CGContextScaleCTM(context, 1.0 ,-1.0);
    //画出文本
    CTFrameDraw(leftFrame,context);
    //释放
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    CFRelease(helveticaBold);
    UIGraphicsPushContext(context);
    
}


+(CGFloat)getStringHei:(NSString *)str font:(UIFont *)font frame:(CGRect)frame linespace:(NSInteger)lineA paragraphspace:(NSInteger)paragA
{
    if(!str)
        return 0;
    
    TextLayoutLabel *tempLab = [[TextLayoutLabel alloc] initWithFrame:frame];
    
    tempLab.font = font;
    tempLab.textAlignment = NSTextAlignmentLeft;
    tempLab.numberOfLines = 0;
    tempLab.lineBreakMode = NSLineBreakByCharWrapping;
    
    //创建AttributeString
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc]initWithString:str];
    //设置字体及大小
    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)font.fontName,font.pointSize,NULL);
    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[string length])];
    
    //让字变细
    CGFloat widthValue = -1.3;
    
    CFNumberRef strokeWidth = CFNumberCreate(NULL,kCFNumberFloatType,&widthValue);
    
    [string addAttribute:(NSString*)(kCTStrokeWidthAttributeName) value:(__bridge id)strokeWidth range:NSMakeRange(0,[string length])];
    
    [string addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor whiteColor]CGColor] range:NSMakeRange(0,[string length])];
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTLeftTextAlignment;
    if(tempLab.textAlignment == NSTextAlignmentCenter)
    {
        alignment = kCTCenterTextAlignment;
    }
    if(tempLab.textAlignment == NSTextAlignmentRight)
    {
        alignment = kCTRightTextAlignment;
    }
    
    alignment = kCTJustifiedTextAlignment;
    
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    
    CGFloat   headSpace = font.pointSize * 2;   //此处应该用两个字符根据字体的大小来算出宽度，
    CTParagraphStyleSetting linehead;
    linehead.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    linehead.valueSize = sizeof(headSpace);
    linehead.value = &headSpace;
    
    //设置文本行间距
    CGFloat lineSpace = lineA;
    CTParagraphStyleSetting lineSpaceStyle;
    
    //ios4.3以上系统才支持kCTParagraphStyleSpecifierLineSpacingAdjustment，并且
    //kCTParagraphStyleSpecifierLineSpacing不推荐使用
    float version = [[[UIDevice currentDevice] systemVersion] floatValue]; 
    if (version >= 4.299)   //ios 4.3以上
    { 
        lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;      
    }
    else 
    {
        lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacing;
    }
    
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value =&lineSpace;
    
    //设置文本段间距
    CGFloat paragraphSpacing = paragA;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(CGFloat);
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    //创建设置数组
    CTParagraphStyleSetting settings[] ={alignmentStyle, linehead, lineSpaceStyle, paragraphSpaceStyle};

    CTParagraphStyleRef style = CTParagraphStyleCreate(settings , sizeof(settings)/sizeof(CTParagraphStyleSetting));
    
    //给文本添加设置
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [string length])];
    
    //排版
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(10 , 0 ,tempLab.bounds.size.width, tempLab.bounds.size.height));
    
	CFMutableAttributedStringRef attrString = (__bridge CFMutableAttributedStringRef)string;

	CFRange fitRange = CFRangeMake(0,0);
	CGSize aSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, CFStringGetLength((CFStringRef)attrString)), NULL, tempLab.bounds.size, &fitRange);
        
    //释放
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    CFRelease(helveticaBold);
    
    return aSize.height;
}

@end