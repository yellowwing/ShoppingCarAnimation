//
//  YWHomeController.m
//  ShoppingCarAnimation
//
//  Created by yellow on 2019/12/10.
//  Copyright © 2019 YW. All rights reserved.
//

#import "YWHomeController.h"

@interface YWHomeController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barConstraintHeight;
@end

@implementation YWHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barConstraintHeight.constant = self.navBar.frame.size.height;
    
    self.navBar.title = @"首页";
}



@end
