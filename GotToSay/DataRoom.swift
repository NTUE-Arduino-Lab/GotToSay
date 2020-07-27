import Foundation


//洗衣店他家
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
    LaundryInfo(Num: 1,Name:"逢甲洗衣店1",Address:"台北市大安區和平東路二段118號",Longitude:120.646740,Latitude:24.178693),
    LaundryInfo(Num: 2,Name:"二樓洗衣店2",Address:"台北市大安區和平東路二段134號2樓",Longitude:120.64696963449802,Latitude:24.176268887244532),
    LaundryInfo(Num: 3,Name:"三樓洗衣店3",Address:"台北市大安區和平東路二段134號3樓",Longitude:121.54506237477938,Latitude:25.026),
    LaundryInfo(Num: 4,Name:"洗衣店4",Address:"基隆市",Longitude:0.0,Latitude:0.0),
    LaundryInfo(Num: 5,Name:"洗衣店5",Address:"宜蘭市",Longitude:0.0,Latitude:0.0)
]
#endif

//洗衣機他家
struct LaundryM: Identifiable {
    var id = UUID()
    var number :Int
    var name: String
    var size: String
    var from: String
    var time: String
    var kind:   Bool
}

#if DEBUG

var WashingM : [LaundryM] = [
    LaundryM(number:1,name: "我是第1台洗衣機", size: "Large", from: "逢甲洗衣店1",time:"goforward.90",kind:true),
    LaundryM(number:2,name: "我是第2台洗衣機", size: "Small", from: "逢甲洗衣店1",time:"goforward.90",kind:true),
    LaundryM(number:3,name: "我是第3台洗衣機", size: "Small", from: "逢甲洗衣店1",time:"goforward.90",kind:true),
    LaundryM(number:4,name: "我是第1台烘衣機", size: "Large", from: "逢甲洗衣店1",time:"goforward.90",kind:false),
    LaundryM(number:5,name: "我是第2台烘衣機", size: "Small", from: "逢甲洗衣店1",time:"goforward.90",kind:false),
    LaundryM(number:6,name: "我是第3台烘衣機", size: "Small", from: "逢甲洗衣店1",time:"goforward.90",kind:false),

]
#endif



//便條紙他家
struct MemoInfo: Identifiable {
    var id = UUID()

    var name: String
    var content: String
    var role1:Bool
    var role2:Bool
    var role3:Bool
    var laundrynumber : String
    var from: String
    var time: String
}


#if DEBUG

var Memo : [MemoInfo] = [
    MemoInfo(name: "王小花", content: "擋到通知我",role1:true,role2:false,role3:true,laundrynumber: "我是第1台洗衣機", from: "逢甲洗衣店1",time:"goforward.90"),
    MemoInfo(name: "謝小美", content: "擋到通知我",role1:true,role2:false,role3:true,laundrynumber: "我是第3台洗衣機", from: "逢甲洗衣店1",time:"goforward.90"),

]
#endif

//留言他家
struct CommentInfo: Identifiable {
    var id = UUID()
    
    var name: String
    var laundrynumber : String
    var Author: String
    var size: String
    var comment: String
    var role: Bool
}


#if DEBUG

var CommentI : [CommentInfo] = [
    CommentInfo(name: "王小花",laundrynumber: "我是第1台洗衣機", Author:"小毛孩",size:"洗衣機",comment: "我放在下面了",role:true),
    CommentInfo(name: "王小花",laundrynumber: "我是第1台洗衣機", Author:"小屁孩",size:"洗衣機",comment: "你的衣服有蟲",role:false),
    CommentInfo(name: "謝小美",laundrynumber: "我是第3台洗衣機", Author:"小屁孩",size:"洗衣機",comment: "你是蟲",role:true),
    CommentInfo(name: "王小花",laundrynumber: "我是第3台烘衣機", Author:"小屁孩",size:"烘衣機",comment: "你的衣服有蟲",role:false),

]
#endif

//留言他家
struct MemberInfo: Identifiable {
    var id = UUID()
    
    var name: String
    var laundrynumber : String
    var Author: String

    var comment: String
    var role: Bool
}


#if DEBUG

var MemberI : [MemberInfo] = [
    MemberInfo(name: "王小花",laundrynumber: "我是第1台洗衣機", Author:"洗衣機",comment: "我放在下面了",role:true),
    MemberInfo(name: "王小花",laundrynumber: "我是第1台洗衣機", Author:"烘衣機",comment: "你的衣服有蟲",role:false),

]
#endif
