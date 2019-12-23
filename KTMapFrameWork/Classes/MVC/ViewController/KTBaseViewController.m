//
//  KTBaseViewController.m
//  KTFindCarSDK
//
//  Created by KT--stc08 on 2019/4/25.
//

#import "KTBaseViewController.h"
#import "KTFaildView.h"
#import "LoadingManager.h"
@interface KTBaseViewController ()
@property(nonatomic,strong)KTFaildView *faildView;
@end

@implementation KTBaseViewController

- (void)viewDidLoad {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    [super viewDidLoad];
    [self bindVM];
    
}
-(KTFaildView*)faildView
{
    if (!_faildView) {
        _faildView = [KTFaildView new];
        [self.view addSubview:_faildView];
        [_faildView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        [_faildView.button addTarget:self action:@selector(reloadRequest) forControlEvents:UIControlEventTouchUpInside ];
        _faildView.hidden = true;
    }
    return _faildView;
}
-(void)reloadRequest
{
    [self bindVM];
}
    
-(void)bindVM
{
    __weak typeof(self) weakSelf = self;

    if (self.client) {
        self.client.successEvent = ^(id  _Nonnull object) {
            [weakSelf requestSuccess:object];
        };
        self.client.faildEvent = ^(NSError * _Nonnull error) {
            [weakSelf requestFaild:error];
        };
        [self.client.dataTask resume];
       
    }
    
    
}
-(void)requestSuccess:(id)x
{
    self.faildView.hidden = true;
}
-(void)requestFaild:(NSError *)error
{
//    if (error.code>=3000) {
    if (error) {
        self.faildView.hidden = false;
        [self.faildView showError:error.domain];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.client) {
        if (self.client.dataTask.state == NSURLSessionTaskStateRunning || self.client.dataTask.state == NSURLSessionTaskStateSuspended) {
             [self.client.dataTask cancel];
        }
       
    }
//    if (self.disposable) {
//        [self.disposable dispose];
//    }
    [LoadingManager dismiss];
}

-(void)dealloc
{
//    NSLog(@"%@ is dealloc",NSStringFromClass([self class]));
}

@end
