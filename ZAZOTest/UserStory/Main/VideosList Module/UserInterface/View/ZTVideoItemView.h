//
//  ZTVideoItemView.h
//  ZAZOTest
//
//  Created by vc on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTVideosListModuleInterface.h"

@interface ZTVideoItemView : UIView

@property (nonatomic) NSUInteger index;
@property (nonatomic) NSURL *videoFileURL;
@property (nonatomic) NSURL *thumbnailImageFileURL;
@property (nonatomic, weak) id<ZTVideosListModuleInterface> eventHandler;

-(void)setup;
-(void)play;
-(void)stop;

@end
