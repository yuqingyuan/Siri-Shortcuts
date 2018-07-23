//
//  MainTableViewController.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableView.h"
#import "MainDataSource.h"
#import "ShoppingViewController.h"
#import "AssemblyViewController.h"
#import "AllSiriShortcutViewController.h"
#import "UserActivityViewController.h"

@interface MainViewController ()<MainTableViewDelegate,INUIAddVoiceShortcutViewControllerDelegate>

@property(nonatomic,strong) MainTableView *optionTableView;
@property(nonatomic,strong) MainDataSource *optionDataSource;

@property(nonatomic,strong) INUIAddVoiceShortcutViewController *customShortCutViewController;
@property(nonatomic,strong) ShoppingViewController *shoppingViewController;
@property(nonatomic,strong) AssemblyViewController *assemblyViewController;
@property(nonatomic,strong) AllSiriShortcutViewController *allShortcutViewController;
@property(nonatomic,strong) UserActivityViewController *userActivityViewController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Shortcuts";
    [self.view addSubview:self.optionTableView];
}

#pragma mark - delegate

-(void)tableView:(UITableView *)tableView didSelectAtIndexPath:(NSIndexPath *)indexPath withObject:(nonnull id)object
{
    switch (indexPath.row) {
        case 0:
            [self presentViewController:self.customShortCutViewController animated:YES completion:nil];
            break;
        case 1:
            [self.navigationController pushViewController:self.shoppingViewController animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:self.userActivityViewController animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:self.assemblyViewController animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:self.allShortcutViewController animated:YES];
            break;
        default:
            break;
    }
}

-(void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)reloadTableView
{
    [self.optionTableView reloadData];
}

-(id)fetchDataSource
{
    return self.optionDataSource;
}

#pragma mark - lazy

-(MainTableView *)optionTableView
{
    if(!_optionTableView)
    {
        _optionTableView = [[MainTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _optionTableView.mainTableViewDelegate = self;
        _optionTableView.dataSource = [self fetchDataSource];
    }
    return _optionTableView;
}

-(MainDataSource *)optionDataSource
{
    if(!_optionDataSource)
    {
        _optionDataSource = [[MainDataSource alloc] init];
    }
    return _optionDataSource;
}

-(INUIAddVoiceShortcutViewController *)customShortCutViewController
{
    if(!_customShortCutViewController)
    {
        NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"Bobin.SiriShortCut"];
        userActivity.suggestedInvocationPhrase = @"自定义个性化语音";
        INShortcut *shortCut = [[INShortcut alloc] initWithUserActivity:userActivity];
        _customShortCutViewController = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortCut];
        _customShortCutViewController.delegate = self;
    }
    return _customShortCutViewController;
}

-(ShoppingViewController *)shoppingViewController
{
    if(!_shoppingViewController)
    {
        _shoppingViewController = [[ShoppingViewController alloc] init];
    }
    return _shoppingViewController;
}

-(AssemblyViewController *)assemblyViewController
{
    if(!_assemblyViewController)
    {
        _assemblyViewController = [[AssemblyViewController alloc] init];
    }
    return _assemblyViewController;
}

-(AllSiriShortcutViewController *)allShortcutViewController
{
    if(!_allShortcutViewController)
    {
        _allShortcutViewController = [[AllSiriShortcutViewController alloc] init];
    }
    return _allShortcutViewController;
}

-(UserActivityViewController *)userActivityViewController
{
    if(!_userActivityViewController)
    {
        _userActivityViewController = [[UserActivityViewController alloc] init];
    }
    return _userActivityViewController;
}

@end
