//
//  YJSearchCity.m
//  全球向导
//
//  Created by SYJ on 2017/1/5.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJSearchCity.h"
#import "PinYin4Objc.h"

@implementation YJSearchCity

static BOOL isIncludeChineseInNSString(NSString *string) {
    for (int i=0; i<string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}

+ (NSArray<YJSearchCity *> *)searchText:(NSString *)searchText inDataArray:(NSArray<YJSearchCity *> *)dataArray {
    NSMutableArray<YJSearchCity *> *results = [NSMutableArray array];
    
    if (searchText.length <= 0 || dataArray.count <= 0) return results;
    
    if (isIncludeChineseInNSString(searchText)) { // 输入了中文-只查询中文
        for (YJSearchCity *city in dataArray) {
            NSRange resultRange = [city.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (resultRange.length > 0) {// 找到了
                [results addObject:city];
            }
        }
        
    }
    else {
        for (YJSearchCity *city in dataArray) {
            
            if (isIncludeChineseInNSString(city.name)) {// 待查询中有中文--转为拼音
                
                HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
                [outputFormat setToneType:ToneTypeWithoutTone];
                [outputFormat setVCharType:VCharTypeWithV];
                [outputFormat setCaseType:CaseTypeLowercase];
                
                static NSString *const separatorString = @" ";
                // 有分隔符
                NSString *completeHasSeparatorPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:city.name withHanyuPinyinOutputFormat:outputFormat withNSString:separatorString];
                // 删除分隔符
                NSString *completeNOSeparatorPinyin = [completeHasSeparatorPinyin stringByReplacingOccurrencesOfString:separatorString withString:@""];
                // 处理多音字 -- 这里只处理了 '重庆'
                if ([city.name hasPrefix:@"重"] && [completeNOSeparatorPinyin hasPrefix:@"z"]) {
                    completeNOSeparatorPinyin = [completeNOSeparatorPinyin stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"c"];
                }
                // 查询没有分隔符中是否包含 (不能使用有分隔符的拼音来查询, 因为输入的里面可能不会包含分隔符, 导致查询不到)
                NSRange resultRange = [completeNOSeparatorPinyin rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (resultRange.length > 0) {// 找到了
                    [results addObject:city];
                    continue; // 进入下一次循环, 不再执行下面这段代码
                }
                NSMutableString *headOfPinyin = [NSMutableString string];
                NSArray *pinyinArray = [completeHasSeparatorPinyin componentsSeparatedByString:separatorString];
                for (NSString *singlePinyin in pinyinArray) {
                    if (singlePinyin) { // 取每个拼音的首字母
                        [headOfPinyin appendString:[singlePinyin substringToIndex:1]];
                    }
                }
                
                NSRange headResultRange = [headOfPinyin rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (headResultRange.length > 0) {// 找到了
                    [results addObject:city];
                }
                
            }
            
            
        }
        
    }
    return results;
}


@end
