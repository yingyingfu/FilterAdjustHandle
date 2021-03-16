//
//  SKFilters.swift
//  FilterAdjust
//
//  Created by 付颖颖 on 2020/12/17.
//

import Foundation


var dataList:[SKFilterModel] = [
    SKFilterModel(typeID:"0",filterName: "饱和度", defaultValue: 1.0,currentValue: 1.0,maxValue:2.0,miniValue:0.0),
    SKFilterModel(typeID:"1",filterName: "对比度", defaultValue: 1.0,currentValue: 1.0,maxValue:4.0,miniValue:0.0),
    SKFilterModel(typeID:"2",filterName: "亮度", defaultValue: 0.0,currentValue: 0.0,maxValue:1.0,miniValue:-1.0),
    SKFilterModel(typeID:"3",filterName: "曝光度", defaultValue: 0.0,currentValue: 0.0,maxValue:4.0,miniValue:-4.0),
    SKFilterModel(typeID:"4",filterName: "色调", defaultValue: 0.0,currentValue: 0.0,maxValue:360.0,miniValue:0),
    SKFilterModel(typeID:"5",filterName: "白平衡", defaultValue: 5000,currentValue: 5000,maxValue:7500,miniValue:2500),
    SKFilterModel(typeID:"6",filterName: "锐化", defaultValue: 0.0,currentValue: 0.0,maxValue:4.0,miniValue:-1.0),
    SKFilterModel(typeID:"7",filterName: "高光", defaultValue: 1.0,currentValue: 1.0,maxValue:1.0,miniValue:0),
    SKFilterModel(typeID:"8",filterName: "R", defaultValue: 1.0,currentValue: 1.0,maxValue:2.0,miniValue:0),
    SKFilterModel(typeID:"9",filterName: "G", defaultValue: 1.0,currentValue: 1.0,maxValue:2.0,miniValue:0),
    SKFilterModel(typeID:"10",filterName: "B", defaultValue: 1.0,currentValue: 1.0,maxValue:2.0,miniValue:0),
    SKFilterModel(typeID:"11",filterName: "单色", defaultValue: 1.0,currentValue: 1.0,maxValue:1.0,miniValue:0.0),
    SKFilterModel(typeID:"12",filterName: "黑白", defaultValue: 0.0,currentValue: 0.0,maxValue:1.0,miniValue:-1.0),
    SKFilterModel(typeID:"13",filterName: "肤色的量", defaultValue: 0.0,currentValue: 0.0,maxValue:0.3,miniValue:-0.3),
    SKFilterModel(typeID:"14",filterName: "检测的肤色", defaultValue: 0.05,currentValue: 0.05,maxValue:0.1,miniValue:-0.1),
    SKFilterModel(typeID:"15",filterName: "皮肤色调", defaultValue: 40.0,currentValue: 40.0,maxValue:100.0,miniValue:-20.0),
    SKFilterModel(typeID:"16",filterName: "色相偏移量", defaultValue: 0.25,currentValue: 0.25,maxValue:1.0,miniValue:0.0),
    SKFilterModel(typeID:"17",filterName: "最大饱和量", defaultValue: 0.4,currentValue: 0.4,maxValue:1.0,miniValue:0.0),
]

//    滤镜
let saturationFilter = GPUImageSaturationFilter()//饱和度
let contrastFilter = GPUImageContrastFilter()//对比
let brightnessFilter = GPUImageBrightnessFilter()//亮度
let exposureFilter = GPUImageExposureFilter()//曝光度
let hueFilter = GPUImageHueFilter()//色调
let whiteBalanceFilter = GPUImageWhiteBalanceFilter()//白平衡
let sharpenFilter = GPUImageSharpenFilter()//锐化
let highlightFilter = GPUImageHighlightShadowFilter()//高光
let rFilter = GPUImageRGBFilter()//R
let gFilter = GPUImageRGBFilter()//G
let bFilter = GPUImageRGBFilter()//B
let monochromeFilter = GPUImageMonochromeFilter()//单色
let blackAndWhiteFilter = GPUImageBlackAndWhiteFilter()//黑白
let skinToneAdjustFilter = GPUImageSkinToneFilter()//肤色的量
let skinHueFilter = GPUImageSkinToneFilter()//检测的肤色
let skinHueThresholdFilter = GPUImageSkinToneFilter()//皮肤色调
let maxHueShiftFilter = GPUImageSkinToneFilter()//色相偏移量
let maxSaturationShiftFilter = GPUImageSkinToneFilter()//最大饱和量



