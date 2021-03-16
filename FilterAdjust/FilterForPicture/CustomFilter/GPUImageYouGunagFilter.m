//
//  GPUImageYouGunagFilter.m
//
//  Created by 付颖颖 on 2020/12/15.
//

#import "GPUImageYouGunagFilter.h"
NSString *const kGPUImageYouGuangFragmentShaderString = SHADER_STRING
(
 uniform sampler2D inputImageTexture;
 varying highp vec2 textureCoordinate;
 uniform lowp float blackAndWhite;
 const mediump vec4 redColor = vec4(0.2125, 0.7154, 0.0721, 1.0);


 void main (void) {

     lowp vec4 mask = texture2D(inputImageTexture,textureCoordinate);
     lowp float color = (mask.r + mask.g + mask.b) /3.0 - blackAndWhite;
     lowp vec4 tempColor =vec4(color,color,color,1.0);
     gl_FragColor = tempColor;
    
//    lowp vec4 basicColor = texture2D(inputImageTexture,textureCoordinate);
//    lowp float r = basicColor.r;
//    lowp float g = basicColor.g;
//    lowp float b = basicColor.b;
//    lowp float sumRGB = r + g + b;
//
//    lowp float maxColor = max(r,max(g,b));
//    lowp float minColor = min(r,min(g,b));
//    lowp float midColor = sumRGB - maxColor - minColor;
//
//    lowp vec4 tempColor =vec4(minColor - 0.5,minColor - 0.5,minColor - 0.5,1.0);
//    gl_FragColor = tempColor;
 }
);

@implementation GPUImageYouGunagFilter

@end
