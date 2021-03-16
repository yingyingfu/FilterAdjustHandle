//
//  SBaseController.swift
//  Sheng
//
//  Created by 付颖颖 on 2019/8/26.
//

/**
 * @brief: 视图控制器基类
 */

import UIKit
import SnapKit

//系统导航条高度
let NavbarHeight:CGFloat = 44.0

class SBaseController: UIViewController {

    // MARK:-  导航标题
    lazy var navTitleL:UILabel = {
        let nTitle = UILabel.init()
        nTitle.textAlignment = .center
        nTitle.font = UIFont.init(name: "Source Han Sans CN Normal", size: 18)
        nTitle.textColor = HEXCOLOR(h: 0x262626, alpha: 1)
        return nTitle
    }()
    
    //MARK:-  版本号
    lazy var versionL:UILabel = {
       let versionLabel = UILabel()
        versionLabel.textAlignment = .center
        versionLabel.isHidden = true
        versionLabel.font = UIFont.init(name: "Source Han Sans CN Regular", size: 15)
        versionLabel.textColor = HEXCOLOR(h: 0x9F9F9F, alpha: 1)
        return versionLabel
    }()
    
    // MARK:- 导航是否是透明色
    var isNavBarClear:Bool = false{
        didSet{
            if isNavBarClear == true{
                navBarV.backgroundColor = .clear
                navTitleL.textColor = .white
                if rightBtn.title(for: .normal) != nil{
                    rightBtn.setTitleColor(.white, for: .normal)
                }
            }else{
                navBarV.backgroundColor = .white
                navTitleL.textColor = .black
                if rightBtn.title(for: .normal) != nil{
                    rightBtn.setTitleColor(HEXCOLOR(h: 0x303030, alpha: 1), for: .normal)
                }
            }
        }
    }
    
    // MARK:- 设置导航栏透明度
    var navbarAlpha:CGFloat = 0 {
        didSet{
            navBarV.alpha = navbarAlpha
        }
    }
    
    // MARK: - PRIVAE
    lazy var navBarV:UIView = {
        let barV = UIView.init()
        barV.backgroundColor = .white
        return barV
    }()  // 导航背景
    

    private lazy var backBtn:UIButton = {
        let bBtn = UIButton.init(type: .custom)
        bBtn.backgroundColor = .clear
        return bBtn
    }()
    lazy var backImg:UIImageView = {
        let bImg = UIImageView()
        return bImg
    }()

    lazy var backL:UILabel = {
        let bL = UILabel()
        return bL
    }()
    
    lazy var rightBtn:UIButton = {
        let rBtn = UIButton.init(type: .custom)
        return rBtn
    }()
    
    // MARK: - system method
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏导航
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        automaticallyAdjustsScrollViewInsets = false
        
        // MARK:- 设置版本号
        self.view.addSubview(versionL)
//        versionL.text = String.init(format: NSLocalizedString("登录_版本号"), "\(APP_VERSION2)")
        versionL.snp.makeConstraints { (make) in
            make.bottom.equalTo(-40)
            make.centerX.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 强制横屏辅助方法
    override var shouldAutorotate: Bool {
        get{
            return false
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            return .portrait
        }
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get{
            return .portrait
        }
    }
    
    /**
     跳转至设置
     "系统设置": UIApplicationOpenSettingsURLString,
     "个人热点":"prefs:root=INTERNET_TETHERING",
     "WIFI设置":"prefs:root=WIFI",
     "蓝牙设置":"prefs:root=Bluetooth",
     "系统通知":"prefs:root=NOTIFICATIONS_ID",
     "通用设置":"prefs:root=General",
     "显示设置":"prefs:root=DISPLAY&BRIGHTNESS",
     "壁纸设置":"prefs:root=Wallpaper",
     "声音设置":"prefs:root=Sounds",
     "隐私设置":"prefs:root=privacy",
     "蜂窝网路":"prefs:root=MOBILE_DATA_SETTINGS_ID",
     "音乐":"prefs:root=MUSIC",
     "APP Store":"prefs:root=STORE",
     "Notes":"prefs:root=NOTES",
     "Safari":"prefs:root=Safari",
     "Music":"prefs:root=MUSIC",
     "photo":"prefs:root=Photos"
     */
    static func openSettings(url:String) {
        let settingUrl = URL(string: url)
        if #available(iOS 10, *) {
            if let url = settingUrl, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }else{
            if let url = settingUrl, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    // MARK: - 返回方法(可重写)
    @objc public func navBackAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /// 重设导航
    ///
    /// - Parameters:
    ///   - isClear: 是否透明 是_文字为白色
    ///   - leftImage: 左边图片
    ///   - rightImage: 右边图片
    func resetNavbar(isClear:Bool?, leftImage:String?, rightImage:String?) {
        if let isClear = isClear{
            self.isNavBarClear = isClear
        }
        if let leftStr = leftImage{
            backBtn.setImage(UIImage.init(named: leftStr), for: .normal)
        }
        if let rightString = rightImage {
            rightBtn.setImage(UIImage.init(named: rightString), for: .normal)
        }
    }
    /// 创建导航(返回按钮为图片,右侧按钮为图片或无)
    ///
    /// - Parameters:
    ///   - navTitle: 标题
    ///   - leftImage: 返回按钮图片
    ///   - rightImage: 右侧按钮图片
    ///   - ringhtAction: 右侧按钮方法
    func createNavbar(navTitle:String, leftImage:String?, rightImage:String?, ringhtAction:Selector?) {
        self.createNavbar(navTitle: navTitle, leftIsImage: true, leftStr: leftImage, rightIsImage: true, rightStr: rightImage, leftAction: nil, ringhtAction: ringhtAction)
    }
    
    /// 创建导航(返回按钮为图片,右侧按钮为文字或无)
    ///
    /// - Parameters:
    ///   - navTitle: 标题
    ///   - leftImage: 返回按钮图片
    ///   - rightImage: 右侧按钮标题
    ///   - ringhtAction: 右侧按钮方法
    func createNavbar(navTitle:String, leftImage:String?, rightStr:String?, ringhtAction:Selector?) {
        self.createNavbar(navTitle: navTitle, leftIsImage: true, leftStr: leftImage, rightIsImage: false, rightStr: rightStr, leftAction: nil, ringhtAction: ringhtAction)
    }
    
    // MARK: - PRIVATE
    private func createNavbar(navTitle:String, leftIsImage:Bool, leftStr:String?, rightIsImage:Bool, rightStr:String?, leftAction:Selector?, ringhtAction:Selector?) {
        //背景
        self.view.addSubview(navBarV)
        navBarV.backgroundColor = .white
        navBarV.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(90)
        }
        
        if let leftAction = leftAction {
            backBtn.addTarget(self, action: leftAction, for: .touchUpInside)
        }else{
            backBtn.addTarget(self, action: #selector(navBackAction), for: .touchUpInside)
        }
        
        //返回按钮
        navBarV.addSubview(backImg)
        backImg.contentMode = .scaleAspectFit
        if leftStr != nil && leftStr != ""{
            backImg.image = UIImage(named: leftStr!)
        }else{
            backImg.image = UIImage(named: "Archive_icon_back")
        }
        backImg.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.height.width.equalTo(20)
            make.centerY.equalTo(44)
        }
        navBarV.addSubview(backL)
        backL.text = "返回"
        backL.textColor = HEXCOLOR(h: 0x262626, alpha: 1)
        backL.font = UIFont.systemFont(ofSize: CGFloat(18))
        backL.snp.makeConstraints { (make) in
            make.left.equalTo(backImg.snp.right).offset(15)
            make.centerY.equalTo(backImg)
        }
        navBarV.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalTo(backImg)
            make.right.equalTo(backL.snp.right).offset(40)
            make.height.equalTo(90)
        }
        //右侧按钮
        if rightIsImage{
            if let rightString = rightStr {
                rightBtn.setImage(UIImage.init(named: rightString), for: .normal)
                
            }
        }else{
            if let rightString = rightStr {
                rightBtn.setTitle(rightString, for: .normal)
                rightBtn.setTitleColor(HEXCOLOR(h: 0x303030, alpha: 1), for: .normal)
                rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            }
        }
        if let ringhtAction = ringhtAction {
            rightBtn.addTarget(self, action: ringhtAction, for: .touchUpInside)
        }
        navBarV.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(90)
            make.width.equalTo(90)
        }
        //标题
        navTitleL.text = navTitle
        navBarV.addSubview(navTitleL)
        navTitleL.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(NavbarHeight)
        }
    }
}
