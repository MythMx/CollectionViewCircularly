//
//  CollectionViewCell2.m
//  CollectionViewDemo1
//
//  Created by liu on 16/1/4.
//  Copyright © 2016年 vizz. All rights reserved.
//

#import "CollectionViewCell2.h"

@interface CollectionViewCell2()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

@implementation CollectionViewCell2

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    
    self.imageView.image = [UIImage imageNamed:imageName];
}


@end
