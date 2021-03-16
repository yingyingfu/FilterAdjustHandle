//
//  SKPictureAdjustView.swift
//
//  Created by 付颖颖 on 2020/11/13.
//  图片滤镜调试

import UIKit

class SKPictureAdjustView: UIView {
    
    var filterHandleSelect:((_ sender: UIButton) ->())?
    var filterHandleLongpress:((_ sender: UIButton) ->())?
    

    var dataList:[SKFilterModel] = []{
        didSet{
            self.createViewWithData()
        }
    }
    
    let scrollView = UIScrollView()
    var temView = UIView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    

    
    func createViewWithData(){
        scrollView.isScrollEnabled = true
        var totalWidth : CGFloat = 0.0
        
        
        for index in 0..<dataList.count {
            let itemView = UIView()
            scrollView.addSubview(itemView)
            itemView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.width.equalTo(70)
                make.top.equalToSuperview()
                if index == 0 {
                    make.left.equalToSuperview().offset(20)
                } else {
                    make.left.equalTo(temView.snp.right).offset(20)
                }
            }
            
            let valueLab = UILabel()
            itemView.addSubview(valueLab)
            valueLab.text = dataList[index].defaultValue.description
            valueLab.layer.cornerRadius = 35
            valueLab.layer.borderWidth = 1
            valueLab.layer.borderColor = UIColor.white.cgColor
            valueLab.textAlignment = .center
            valueLab.textColor = .white
            valueLab.font = UIFont.systemFont(ofSize: 12)
            valueLab.tag = 2000 + index
            valueLab.snp.makeConstraints { (make) in
                make.top.equalTo(10)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(70)
            }

            let titleLab = UILabel()
            itemView.addSubview(titleLab)
            titleLab.text = dataList[index].filterName
            titleLab.textAlignment = .center
            titleLab.textColor = .white
            titleLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(valueLab)
                make.top.equalTo(valueLab.snp.bottom).offset(5)
            }
            
            let button = UIButton()
            itemView.addSubview(button)
            button.tag = 1000 + Int(dataList[index].typeID)!
            button.addTarget(self, action: #selector(clickAction(sender:)), for: .touchUpInside)
            button.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            temView = itemView
            itemView.layoutIfNeeded()
            totalWidth += itemView.frame.size.width
        }
        scrollView.contentSize = CGSize(width: totalWidth+20+CGFloat((dataList.count-1)*20), height: 110)
    }
   
    
    @objc func clickAction(sender:UIButton){
        
        sender.isSelected = !sender.isSelected
        let currentLab = scrollView.viewWithTag(2000 + (sender.tag - 1000))
        
        if sender.isSelected {
            currentLab?.layer.borderColor = UIColor.red.cgColor
        }else{
            currentLab?.layer.borderColor = UIColor.white.cgColor
        }
        if let block = filterHandleSelect {
            block(sender)
        }
    }
    
    @objc func cancelAction(gesture : UILongPressGestureRecognizer){
        
        guard let tag = gesture.view?.tag else { return  }
        
        let currentLab = scrollView.viewWithTag(2000 + (tag - 1000))
        currentLab?.layer.borderColor = UIColor.white.cgColor
        
        if let block = filterHandleLongpress {
            block(gesture.view as! UIButton)
        }
    }
}
