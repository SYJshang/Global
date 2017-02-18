//
//  YJPageModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/11.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJPageModel : NSObject

/**
 当前页
 */
@property (nonatomic , copy) NSString               * currentPage;

@property (nonatomic , copy) NSString               * prePage;
/**
 总记录数
 */
@property (nonatomic , copy) NSString               * nextPage;
/**
 总记录数
 */
@property (nonatomic , copy) NSString               * totalCount;
/**
 页大小
 */
@property (nonatomic , copy) NSString               * pageSize;
/**
 总页数
 */
@property (nonatomic , copy) NSString               * totalPage;


@end
