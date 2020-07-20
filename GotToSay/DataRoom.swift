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
    LaundryInfo(Num: 1,Name:"洗衣店1",Address:"台北市",Longitude:0.0,Latitude:0.0),
    LaundryInfo(Num: 2,Name:"洗衣店2",Address:"新北市",Longitude:0.0,Latitude:0.0),
    LaundryInfo(Num: 3,Name:"洗衣店3",Address:"桃園市",Longitude:0.0,Latitude:0.0),
    LaundryInfo(Num: 4,Name:"洗衣店4",Address:"基隆市",Longitude:0.0,Latitude:0.0),
    LaundryInfo(Num: 5,Name:"洗衣店5",Address:"宜蘭市",Longitude:0.0,Latitude:0.0)
]
#endif
