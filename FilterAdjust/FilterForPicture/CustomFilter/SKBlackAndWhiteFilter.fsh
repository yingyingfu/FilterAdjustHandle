
uniform sampler2D inputImageTexture;
varying lowp vec2 textureCoordinate;

void main (void) {

    lowp vec4 mask = texture2D(inputImageTexture,textureCoordinate);
    lowp float color = (mask.r + mask.g + mask.b) /3.0 - 0.1;
    lowp vec4 tempColor =vec4(color,color,color,1.0);
    gl_FragColor = tempColor;
}


