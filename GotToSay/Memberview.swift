//
//  Memberview.swift
//  GotToSay
//
//  Created by Apple on 2020/7/27.
//  Copyright © 2020 god. All rights reserved.
//

import SwiftUI

struct Memberview: View {
    @State private var showSecondView = false
    @State private var arivememo = false
    @Environment(\.colorScheme) var colorScheme
    @State private var member :String = MemberI[0].name
    @State private var laund :String = ""
    @State private var role :String = ""
    @State private var count :Int = 0
    @State private var comment :String = ""
    func coun(index:Int){
        self.count = index
        print(self.count)
    }
    func favor(){
        print(self.count)
        if CommentI[self.count].role{
            CommentI[self.count].role = false
        }else {CommentI[self.count].role = true}
    }
    func delet(){
        CommentI.remove(at: self.count)
    }



    var body: some View {

            VStack{
                 HStack{
                    Spacer()
                    VStack{
						Image(systemName: "person.fill")
                        Text(MemberI[0].name)
                    }.padding(20)
                    Spacer()
                }.foregroundColor(Color.white).font(.title).background(colorScheme == .dark ? Color.gray : Color(red: 153/255, green: 204/255, blue: 255/255))//white pink?
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                .shadow(radius: 3)
                
            //list 人的留言
                List(CommentI.filter({ member.isEmpty ? true : $0.name.contains(member) })) { item in
                    
                    HStack(alignment:.center){
                        if item.size == "洗衣機"{
                        Image( "view_washingmachine_disable.png").foregroundColor(Color(UIColor(named: "tabSelect")!)).font(.title).padding(.trailing)
                        }else{
                            Image( "view_dryer_disable.png").foregroundColor(Color(UIColor(named: "tabSelect")!)).font(.subheadline).padding(.trailing)
                        }

                        VStack(alignment:.leading){
                            HStack{
                                Text(item.comment).font(.headline)
                                Text(item.Author).font(.subheadline).foregroundColor(.blue)    
                            }
                            HStack{
                                Text("From:")
                                Text(item.from)
                             //   Text(CommentI.name.contains(member).count)
                                }.font(.subheadline).foregroundColor(.gray)
                            
                            }
            
                        Spacer()
                        Button(action: {
                            //資料控制
                            self.laund = item.laundrynumber
                            self.comment = item.comment
                            let index = CommentI.firstIndex { (CommentI) -> Bool in
                               return CommentI.comment.hasPrefix(item.comment)
                            }
                            self.coun(index : index!)
                            if item.role{
                                self.role = "收回讚"
                            }else{
                                self.role = "按讚"
                            }
                            //前往便條
                            if self.arivememo{
                                self.arivememo = false}
                            else{
                                self.arivememo = true
                            }
                         }) {
							Image(systemName: "circle.grid.2x2.fill").foregroundColor(Color(UIColor(named: "tabSelect")!))
                                .gesture(
                                   // LongPressGesture(minimumDuration: 1.0)
                                    TapGesture()
                                        .onEnded({ _ in
                                            //資料控制
                                            self.laund = item.laundrynumber
                                            self.comment = item.comment
                                            let index = CommentI.firstIndex { (CommentI) -> Bool in
                                               return CommentI.comment.hasPrefix(item.comment)
                                            }
                                            self.coun(index : index!)
                                            if item.role{
                                                self.role = "收回讚"
                                            }else{
                                                self.role = "按讚"
                                            }
                                            //前往actionbutton
                                            if self.showSecondView{
                                                self.showSecondView = false}
                                            else{
                                                self.showSecondView = true
                                                }                                      })
                                )
                                .font(.title).foregroundColor(Color.blue.opacity(5))
                                .actionSheet(isPresented: self.$showSecondView) { () -> ActionSheet in
                                    ActionSheet(title: Text("想做些什麼呢？"), buttons: [ActionSheet.Button.default(
                                        
                                        Text(self.role), action: {
                                            self.favor()
                                        
                                    }), ActionSheet.Button.default(Text("前往便條"), action: {
                                        self.arivememo = true
                                        
                                    }),ActionSheet.Button.default(Text("刪除"), action: {
                                        self.delet()
                                    }),
                                        ActionSheet.Button.cancel(Text("取消"))])
                            }
                             
                            .sheet(isPresented: self.$arivememo) {
                                Memolist(name:self.member,Laundm:item.laundrynumber)}

                            /*
                             if arivememo{
                            .sheet(isPresented: self.$showSecondView) {
                                Memolist(name:self.member,Laundm:item.laundrynumber)}
                             }
                            */
                             }
                    }
                }
            }//.background(colorScheme == .dark ? Color.orange : Color(red: 153/255, green: 204/255, blue: 255/255))
                .overlay(
    RoundedRectangle(cornerRadius: 30)
        .stroke(Color.gray.opacity(0.8), lineWidth: 2)
).padding()
    }
}

struct Memberview_Previews: PreviewProvider {
    static var previews: some View {
        Memberview()
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
