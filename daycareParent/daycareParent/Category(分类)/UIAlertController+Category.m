//
//  UIAlertController+Category.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "UIAlertController+Category.h"
@implementation UIAlertController (Category)

+(UIAlertController *)actionSheetWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i=0; i<titleArry.count; i++)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:titleArry[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            indexBlock(i,titleArry[i]);
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    
    [controller presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}
+(UIAlertController *)addtextFeildWithmessage:(NSString *)message controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alertController.textFields.firstObject.text.length==0)
        {
            [XHShowHUD showNOHud:@"输入内容不能为空"];
        }
        else
        {
         indexBlock(0,alertController.textFields.firstObject.text);
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    [controller presentViewController:alertController animated:YES completion:nil];

    return alertController;
}
+(UIAlertController *)alertWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i=0; i<titleArry.count; i++)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:titleArry[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            indexBlock(i,titleArry[i]);
        }]];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
    return alertController;
}


@end
