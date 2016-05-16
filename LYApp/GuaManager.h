//
//  GuaManager.h
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuaManager : NSObject
@property (nonatomic,strong)NSArray *guaNames;
@property (nonatomic,strong)NSDictionary *tiangans;
@property (nonatomic,strong)NSDictionary *dizhis;

+ (instancetype)shareManager;


- (int)chargeGuaWithYao1:(BOOL)isyang0 Yao2:(BOOL)isyang1
                    Yao3:(BOOL)isyang2 Yao4:(BOOL)isyang3
                    Yao5:(BOOL)isyang4
                    Yao6:(BOOL)isyang5;

- (void)loadGanZhi:(void(^)(NSArray *nian))nianyueri;

- (NSArray *)liushenArrWithDay:(NSString *)day; //六神
- (NSArray *)wuxingAtIndex:(int)index; //装卦五行
- (NSString *)kongwuWithDay:(NSString *)day;

@end
