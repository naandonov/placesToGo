//
//  ViewController.m
//  PlaceToGo
//
//  Created by Nikolay Andonov on 5/11/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGPlacesSearchViewController.h"
#import "PTGVenueRequest.h"

@interface PTGPlacesSearchViewController ()

@end

@implementation PTGPlacesSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PTGVenueRequest *req = [[PTGVenueRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search/"]
                                                  andParameters:@{@"near":@"Sofia"}];
    [req initializeSession];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
