//
//  GPUImageBlackAndWhiteFilter.m
//
//  Created by 付颖颖 on 2020/12/11.
//

#import "GPUImageBlackAndWhiteFilter.h"


#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kGPUImageBlackAndWhiteFragmentShaderString = SHADER_STRING
(
 uniform sampler2D inputImageTexture;
 varying highp vec2 textureCoordinate;
 uniform lowp float blackAndWhite;

 void main (void) {

     lowp vec4 mask = texture2D(inputImageTexture,textureCoordinate);
     lowp float color = (mask.r + mask.g + mask.b) /3.0 - blackAndWhite;
     lowp vec4 tempColor =vec4(color,color,color,1.0);
     gl_FragColor = tempColor;
 }
);
#else
NSString *const kGPUImageBlackAndWhiteFragmentShaderString = SHADER_STRING
(
 uniform sampler2D inputImageTexture;
 varying highp vec2 textureCoordinate;
 uniform lowp float value;

 void main (void) {

     lowp vec4 mask = texture2D(inputImageTexture,textureCoordinate);

     lowp float color = (mask.r + mask.g + mask.b) /3.0 - blackAndWhite;
     lowp vec4 tempColor =vec4(color,color,color,1.0);
     gl_FragColor = tempColor;
 }
);
#endif

@implementation GPUImageBlackAndWhiteFilter

@synthesize blackAndWhite = _blackAndWhite;

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageBlackAndWhiteFragmentShaderString]))
    {
        return nil;
    }
    
    blackAndWhiteUniform = [filterProgram uniformIndex:@"blackAndWhite"];
    self.blackAndWhite = 0.0;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setBlackAndWhite:(CGFloat)newValue
{
    _blackAndWhite = newValue;
    
    [self setFloat:_blackAndWhite forUniform:blackAndWhiteUniform program:filterProgram];
}

@end
