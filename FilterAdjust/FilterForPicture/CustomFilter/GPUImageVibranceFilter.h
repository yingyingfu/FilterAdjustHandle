//
//  GPUImageVibranceFilter.h
//
//  Created by 付颖颖 on 2020/11/12.
//
#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageVibranceFilter : GPUImageFilter
{
    GLint vibranceUniform;
}

//自然饱和度
// Modifies the saturation of desaturated colors, leaving saturated colors unmodified.
// Value -1 to 1 (-1 is minimum vibrance, 0 is no change, and 1 is maximum vibrance)
@property (readwrite, nonatomic) GLfloat vibrance;

@end

NS_ASSUME_NONNULL_END
