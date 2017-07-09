//
//  PrefixHeader.swift
//  IM
//
//  Created by Nemo on 2016/11/6.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import Foundation

import UIKit


let  SCREEN_WIDTH = UIScreen.main.bounds.width

let  SCREEN_HEIGH = UIScreen.main.bounds.height

let  SCREEN = UIScreen.main.bounds


let kPrintLog = 1  // 控制台输出开关 1：打开   0：关闭


func XLog(_ item: Any...) {
    if kPrintLog == 1 {
        print(item.last!)
    }
}


func XCGRect(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat) -> CGRect {
    
    return CGRect(x:x,y :y,width: width,height: height);
}


func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor {
    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a);
}

let LIGHTCOLOR = RGBA(r: 241,g: 241,b: 241,a: 1);

let HOMECOLOR = RGBA(r: 41, g: 106, b: 166, a: 1)


