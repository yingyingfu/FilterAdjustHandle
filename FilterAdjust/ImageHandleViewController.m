//
//  ImageHandleViewController.m
//  FilterAdjust
//
//  Created by 付颖颖 on 2020/12/16.
//

#include<math.h>

#include<stdlib.h>

#include<stdio.h>



#import "ImageHandleViewController.h"


@interface ImageHandleViewController ()

@property(nonatomic,strong)UIImageView *imageView1;

@end

@implementation ImageHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
    [self filterImage];
    
}

-(void)setupUI{
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.imageView1.image = [UIImage imageNamed:@"originalImg.png"];
    [self.view addSubview:self.imageView1];
}
-(void)filterImage{
    
    UIImage *beautyImg = [UIImage imageNamed:@"beautyImg.png"];
    CGImageRef imageRef1 = beautyImg.CGImage;
    // 1 个字节 = 8bit  每行有 17152 每行有17152*8 位
    size_t width1   = CGImageGetWidth(imageRef1);
    size_t height1  = CGImageGetHeight(imageRef1);
    size_t bits1    = CGImageGetBitsPerComponent(imageRef1); // 8
    size_t bitsPerrow1 = CGImageGetBytesPerRow(imageRef1); // width * bits
    
    // 颜色空间
    CGColorSpaceRef colorSpace1 = CGImageGetColorSpace(imageRef1);
    // AlphaInfo: RGBA  AGBR  RGB  :AlphaInfo 信息
    CGImageAlphaInfo alpInfo1 =  CGImageGetAlphaInfo(imageRef1);
    
    // bitmap的数据
    CGDataProviderRef providerRef1 = CGImageGetDataProvider(imageRef1);
    CFDataRef bitmapData1 = CGDataProviderCopyData(providerRef1);
    
    NSInteger pixLength1 = CFDataGetLength(bitmapData1);
    // 像素byte数组
    Byte *pixbuf1 = CFDataGetMutableBytePtr((CFMutableDataRef)bitmapData1);
    
//    // RGBA 为一个单元
//    for (int i = 0; i < pixLength1; i+=4) {
//
//         [self eocImageFiletPixBuf:pixbuf1 offset:i];
//    }
    
    

       CGImageRef imageRef = self.imageView1.image.CGImage;
       // 1 个字节 = 8bit  每行有 17152 每行有17152*8 位
       size_t width   = CGImageGetWidth(imageRef);
       size_t height  = CGImageGetHeight(imageRef);
       size_t bits    = CGImageGetBitsPerComponent(imageRef); // 8
       size_t bitsPerrow = CGImageGetBytesPerRow(imageRef); // width * bits
       
       // 颜色空间
       CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
       // AlphaInfo: RGBA  AGBR  RGB  :AlphaInfo 信息
       CGImageAlphaInfo alpInfo =  CGImageGetAlphaInfo(imageRef);
       
       // bitmap的数据
       CGDataProviderRef providerRef = CGImageGetDataProvider(imageRef);
       CFDataRef bitmapData = CGDataProviderCopyData(providerRef);
       
       NSInteger pixLength = CFDataGetLength(bitmapData);
       // 像素byte数组
       Byte *pixbuf = CFDataGetMutableBytePtr((CFMutableDataRef)bitmapData);
       
//       // RGBA 为一个单元
//       for (int i = 0; i < pixLength; i+=4) {
//
//            [self eocImageFiletPixBuf:pixbuf offset:i];
//       }
//
    for (int j = 0; j < pixLength; j+=4) {
//        if (pixbuf[j] - pixbuf1[j] > 100) {
            int offsetR = j;
            int offsetG = j + 1;
            int offsetB = j + 2;
            // int offsetA = offset + 3;

//           int red1 = pixbuf1[offsetR] ;
//           int gre1 = pixbuf1[offsetG] ;
//           int blu1 = pixbuf1[offsetB] ;
         
            int red = pixbuf[offsetR] ;
            int gre = pixbuf[offsetG] ;
            int blu = pixbuf[offsetB] ;
//            // int alp = pixBuf[offsetA];
        
           if(pixbuf[j] > pixbuf[j+4]){
               red += 20;
               gre += 10;
//               blu -= 10;
           }
        
//
//            if (red - red1 > 50) {
//                red += 50;
//                gre -= 20;
//            }
//            if (gre > gre1) {
//                gre *= 1.5;
//            }
//            if (blu > blu1) {
//                blu *= 1.5;
//            }

            pixbuf[offsetR] = red;
            pixbuf[offsetG] = gre ;
            pixbuf[offsetB] = blu ;
//        }
    }
    
//    for (int i = 0; i < pixLength1; i+=4) {
//        for (int j = 0; j < pixLength; j+=4) {
//            if (pixbuf[i] > pixbuf1[j]) {
//                int offsetR = j;
//                int offsetG = j + 1;
//                int offsetB = j + 2;
//                // int offsetA = offset + 3;
//
//                int red = pixbuf[offsetR];
//                int gre = pixbuf[offsetG];
//                int blu = pixbuf[offsetB];
//                // int alp = pixBuf[offsetA];
//
//                int gray = (red + gre + blu)/3;
//
//                pixbuf[j] = red + 0.5;
//                pixbuf[j] = gre + 0.5;
//                pixbuf[j] = blu + 0.5;
//            }
//        }
//    }
       
       // 准备绘制图片了
       // bitmap 生成一个上下文  再通过上下文生成图片
       CGContextRef contextR = CGBitmapContextCreate(pixbuf, width, height, bits, bitsPerrow, colorSpace, alpInfo);
       
       CGImageRef filterImageRef = CGBitmapContextCreateImage(contextR);
       
       UIImage *filterImage =  [UIImage imageWithCGImage:filterImageRef];
       
       self.imageView1.image = filterImage;
}

// RGBA 为一个单元  彩色照变黑白照
- (void)eocImageFiletPixBuf:(Byte*)pixBuf offset:(int)offset{

       int offsetR = offset;
       int offsetG = offset + 1;
       int offsetB = offset + 2;
       // int offsetA = offset + 3;
       
       int red = pixBuf[offsetR];
       int gre = pixBuf[offsetG];
       int blu = pixBuf[offsetB];
       // int alp = pixBuf[offsetA];
       
       int gray = (red + gre + blu)/3;
       
       pixBuf[offsetR] = gray;
       pixBuf[offsetG] = gray;
       pixBuf[offsetB] = gray;
}

@end
