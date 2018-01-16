//
//  XHEducationCloudContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//



typedef NS_ENUM(NSInteger,EducationCloudInformationType)
{
    EducationCloudVideoType = 1, //!< 视频类型
    EducationCloudExerciseType = 2,  //!< 练习类型
};


#define EducationCloudImageName @[@"ico_jiaofu",@"ico_xingqu",@"ico_shiti",@"ico_shipin",@"ico_xuexi",@"ico_shequ"]
#define EducationCloudTitle @[@"辅教用品",@"兴趣辅导",@"试题练习",@"教学视频",@"在线学习",@"兴趣社区"]

#import "XHEducationCloudContentView.h"
#import "XHEducationCloudMenuView.h"
#import "XHEducationCloudScrollPreview.h"
#import "XHEducationCloudSwitchMenuView.h"
#import "XHEducationCloudItemCollectionView.h"
#import "XHEducationCloudWebViewController.h"
#import "HNShopViewController.h"

@interface XHEducationCloudContentView () <BaseMenuControlDeletage,XHEducationCloudMenuViewDeletage,XHEducationCloudItemCollectionViewDeletage>



@property (nonatomic,strong) UIViewController *viewController; //!< 视图控制器
@property (nonatomic,strong) XHEducationCloudScrollPreview *scrollPreview; //!< 滚动轮播图
@property (nonatomic,strong) XHEducationCloudMenuView *menuView; //!< 六宫格菜单
@property (nonatomic,strong) XHEducationCloudSwitchMenuView *switchMenuView; //!< 切换菜单
@property (nonatomic,strong) XHEducationCloudItemCollectionView *collectionView; //!< 滚动视图
@property (nonatomic,strong) NSMutableArray <BaseMenuModel*> *switchArray; //!< 交换数组
@property (nonatomic,strong) BaseMenuModel *videoModel; //!< 视频数据模型
@property (nonatomic,strong) BaseMenuModel *exerciseModel; //!< 练习数据模型















@end

@implementation XHEducationCloudContentView




#pragma mark - 初始化方法
-(instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self setViewController:deletage];
        [self setBackgroundColor:RGB(238.0, 238.0, 238.0)];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        
        
        [self addSubview:self.scrollPreview];
        [self addSubview:self.menuView];
        [self addSubview:self.switchMenuView];
        [self addSubview:self.collectionView];
        
        [self.menuView setMenuDeletage:self];
        [self.switchMenuView.menuControl setMenuDeletage:self];
        [self.collectionView setEducationCloudDeletage:self];
        
        
        
        [self showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self beginRefreshing];
        
    }
    return self;
}





/**
 重置Frame

 @param frame 重置之后的Frame
 */
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.scrollPreview resetFrame:CGRectMake(0, 0, frame.size.width, 200.0)];
    [self.menuView resetFrame:CGRectMake(0, (self.scrollPreview.bottom+5.0), self.scrollPreview.width, 180.0)];
    [self.switchMenuView resetFrame:CGRectMake(0, (self.menuView.bottom+10.0), self.menuView.width, 40.0)];
    [self setContentSize:CGSizeMake(frame.size.width, self.switchMenuView.bottom)];
}


#pragma mark 设置轮播图片url地址的数组
/**
 设置轮播图片url地址的数组
 
 @param array 轮播图片的url地址数组
 */
-(void)setImageUrlArray:(NSMutableArray*)array
{
    [self.scrollPreview setItemArray:array];
}


#pragma mark 设置六宫格菜单数组
/**
 设置六宫格菜单数组
 
 @param array 六宫格菜单数据数组
 */
-(void)setMenuItemArray:(NSMutableArray*)array
{
    [self.menuView setItemArray:array];
}

#pragma mark 设置切换菜单数据数组
/**
 设置切换菜单数据数组
 
 @param array 设置切换菜单数据源数组
 */
-(void)setSwitchMenuItemArray:(NSMutableArray*)array
{
    [self.switchMenuView setItemArray:array];
}



#pragma mark - Action Method
-(void)addSwitchModel:(BOOL)model
{
    if (model)
    {
        NSArray *imagesURLStrings=@[@"placeholderImage",@"placeholderImage",@"placeholderImage"];
        [self setImageUrlArray:(NSMutableArray *)imagesURLStrings];
        for (int i=0; i < 6; i++)
        {
            XHEducationCloudFrame *itemFrame = [[XHEducationCloudFrame alloc]init];
            XHEducationCloudModel *itemModel = [[XHEducationCloudModel alloc]init];
            [itemModel setPreviewImage:EducationCloudImageName[i]];
            [itemModel setTitle:EducationCloudTitle[i]];
            [itemModel setTage:i];
            [itemModel setModelType:XHEducationCloudCellSix];
            [itemFrame setModel:itemModel];
            [itemFrame setItemSize:CGSizeMake((SCREEN_WIDTH/3.0), 90.0)];
            [self.dataArray addObject:itemFrame];
        }
        [self setMenuItemArray:self.dataArray];
        
        
        
        self.videoModel = [[BaseMenuModel alloc]init];
        [self.videoModel setItemSize:CGSizeMake(50.0, 40.0)];
        [self.videoModel setTitle:@"视频"];
        [self.videoModel setMarkLineType:BaseMenuTopLineType];
        [self.switchArray addObject:self.videoModel];
        
        self.exerciseModel = [[BaseMenuModel alloc]init];
        [self.exerciseModel setItemSize:CGSizeMake(50.0, 40.0)];
        [self.exerciseModel setTitle:@"试题"];
        [self.exerciseModel setMarkLineType:BaseMenuTopLineType];
        [self.switchArray addObject:self.exerciseModel];
        [self setSwitchMenuItemArray:self.switchArray];
    }
}



#pragma mark - NetWork Method
#pragma mark 头部刷新
-(void)refreshHeaderAction
{
    [self.header endRefreshing];
    [self getAdvertisementWithAction:@"haoxue-video-api_NC001"];
    [self getInformationWithType:EducationCloudVideoType];
    [self getInformationWithType:EducationCloudExerciseType];
}

#pragma mark 获取广告
-(void)getAdvertisementWithAction:(NSString*)actionUrl
{
    XHNetWorkConfig *advertisementNetWorkConfig = [[XHNetWorkConfig alloc]init];
    [advertisementNetWorkConfig postWithUrl:actionUrl sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             NSArray *itemArray = [object objectItemKey:@"object"];
             if (itemArray)
             {
                 [self.dataArray removeAllObjects];
                 [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                  {
                      [self.dataArray addObject:[obj objectItemKey:@"imageUrl"]];
                  }];
                 [self setImageUrlArray:self.dataArray];
             }
            
         }
     } error:^(NSError *error) {}];
}



#pragma mark 获取消息类型
-(void)getInformationWithType:(EducationCloudInformationType)type
{
    switch (type)
    {
        case EducationCloudVideoType:
        {
            XHNetWorkConfig *infomationNetWorkConfig = [[XHNetWorkConfig alloc]init];
            [infomationNetWorkConfig setObject:@"video" forKey:@"type"];
            [infomationNetWorkConfig setOption:XHNetWorkOptionH5ixueHui];
            [infomationNetWorkConfig postWithUrl:@"/information/noticeService/queryInformation" sucess:^(id object, BOOL verifyObject)
             {
                 if (verifyObject)
                 {
                     [self.videoModel.dataArray removeAllObjects];
                     NSArray *itemArray = [object objectForKey:@"object"];
                     [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                      {
                          XHEducationCloudFrame *frame = [[XHEducationCloudFrame alloc]init];
                          XHEducationCloudModel *model = [[XHEducationCloudModel alloc]init];
                          [model setItemObject:obj];
                          [frame setModel:model];
                          [self.videoModel.dataArray addObject:frame];
                      }];
                     [self setSwitchMenuItemArray:self.switchArray];
                 }
             } error:^(NSError *error) {}];
            
        }
            break;
        case EducationCloudExerciseType:
        {
            XHNetWorkConfig *infomationNetWorkConfig = [[XHNetWorkConfig alloc]init];
            [infomationNetWorkConfig setObject:@"exercise" forKey:@"type"];
            [infomationNetWorkConfig setOption:XHNetWorkOptionH5ixueHui];
            [infomationNetWorkConfig postWithUrl:@"/information/noticeService/queryInformation" sucess:^(id object, BOOL verifyObject)
             {
                 if (verifyObject)
                 {
                     [self.exerciseModel.dataArray removeAllObjects];
                     NSArray *itemArray = [object objectForKey:@"object"];
                     [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                      {
                          XHEducationCloudFrame *frame = [[XHEducationCloudFrame alloc]init];
                          XHEducationCloudModel *model = [[XHEducationCloudModel alloc]init];
                          [model setItemObject:obj];
                          [frame setModel:model];
                          [self.exerciseModel.dataArray addObject:frame];
                      }];
                     
                     [self setSwitchMenuItemArray:self.switchArray];
                 }
             } error:^(NSError *error) {}];
        }
            break;
    }
    
    
    
}




#pragma mark - Action Method  更多响应方法
-(void)moreControlAction:(BaseButtonControl*)sender
{
    [self.switchArray enumerateObjectsUsingBlock:^(BaseMenuModel *obj, NSUInteger idx, BOOL *stop)
     {
         
         
         switch (obj.selectType)
         {
             case BaseMenuSelectType:
             {
                 switch (idx)
                 {
                     case 0:  //!< 视频
                     {
                         
//                         XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//                         NSString *webUrl=[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/index.html?user_id=%@",[XHUserInfo sharedUserInfo].ID];
//                         //http://h5.ixuehui.cn/zx/h5/index.html
//                         [webView setWebViewUrl:webUrl];
//                         [webView setNavtionTitle:@"教学视频"];
//                         [self.viewController.navigationController pushViewController:webView animated:YES];
                         HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
                         shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
                             
                             NSString *webUrl=[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/index.html?user_id=%@",[XHUserInfo sharedUserInfo].ID];
                             [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
                             
                         };
                         [shop setNavtionTitle:@"教学视频"];
                         [self.viewController.navigationController pushViewController:shop animated:YES];
                     }
                         break;
                     case 1:  //!< 考试题
                     {
//                         XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//                         NSString *webUrl=[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/exercise_index.html?user_id=%@",[XHUserInfo sharedUserInfo].ID];
//                         [webView setWebViewUrl:webUrl];
//                         [webView setNavtionTitle:@"试题练习"];
//                         [self.viewController.navigationController pushViewController:webView animated:YES];
                         HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
                         shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
                             
                             NSString *webUrl=[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/exercise_index.html?user_id=%@",[XHUserInfo sharedUserInfo].ID];
                             [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
                             
                         };
                         [shop setNavtionTitle:@"试题练习"];
                         [self.viewController.navigationController pushViewController:shop animated:YES];
                     }
                         break;
                 }
                 *stop = YES;
             }
             default:
                 break;
         }
         
         
         
     }];
}

#pragma mark - Deletage Method
#pragma mark BaseMenuControlDeletage (点击视频和考试题重新刷新数据)
-(void)didSelectItem:(BaseMenuModel*)object
{
    [self.collectionView resetFrame:CGRectMake(0, self.switchMenuView.bottom, self.switchMenuView.width, (80.0*([object.dataArray count])))];
    [self.collectionView setItemArray:object.dataArray];
    [self setContentSize:CGSizeMake(self.switchMenuView.width, self.collectionView.bottom)];

}


#pragma mark XHEducationCloudMenuViewDeletage 六宫格菜单点击代理方法
-(void)didSelectItemAtIndex:(XHEducationCloudFrame *)itemObject
{
    
    switch (itemObject.model.tage)
    {
        case 0:
        {
//            NSString *webUrl = [NSString stringWithFormat:@"http://h5.mall.ixuehui.cn?tel=%@&haoxueType=1",[XHUserInfo sharedUserInfo].loginName];
//            XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//            [webView setWebViewUrl:webUrl];
//            [webView setNavtionTitle:@"辅教用品"];
//            [self.viewController.navigationController pushViewController:webView animated:YES];
            HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
            shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
                
                  NSString *webUrl = [NSString stringWithFormat:@"http://h5.mall.ixuehui.cn?tel=%@&haoxueType=1",[XHUserInfo sharedUserInfo].loginName];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
                
            };
            [shop setNavtionTitle:@"辅教用品"];
            [self.viewController.navigationController pushViewController:shop animated:YES];
        }
            break;
        case 1:
        {
//            //http://h5.mall.ixuehui.cn?tel=1530000000&haoxueType=2
//            NSString *webUrl = [NSString stringWithFormat:@"http://h5.mall.ixuehui.cn?tel=%@&haoxueType=2",[XHUserInfo sharedUserInfo].loginName];
//            XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//            [webView setWebViewUrl:webUrl];
//            [webView setNavtionTitle:@"兴趣辅导"];
//            [self.viewController.navigationController pushViewController:webView animated:YES];
            HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
            shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
                
                //http://192.168.1.155:8888/haoxuemall-h5-app/index.html
                //http://h5.mall.ixuehui.cn
                NSString *webUrl = [NSString stringWithFormat:@"http://h5.mall.ixuehui.cn?tel=%@&haoxueType=2",[XHUserInfo sharedUserInfo].loginName];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
                
            };
            [shop setNavtionTitle:@"兴趣辅导"];
            [self.viewController.navigationController pushViewController:shop animated:YES];
        }
            break;
        case 2:
        {
            NSString *webUrl =[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/exercise_index.html?user_id=%@",[XHUserInfo sharedUserInfo].ID];
            XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
            [webView setWebViewUrl:webUrl];
            [webView setNavtionTitle:@"试题练习"];
            [self.viewController.navigationController pushViewController:webView animated:YES];
//            HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
//            shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
//
//                  NSString *webUrl =[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/exercise_index.html?user_id=%@",[XHUserInfo sharedUserInfo].ID];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
//
//            };
//            [shop setNavtionTitle:@"试题练习"];
//            [self.viewController.navigationController pushViewController:shop animated:YES];
        }
            break;
        case 3:
        {
//            NSString *webUrl =[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/index.html?user_id=%@",[XHUserInfo sharedUserInfo].ID];
//            XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//            [webView setWebViewUrl:webUrl];
//            [webView setNavtionTitle:@"教学视频"];
//            [self.viewController.navigationController pushViewController:webView animated:YES];
            HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
            shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
                
                NSString *webUrl =[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/index.html?user_id=%@",[XHUserInfo sharedUserInfo].ID];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
                
            };
            [shop setNavtionTitle:@"教学视频"];
            [self.viewController.navigationController pushViewController:shop animated:YES];
        }
            break;
        case 4:
        {
//            NSString *webUrl = [NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/learn_index.html?type=1?user_id=%@",[XHUserInfo sharedUserInfo].ID];
//            XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//            [webView setWebViewUrl:webUrl];
//            [webView setNavtionTitle:@"在线学习"];
//            [self.viewController.navigationController pushViewController:webView animated:YES];
            HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
            shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
                
                NSString *webUrl = [NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/h5/learn_index.html?type=1?user_id=%@",[XHUserInfo sharedUserInfo].ID];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
                
            };
            [shop setNavtionTitle:@"在线学习"];
            [self.viewController.navigationController pushViewController:shop animated:YES];
        }
            break;
        case 5:
        {
            [XHShowHUD showNOHud:@"建设中"];
        }
            break;
    }
}


#pragma mark XHEducationCloudItemCollectionViewDeletage (视频和试题点击的响应方法)
-(void)didSelectItemAtIndexObject:(XHEducationCloudFrame*)object
{
    switch (object.model.modelType)
    {
        case XHEducationCloudCellVideoTpe:
        {
//            NSString *webUrl = [NSString stringWithFormat:@"%@%@&user_id=%@",VideoBaseUrl,object.model.redirectUrl,[XHUserInfo sharedUserInfo].ID];
//            XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//            [webView setWebViewUrl:webUrl];
//            [webView setNavtionTitle:@"教学视频"];
//            [self.viewController.navigationController pushViewController:webView animated:YES];
//
            HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
            shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
                
                NSString *webUrl = [NSString stringWithFormat:@"%@%@&user_id=%@",VideoBaseUrl,object.model.redirectUrl,[XHUserInfo sharedUserInfo].ID];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
                
            };
            [shop setNavtionTitle:@"教学视频"];
            [self.viewController.navigationController pushViewController:shop animated:YES];
        }
            break;
        case XHEducationCloudCellExaminationQuestionsTpe:
        {
//            XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//            NSString *webUrl=[NSString stringWithFormat:@"%@?user_id=%@",[object.model.redirectUrl encoding],[XHUserInfo sharedUserInfo].ID];
//            [webView setWebViewUrl:webUrl];
//            [webView setNavtionTitle:@"试题练习"];
//            [self.viewController.navigationController pushViewController:webView animated:YES];
            HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
            shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
                
               NSString *webUrl=[NSString stringWithFormat:@"%@?user_id=%@",[object.model.redirectUrl encoding],[XHUserInfo sharedUserInfo].ID];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
                
            };
            [shop setNavtionTitle:@"试题练习"];
            [self.viewController.navigationController pushViewController:shop animated:YES];
        }
            break;
        default:
            break;
    }
}




#pragma mark - Getter / Setter
-(XHEducationCloudScrollPreview *)scrollPreview
{
    if (!_scrollPreview)
    {
        _scrollPreview = [[XHEducationCloudScrollPreview alloc]init];
    }
    return _scrollPreview;
}


-(XHEducationCloudMenuView *)menuView
{
    if (!_menuView)
    {
        _menuView = [[XHEducationCloudMenuView alloc]init];
    }
    return _menuView;
}

-(XHEducationCloudSwitchMenuView *)switchMenuView
{
    if (!_switchMenuView)
    {
        _switchMenuView = [[XHEducationCloudSwitchMenuView alloc]init];
        [_switchMenuView.moreControl addTarget:self action:@selector(moreControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchMenuView;
}


-(XHEducationCloudItemCollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[XHEducationCloudItemCollectionView alloc]init];
    }
    return _collectionView;
}


-(BaseMenuModel *)videoModel
{
    if (!_videoModel)
    {
        _videoModel = [[BaseMenuModel alloc]init];
    }
    return _videoModel;
}

-(BaseMenuModel *)exerciseModel
{
    if (!_exerciseModel)
    {
        _exerciseModel = [[BaseMenuModel alloc]init];
    }
    return _exerciseModel;
}


-(NSMutableArray <BaseMenuModel*> *)switchArray
{
    if (!_switchArray)
    {
        _switchArray = [NSMutableArray array];
    }
    return _switchArray;
}





@end
