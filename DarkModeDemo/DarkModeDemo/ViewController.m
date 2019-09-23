//
//  ViewController.m
//  DarkModeDemo
//
//  Created by caishihui on 2019/9/23.
//  Copyright © 2019 wqj. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconIv;
@property (weak, nonatomic) IBOutlet UILabel *tipLb;
@property (weak, nonatomic) IBOutlet UILabel *descLb;
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取当前模式
//    self.traitCollection.userInterfaceStyle
//    self.view.traitCollection.userInterfaceStyle
//    UITraitCollection.currentTraitCollection.userInterfaceStyle
    
    //动态颜色
    //系统提供的动态颜色
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.tipLb.textColor = [UIColor labelColor];
    //自己创建的动态颜色
    self.descLb.textColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        if (traitCollection.userInterfaceStyle==UIUserInterfaceStyleDark) {
            return [UIColor whiteColor];
        }else{
            return [UIColor blackColor];
        }
    }];
    
    //强行设置App模式
//    当系统设置为Light Mode时，对某些App的个别页面希望一直显示Dark Mode下的样式，这个时候就需要强行设置当前ViewController的模式了
//    self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
//  ⚠️ 注意!!!
//当我们强行设置当前viewController为Dark Mode后，这个viewController下的view都是Dark Mode
//由这个ViewController present出的ViewController不会受到影响，依然跟随系统的模式
//要想一键设置App下所有的ViewController都是Dark Mode，请直接在Window上执行overrideUserInterfaceStyle
//对window.rootViewController强行设置Dark Mode也不会影响后续present出的ViewController的模式
    
//    NSAttributedString
//    不建议的做法
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
//    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"富文本文案" attributes:dic];
//    推荐的做法
//     添加一个NSForegroundColorAttributeName属性
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor labelColor]};
//    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"富文本文案" attributes:dic];
    
    [self testCGColorAction];
}
//监听模式切换
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    BOOL isSame = [self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection];
    if (isSame) {
        [self testCGColorAction];
    }
}
//CGColor适配
//我们知道iOS13后，UIColor能够表示动态颜色，但是CGColor依然只能表示一种颜色，那么对于CALayer等对象如何适配暗黑模式呢?当然是利用上一节提到的监听模式切换的方法啦。
- (void)testCGColorAction {
    UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        if (traitCollection.userInterfaceStyle==UIUserInterfaceStyleDark) {
            return [UIColor whiteColor];
        }else{
            return [UIColor linkColor];
        }
    }];
    [self.companyBtn setTitleColor:dyColor forState:UIControlStateNormal];
//    方式一:resolvedColor
//    UIColor *resolvedColor = [dyColor resolvedColorWithTraitCollection:self.traitCollection];
//    self.companyBtn.layer.borderColor = resolvedColor.CGColor;
//    方式二:performAsCurrent
//    [self.traitCollection performAsCurrentTraitCollection:^{
//        self.companyBtn.layer.borderColor = dyColor.CGColor;
//    }];
//    方式三:直接设置为一个动态UIColor的CGColor即可
    self.companyBtn.layer.borderColor = dyColor.CGColor;
    
// ⚠️!!! 设置layer颜色都是在traitCollectionDidChange中，意味着如果没有发生模式切换，layer将会没有颜色，需要设置一个基本颜色
}
- (IBAction)companyAction {
    DetailViewController *detailVc = [[DetailViewController alloc] init];
    detailVc.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:detailVc animated:YES completion:nil];
}

@end
