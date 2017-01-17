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

@property (nonatomic , assign) NSInteger              prePage;
/**
 总记录数
 */
@property (nonatomic , assign) NSInteger              nextPage;
/**
 总记录数
 */
@property (nonatomic , assign) NSInteger              totalCount;
/**
 页大小
 */
@property (nonatomic , assign) NSInteger              pageSize;
/**
 总页数
 */
@property (nonatomic , assign) NSInteger              totalPage;


@end
