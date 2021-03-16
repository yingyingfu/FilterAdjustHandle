//
//  SKPictureHandleController.swift
//
//  Created by 付颖颖 on 2020/11/13.
//

import UIKit

class SKPictureHandleController: SBaseController,UISplitViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var filterPipline:GPUImageFilterPipeline? = nil
    
    //图片滤镜编辑视图
    var pictureAdjustView = SKPictureAdjustView()
    
    let filterSettingsSlider = UISlider()

    

    
    
    let minLab = UILabel()
    let maxLab = UILabel()
        
    var sourcePicture:GPUImagePicture!
    var primaryView = GPUImageView()
    
    let picker = UIImagePickerController()
    var originImg = UIImage(named: "originalImg")
    
//    当前点击的label
    var currentLab = UILabel()

    var filterIndex = 1000
    var filterArr:[GPUImageFilter] = []

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.setupUI()
            self.initData()
            self.addFilterChains()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
       

        
        func setupUI(){
            self.view.backgroundColor = .white
            
            self.view.addSubview(primaryView)
            primaryView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            
            let saveBtn = UIButton()
            self.primaryView.addSubview(saveBtn)
            saveBtn.setTitle("保存", for: .normal)
            saveBtn.setTitleColor(.white, for:.normal)
            saveBtn.addTarget(self, action: #selector(saveToAlbum), for: .touchUpInside)
            saveBtn.snp.makeConstraints { (make) in
                make.top.equalTo(20)
                make.width.equalTo(80)
                make.height.equalTo(44)
                make.left.equalTo(20)
            }
            
            let openBtn = UIButton()
            self.primaryView.addSubview(openBtn)
            openBtn.setTitle("相册", for: .normal)
            openBtn.setTitleColor(.white, for:.normal)
            openBtn.addTarget(self, action: #selector(openAlbum), for: .touchUpInside)
            openBtn.snp.makeConstraints { (make) in
                make.top.equalTo(20)
                make.width.equalTo(80)
                make.height.equalTo(44)
                make.right.equalTo(-20)
            }
            
            
            self.primaryView.addSubview(pictureAdjustView)
            pictureAdjustView.dataList = dataList
            pictureAdjustView.filterHandleSelect = {[weak self] sender in
                if let weakSelf = self {
                    weakSelf.settingSlider(sender: sender)
                }
            }
            pictureAdjustView.snp.makeConstraints { (make) in
                make.top.equalTo(60)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(110)
            }
            
            self.primaryView.addSubview(filterSettingsSlider)
            filterSettingsSlider.minimumValue = 0.0
            filterSettingsSlider.maximumValue = 2.0
            filterSettingsSlider.value = 1.0
            filterSettingsSlider.isEnabled = false
            filterSettingsSlider.addTarget(self, action: #selector(updateSlideValue(sender:)),for: .valueChanged)
            filterSettingsSlider.snp.makeConstraints { (make) in
                make.bottom.equalTo(-40)
                make.left.equalTo(60)
                make.right.equalTo(-60)
            }
            
           
            
            self.primaryView.addSubview(minLab)
            minLab.font = UIFont.systemFont(ofSize: 18)
            minLab.textColor = .white
            minLab.textAlignment = .right
            minLab.text = "0.0"
            minLab.snp.makeConstraints { (make) in
                make.right.equalTo(filterSettingsSlider.snp.left).offset(-5)
                make.centerY.equalTo(filterSettingsSlider)
            }
            self.primaryView.addSubview(maxLab)
            maxLab.font = UIFont.systemFont(ofSize: 18)
            maxLab.textColor = .white
            maxLab.textAlignment = .left
            maxLab.text = "2.0"
            maxLab.snp.makeConstraints { (make) in
                make.left.equalTo(filterSettingsSlider.snp.right).offset(5)
                make.centerY.equalTo(filterSettingsSlider)
            }
    }

    func initData(){
        filterArr = [saturationFilter,contrastFilter,brightnessFilter,exposureFilter,hueFilter,whiteBalanceFilter,sharpenFilter,highlightFilter,rFilter,gFilter,bFilter,monochromeFilter,blackAndWhiteFilter,skinToneAdjustFilter,skinHueFilter,skinHueThresholdFilter,maxHueShiftFilter,maxSaturationShiftFilter]
        
        monochromeFilter.setColorRed(0, green: 0, blue: 0)

    }
    
//    添加滤镜
    func addFilterChains(){
        
        //加载一个UIImage对象
        let inputImage = self.originImg
        //初始化GPUImagePicture
        self.sourcePicture = GPUImagePicture(image: inputImage,smoothlyScaleOutput: true)

        //创建GPUImageFilterPipeline对象
        self.filterPipline = GPUImageFilterPipeline.init(orderedFilters: [], input: self.sourcePicture, output: self.primaryView)
        

        sourcePicture.processImage()
    }
//    清除滤镜
    func clearChains(){
        
        let views = pictureAdjustView.scrollView.subviews
        
        for view in views {
            let subViews = view.subviews
            for v in subViews {
                if v is UILabel{
                    v.layer.borderColor = UIColor.white.cgColor
                }
                if v is UIButton {
                    let btn = v as! UIButton
                    btn.isSelected = false
                }
            }
            for model in dataList {
                model.isSelect = false
            }
        }
    }
    
    //打开相册
    @objc func openAlbum(){
//        相册设置
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
        picker.allowsEditing = true
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
//    保存滤镜图片
    @objc func saveToAlbum(){
        
        let vc = SKFilterParamsController()
        vc.dataList = dataList
        self.present(vc, animated: true, completion: nil)
        
        sourcePicture.processImage()
        if  (self.filterPipline?.filters.count)! > 0 {
            let lastFilter =  self.filterPipline?.filters.lastObject as! GPUImageFilter
            lastFilter.useNextFrameForImageCapture()
            let saveImage = self.filterPipline?.currentFilteredFrame()
            if saveImage != nil {
                UIImageWriteToSavedPhotosAlbum(saveImage!, self,#selector(saveImageCall(image:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
    }
    
    //slider配置
    @objc func settingSlider(sender:UIButton){
        
        let index  =  sender.tag
        self.filterIndex = index
        let currentModel = dataList[index - 1000]
        
        filterSettingsSlider.minimumValue = Float(currentModel.miniValue)
        filterSettingsSlider.maximumValue = Float(currentModel.maxValue)
        filterSettingsSlider.value = Float(currentModel.currentValue)
        minLab.text = currentModel.miniValue.description
        maxLab.text = currentModel.maxValue.description
        
        var filter = GPUImageFilter()
        
        if index - 1000 < self.filterArr.count {
            filter = self.filterArr[index - 1000]
        }else{
            return
        }
        if sender.isSelected {
            if !(self.filterPipline?.filters.contains(filter))! {
                self.filterPipline?.addFilter(filter)
            }
            filterSettingsSlider.isEnabled = true
        }else{
            if (self.filterPipline?.filters.contains(filter))! {
                self.filterPipline?.removeFilter(filter)
            }
            filterSettingsSlider.isEnabled = false
        }
        
        dataList[self.filterIndex - 1000].isSelect = sender.isSelected
        self.sourcePicture.processImage()
        
       
        
    }
    
    //更新滤镜值
    @objc func updateSlideValue(sender:UISlider){

        switch self.filterIndex {
        case 1000:
            saturationFilter.saturation = CGFloat(sender.value)
            break
        case 1001:
            contrastFilter.contrast = CGFloat(sender.value)
            break
        case 1002:
            brightnessFilter.brightness = CGFloat(sender.value)
            break
        case 1003:
            exposureFilter.exposure = CGFloat(sender.value)
            break
        case 1004:
            hueFilter.hue = CGFloat(sender.value)
            break
        case 1005:
            whiteBalanceFilter.temperature = CGFloat(sender.value)
            break
        case 1006:
            sharpenFilter.sharpness = CGFloat(sender.value)
            break
        case 1007:
            highlightFilter.highlights = CGFloat(sender.value)
            break
        case 1008:
            rFilter.red = CGFloat(sender.value)
            break
        case 1009:
            gFilter.green = CGFloat(sender.value)
            break
        case 1010:
            bFilter.blue = CGFloat(sender.value)
            break
        case 1011:
            monochromeFilter.intensity = CGFloat(sender.value)
            break
        case 1012:
            blackAndWhiteFilter.blackAndWhite = CGFloat(sender.value)
            break;
        case 1013:
            skinToneAdjustFilter.skinToneAdjust = CGFloat(sender.value)
            break
        case 1014:
            skinHueFilter.skinHue = CGFloat(sender.value)
            break
        case 1015:
            skinHueThresholdFilter.skinHueThreshold = CGFloat(sender.value)
            break
        case 1016:
            maxHueShiftFilter.maxHueShift = CGFloat(sender.value)
            break
        case 1017:
            maxSaturationShiftFilter.maxSaturationShift = CGFloat(sender.value)
            break

        default:
            break
        }
        
        sourcePicture.processImage()
        
        self.currentLab = pictureAdjustView.viewWithTag(2000 + (self.filterIndex - 1000)) as! UILabel
        self.currentLab.text = sender.value.description
        dataList[self.filterIndex - 1000].currentValue = CGFloat(sender.value)
    }
    

    
    @objc func saveImageCall(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
       if error != nil{
          print("保存失败");
       }else{
          print("保存成功");
       }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickerImg = info[UIImagePickerController.InfoKey.editedImage]
        self.originImg = pickerImg as? UIImage
        self.clearChains()
        self.addFilterChains()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
