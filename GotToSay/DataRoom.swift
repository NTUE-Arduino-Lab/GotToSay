import Foundation
struct LaundryInfo: Identifiable {
    var id = UUID()
    var Num : Int
    var Name: String = ""
    //地址、經度、緯度
    var Address: String = ""
    var Longitude: Double
    var Latitude: Double
}
#if DEBUG
var info = [
    LaundryInfo(Num: 1,Name:"118自助洗衣店",Address:"台北市大安區和平東路二段118號",Longitude:120.99793200000005,Latitude:23.597650999999956),
    LaundryInfo(Num: 2,Name:"二樓洗衣店",Address:"台北市大安區和平東路二段134號2樓",Longitude:120.64696963449802,Latitude:24.176268887244532),
    LaundryInfo(Num: 3,Name:"三樓洗衣店",Address:"台北市大安區和平東路二段134號3樓",Longitude:121.54506237477938,Latitude:25.026),
    LaundryInfo(Num: 4,Name:"洗衣店4",Address:"基隆市",Longitude:0.0,Latitude:0.0),
    LaundryInfo(Num: 5,Name:"洗衣店5",Address:"宜蘭市",Longitude:0.0,Latitude:0.0)
]
#endif

struct LaundryWashingM: Identifiable {
    var id = UUID()
    var number :Int
    var name: String
    var size: String
    var from: String
    var time: String
}

#if DEBUG

var WashingM : [LaundryWashingM] = [
    LaundryWashingM(number:1,name: "我是第一台洗衣機", size: "Large", from: "118自助洗衣店",time:"goforward.90"),
    LaundryWashingM(number:2,name: "我是第一台洗衣機", size: "Small", from: "118自助洗衣店",time:"goforward.90"),

]
#endif
