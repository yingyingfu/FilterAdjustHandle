//
//  FilterModel.swift
//
//  Created by 付颖颖 on 2020/11/16.
//

import UIKit

class SKFilterModel: NSObject {

    var typeID:String = "0"
    var filterName:String = ""
    var defaultValue:CGFloat = 0.0
    var currentValue : CGFloat = 0.0
    var miniValue:CGFloat = 0.0
    var maxValue:CGFloat = 0.0
    var isSelect:Bool = false
    
    
    
    init(typeID:String,filterName:String,defaultValue:CGFloat,currentValue:CGFloat,maxValue:CGFloat,miniValue:CGFloat) {
        super.init()
        self.typeID = typeID
        self.filterName = filterName
        self.defaultValue = defaultValue
        self.currentValue = currentValue
        self.maxValue = maxValue
        self.miniValue = miniValue
    }
    
}
