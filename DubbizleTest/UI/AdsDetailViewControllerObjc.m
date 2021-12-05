//
//  AdsDetailViewController.m
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

#import "AdsDetailViewControllerObjc.h"
#import "DubbizleTest-Swift.h"

@interface AdsDetailViewControllerObjc ()

@property AdsDetailViewModel *viewModel;
@property MainNavigator *navigator;

@end

@implementation AdsDetailViewControllerObjc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}



//+(AdsDetailViewController*)createWith:(DetailViewNavigator*) navigator
//                       andStoryBoard:(UIStoryboard*)storyBoard
//                        andViewModel:(AdsDetailViewModel*)viewModel{
//    //[UIStoryboard storyboardWithName:@"Main" bundle:nil]
//    AdsDetailViewController *adDetailViewController = [storyBoard  instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
//    adDetailViewController.viewModel = viewModel;
//    adDetailViewController.navigator = navigator;
//    return adDetailViewController;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
