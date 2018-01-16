//
//  MainPreviewViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/26.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "MainPreviewViewController.h"
#import "XHLoginViewController.h"
@interface MainPreviewViewController ()

@end

@implementation MainPreviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imageV=[[UIImageView alloc] initWithFrame:WindowScreen];
    [imageV setContentMode:UIViewContentModeScaleAspectFill];
    imageV.image=[UIImage imageNamed:@"start"];
    [self.view addSubview:imageV];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
