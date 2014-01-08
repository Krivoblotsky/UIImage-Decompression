//
//  UIImage+Decompression.m
//  Mockupio
//
//  Created by Sergii Kryvoblotskyi on 1/8/14.
//  Copyright (c) 2014 Alterplay. All rights reserved.
//

#import "UIImage+Decompression.h"

@implementation UIImage (Decompression)

#pragma mark - Private
- (UIImage *)decompress {
    CGImageRef originalImage = (CGImageRef)self.CGImage;
    assert(originalImage != NULL);
    
    CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(originalImage));
    CGDataProviderRef imageDataProvider = CGDataProviderCreateWithCFData(imageData);
    if (imageData != NULL) {
        CFRelease(imageData);
    }
    CGImageRef image = CGImageCreate(CGImageGetWidth(originalImage),
                                     CGImageGetHeight(originalImage),
                                     CGImageGetBitsPerComponent(originalImage),
                                     CGImageGetBitsPerPixel(originalImage),
                                     CGImageGetBytesPerRow(originalImage),
                                     CGImageGetColorSpace(originalImage),
                                     CGImageGetBitmapInfo(originalImage),
                                     imageDataProvider,
                                     CGImageGetDecode(originalImage),
                                     CGImageGetShouldInterpolate(originalImage),
                                     CGImageGetRenderingIntent(originalImage));
    if (imageDataProvider != NULL) {
        CGDataProviderRelease(imageDataProvider);
    }
    
    UIImage *decompressed = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    return decompressed;
}

@end
