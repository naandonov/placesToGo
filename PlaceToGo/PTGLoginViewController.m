//
//  PTGLoginViewController.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/13/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//
#import "PTGLoginViewController.h"
#import "PTGNetworkManager.h"
#import "PTGCredentialStore.h"
#import "PTGAuthenticationRequest.h"

@interface PTGLoginViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *loginWebView;

@end

@implementation PTGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        
        if([[cookie domain] isEqualToString:@"foursquare.com"]) {
            
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    self.loginWebView.delegate = self;
    PTGAuthenticationRequest *request = [[PTGAuthenticationRequest alloc] init];
    [self.loginWebView loadRequest:request];

    
    // Do any additional setup after loading the view.
}
- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([request.URL.scheme isEqualToString:@"ptgaccess"]) {
        NSURLComponents *comps = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:NO];
        NSArray *array = [comps.fragment componentsSeparatedByString:@"="];
        [PTGCredentialStore setAccessToken:[array lastObject]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return YES;
}


@end
