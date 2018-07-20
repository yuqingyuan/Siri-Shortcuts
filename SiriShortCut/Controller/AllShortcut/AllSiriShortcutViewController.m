//
//  AllSiriShortcutViewController.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "AllSiriShortcutViewController.h"
#import "SiriShortcutDataSource.h"
#import <IntentsUI/IntentsUI.h>

@interface AllSiriShortcutViewController ()<INUIEditVoiceShortcutViewControllerDelegate>

@property(nonatomic,strong) SiriShortcutDataSource *siriDataSource;
@property(nonatomic,strong) INUIEditVoiceShortcutViewController *editShortcutViewController;

@end

@implementation AllSiriShortcutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"All Shortcuts";
}

#pragma mark - delegate

-(void)tableView:(UITableView *)tableView didSelectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object
{
    self.editShortcutViewController = [[INUIEditVoiceShortcutViewController alloc] initWithVoiceShortcut:((SiriBasicModel *)object).voiceShortcut];
    self.editShortcutViewController.delegate = self;
    [self presentViewController:self.editShortcutViewController animated:YES completion:nil];
}

-(void)editVoiceShortcutViewControllerDidCancel:(INUIEditVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didUpdateVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didDeleteVoiceShortcutWithIdentifier:(NSUUID *)deletedVoiceShortcutIdentifier
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(id)fetchDataSource
{
    self.siriDataSource = [[SiriShortcutDataSource alloc] init];
    return self.siriDataSource;
}

@end
