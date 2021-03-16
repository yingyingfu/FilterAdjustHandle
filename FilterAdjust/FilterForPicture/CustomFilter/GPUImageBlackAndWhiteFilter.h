//
//  GPUImageBlackAndWhiteFilter.h
//
//  Created by 付颖颖 on 2020/12/11.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageBlackAndWhiteFilter : GPUImageFilter
{
    GLint blackAndWhiteUniform;
}
@property (readwrite, nonatomic) CGFloat blackAndWhite;

@end

NS_ASSUME_NONNULL_END
