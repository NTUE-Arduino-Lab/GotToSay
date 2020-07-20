//
//  apple.swift
//  HelloSwiftUI
//
//  Created by apple on 2020/7/2.
//  Copyright © 2020 e2ne0. All rights reserved.
//

import SwiftUI

struct AppleD: Identifiable {
    var id = UUID()
    var name: String
    var headline: String
    var bio: String
    var imageName: String { return name }
}

#if DEBUG

let AppleData : [AppleD] = [
    AppleD(name: "Sai Kambampati", headline: "Writer at AppCoda", bio: "Sai Kambampati is an app developer. He lives in Sacramento, CA and was awarded with Apple's WWDC 2017 Scholarship. Proficient in Swift and Python, it's his dream to develop an AI product."),
    AppleD(name: "Simon Ng", headline: "Founder of AppCoda", bio: "Founder of AppCoda. Author of multiple iOS prgramming books including Beginning iOS 12 Programming with Swift and Intermediate iOS 12 Programming with Swift. iOS Developer and Blogger."),
    AppleD(name: "Gabriel Theodoropoulos", headline: "Advanced Software Developer", bio: "Gabriel has been a software developer for about two decades. He has long experience in developing software solutions for various platforms in many programming languages."),
    AppleD(name: "Andrew Jaffee", headline: "Author and Software Developer", bio: "Avid and well-published author and software developer now specializing in iOS mobile app development in Obj-C and Swift. Andrew has published several apps in the Apple App Store and 30 years of experience."),
]
#endif

struct BppleD: Identifiable {
    var id = UUID()
    var name: String
    var number: Int

}

#if DEBUG

var BppleData : [BppleD] = [
    BppleD(name: "我是第一家洗衣店",number:1),
    BppleD(name: "我是第二家洗衣店",number:2),
    BppleD(name: "我是第三家洗衣店",number:3),
    BppleD(name: "我是第四家洗衣店",number:4),
]
#endif
struct CppleD: Identifiable {
    var id = UUID()
    var number :Int
    var name: String
    var first: String
    var member: String
    var imagename: String
    var imageName: String { return name }
}

#if DEBUG

var CppleData : [CppleD] = [
    CppleD(number:1,name: "我是第一台洗衣機", first: "台北市大安區和平東路二段134號", member: "apple",imagename:"goforward.90"),
    CppleD(number:2,name: "我是第二台洗衣機", first: "台北市大安區和平東路二段134號", member: "bpple",imagename:"goforward.45"),
    CppleD(number:3,name: "我是第三台洗衣機", first: "台北市大安區和平東路二段134號", member: "cpple",imagename:"goforward.60"),
    CppleD(number:4,name: "我是第四台洗衣機", first: "台北市大安區和平東路二段134號", member: "dpple",imagename:"goforward.75"),
]
#endif
