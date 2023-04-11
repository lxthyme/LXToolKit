//
//  LXCalcTextSize.h
//  Pods
//
//  Created by LXThyme Jason on 2021/2/26.
//

#ifndef LXCalcTextSize_h
#define LXCalcTextSize_h


//CGSize xl_calcTextSize(CGSize fitsSize,
//                    id text,
//                    NSInteger numberOfLines,
//                    UIFont *font,
//                    NSTextAlignment textAlignment,
//                    NSLineBreakMode lineBreakMode,
//                    CGFloat minimumScaleFactor,
//                    CGSize shadowOffset) {
//
//    if (text == nil || [text length] <= 0) {
//        return CGSizeZero;
//    }
//
//    NSAttributedString *calcAttributedString = nil;
//
//    //如果不指定字体则用默认的字体。
//    if (font == nil) {
//        font = [UIFont systemFontOfSize:17];
//    }
//
//    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
//
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.alignment = textAlignment;
//    paragraphStyle.lineBreakMode = lineBreakMode;
//    //系统大于等于11才设置行断字策略。
//    if (systemVersion >= 11.0) {
//        @try {
//            [paragraphStyle setValue:@(1) forKey:@"lineBreakStrategy"];
//        } @catch (NSException *exception) {}
//    }
//
//    if ([text isKindOfClass:NSString.class]) {
//        calcAttributedString = [[NSAttributedString alloc] initWithString:(NSString *)text attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
//    } else {
//        NSAttributedString *originAttributedString = (NSAttributedString *)text;
//        //对于属性字符串总是加上默认的字体和段落信息。
//        NSMutableAttributedString *mutableCalcAttributedString = [[NSMutableAttributedString alloc] initWithString:originAttributedString.string attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
//
//        //再附加上原来的属性。
//        [originAttributedString enumerateAttributesInRange:NSMakeRange(0, originAttributedString.string.length) options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
//            [mutableCalcAttributedString addAttributes:attrs range:range];
//        }];
//
//        //这里再次取段落信息，因为有可能属性字符串中就已经包含了段落信息。
//        if (systemVersion >= 11.0) {
//            NSParagraphStyle *alternativeParagraphStyle = [mutableCalcAttributedString attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:NULL];
//            if (alternativeParagraphStyle != nil) {
//                paragraphStyle = (NSMutableParagraphStyle*)alternativeParagraphStyle;
//            }
//        }
//
//        calcAttributedString = mutableCalcAttributedString;
//    }
//
//    //调整fitsSize的值, 这里的宽度调整为只要宽度小于等于0或者显示一行都不限制宽度，而高度则总是改为不限制高度。
//    fitsSize.height = FLT_MAX;
//    if (fitsSize.width <= 0 || numberOfLines == 1) {
//        fitsSize.width = FLT_MAX;
//    }
//
//    //构造出一个NSStringDrawContext
//    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
//    context.minimumScaleFactor = minimumScaleFactor;
//    @try {
//        //因为下面几个属性都是未公开的属性，所以我们用KVC的方式来实现。
//        [context setValue:@(numberOfLines) forKey:@"maximumNumberOfLines"];
//        if (numberOfLines != 1) {
//            [context setValue:@(YES) forKey:@"wrapsForTruncationMode"];
//        }
//        [context setValue:@(YES) forKey:@"wantsNumberOfLineFragments"];
//    } @catch (NSException *exception) {}
//
//
//    //计算属性字符串的bounds值。
//    CGRect rect = [calcAttributedString boundingRectWithSize:fitsSize options:NSStringDrawingUsesLineFragmentOrigin context:context];
//
//    //需要对段落的首行缩进进行特殊处理！
//    //如果只有一行则直接添加首行缩进的值，否则进行特殊处理。。
//    CGFloat firstLineHeadIndent = paragraphStyle.firstLineHeadIndent;
//    if (firstLineHeadIndent != 0.0 && systemVersion >= 11.0) {
//        //得到绘制出来的行数
//        NSInteger numberOfDrawingLines = [[context valueForKey:@"numberOfLineFragments"] integerValue];
//        if (numberOfDrawingLines == 1) {
//            rect.size.width += firstLineHeadIndent;
//        } else {
//            //取内容的行数。
//            NSString *string = calcAttributedString.string;
//            NSCharacterSet *charset = [NSCharacterSet newlineCharacterSet];
//            NSArray *lines = [string componentsSeparatedByCharactersInSet:charset]; //得到文本内容的行数
//            NSString *lastLine = lines.lastObject;
//            NSInteger numberOfContentLines = lines.count - (NSInteger)(lastLine.length == 0);  //有效的内容行数要减去最后一行为空行的情况。
//            if (numberOfLines == 0) {
//                numberOfLines = NSIntegerMax;
//            }
//            if (numberOfLines > numberOfContentLines)
//                numberOfLines = numberOfContentLines;
//
//            //只有绘制的行数和指定的行数相等时才添加上首行缩进！这段代码根据反汇编来实现，但是不理解为什么相等才设置？
//            if (numberOfDrawingLines == numberOfLines) {
//                rect.size.width += firstLineHeadIndent;
//            }
//        }
//    }
//
//    //取fitsSize和rect中的最小宽度值。
//    if (rect.size.width > fitsSize.width) {
//        rect.size.width = fitsSize.width;
//    }
//
//    //加上阴影的偏移
//    rect.size.width += fabs(shadowOffset.width);
//    rect.size.height += fabs(shadowOffset.height);
//
//    //转化为可以有效显示的逻辑点, 这里将原始逻辑点乘以缩放比例得到物理像素点，然后再取整，然后再除以缩放比例得到可以有效显示的逻辑点。
//    CGFloat scale = [UIScreen mainScreen].scale;
//    rect.size.width = ceil(rect.size.width * scale) / scale;
//    rect.size.height = ceil(rect.size.height *scale) / scale;
//
//    return rect.size;
//}
//
////上述方法的精简版本
//NS_INLINE CGSize xl_calcTextSizeV2(CGSize fitsSize, id text, NSInteger numberOfLines, UIFont *font) {
//    return xl_calcTextSize(fitsSize, text, numberOfLines, font, NSTextAlignmentNatural, NSLineBreakByTruncatingTail,0.0, CGSizeZero);
//}

#endif /* LXCalcTextSize_h */
