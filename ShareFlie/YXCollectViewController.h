//
//  YXCollectViewController.h
//  ShareFlie
//
//  Created by 刘旭斌 on 2017/6/3.
//  Copyright © 2017年 kodbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    IMAGES,
    MOVIES,
} DATATYPE;

@interface YXCollectViewController : UIViewController

//图片
- (instancetype)initWithArrData:(NSMutableArray *)arrData;
//视频
- (instancetype)initWithArrImages:(NSMutableArray *)arrImages arrFileUrl:(NSMutableArray *)arrFileUrl;


@end
