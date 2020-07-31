//
//  MemoSay.swift
//  GotToSay
//
//  Created by apple on 2020/7/23.
//  Copyright © 2020 god. All rights reserved.
//
import SwiftUI
import Foundation

struct MemoView: View {
    var MemoInfo: String
    var MemoName:  String
    @State private var showSecondView = false
    var body: some View {
        VStack {
            HStack{
                Image(systemName:"clock")
                    .foregroundColor(.blue)
                    .frame(width: 50, height: 50)
                    .font(.largeTitle)
                    .clipShape(Circle())
            
                VStack(alignment: .leading) {
                    Text(MemoInfo)
                        .font(.headline)
                        .foregroundColor(Color.blue)
                            HStack {
                                Text("By")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(MemoName)
                                    .font(.subheadline)
                                    .foregroundColor(Color.blue.opacity(0.8))
                                    }
                                            }

                Spacer()
                Button(action: {
                    if self.showSecondView{
                        self.showSecondView = false}
                    else{
                        self.showSecondView = true
                    }
                }) {
                    Image(systemName: "circle.grid.2x2.fill")
                                  }
                                    .foregroundColor(.blue)
                                    .font(.title)
                    .sheet(isPresented: $showSecondView) {
                        Memolist(name:self.MemoName,Laundm:self.MemoInfo)
                }
                
    }
        .padding()
        .background(Color(hue: 0.556, saturation: 0.898, brightness: 0.918, opacity: 0.2))
        .cornerRadius(30)
        }
    }
}

struct BarView: View {
    @State  var name : String
    @State var address : String
    
     var body: some View {
        
        HStack{
             
        Image(systemName: "location.circle.fill")
            .foregroundColor(.blue)
            .frame(width: 50, height: 50)
            .font(.title)
            .clipShape(Circle())
            Spacer()
        VStack(alignment: .leading) {
            Text(name)
                .font(.title)
                .foregroundColor(Color.black)

            Text(address)
                .font(.headline)
            .foregroundColor(Color.white)
                }
            Spacer()
            Button(action: {}) {
               Image(systemName: "ellipsis.circle.fill")
                                      }
             .foregroundColor(.blue)
             .font(.title)
            
        }
            
        .padding(10)
        .background(Color(red: 153/255, green: 204/255, blue: 255/255))
        
        
    }
}

struct Role {
    let name: String
    let gender: String
    let image: String
}
struct Role2 {
    let size: String
    let size2: String

}
struct Role3 {
    let memo: String
    

}
struct NewMemo: View {
    @State  var Name:String
    var roles = [
        Role(name: "洗衣機", gender: "1",image:"view_washingmachine_disable.png"),
         Role(name: "烘乾機", gender: "2",image:"view_dryer_disable.png"),
    ]
    var roles2 = [
        Role2(size: "大型",size2:"Large"),
        Role2(size: "中型",size2:"Medium"),
        Role2(size: "小型",size2:"Small"),
    ]
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var selectedName = "洗衣機"
    @State private var selectedSize = "大型"
    @State private var selectedTime = ""
    @State private var selectedMemo = "請幫我拿出來"
    var body: some View {
        
    VStack{
        VStack(alignment:.leading){
            Text("機器種類")
            .padding()
            .font(.title)
            .foregroundColor(.blue)
            HStack{
                   Text("\(selectedName)")
                    .padding()
                    Picker(selection: $selectedName, label: Text("選擇機器")) {
                    ForEach(roles, id: \.name) { (role) in
                     HStack {

                         Image(role.image)
                         Text(role.name)
                            .foregroundColor(.blue)

                     }
                   }
                }
                 .pickerStyle(DefaultPickerStyle())
                    .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 40)
            }
            }.frame(minWidth: 0, maxWidth: 300)
            
       
            VStack(alignment:.leading){
                Text("大小")
                    .padding()
                    .font(.title)
                    .foregroundColor(.blue)
                HStack{
                        Picker(selection: $selectedSize, label: Text("")) {
                        ForEach(roles2, id: \.size) { (roles2) in

                             Text(roles2.size)
                                .foregroundColor(.blue)

                       }
                    }
                     
                     .pickerStyle(SegmentedPickerStyle())
                }
            }.frame(minWidth: 0, maxWidth: 300)

        VStack(alignment:.leading){
            Text("時間")
                .padding()
                .font(.title)
                .foregroundColor(.blue)
            
            _TextField(title: "時間", text: $selectedTime).padding(5).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1)).keyboardType(.numberPad)


        }.frame(minWidth: 0, maxWidth: 300)

        VStack(alignment:.leading){
            Text("提醒")
                .padding()
                .font(.title)
                .foregroundColor(.blue)
            HStack{
                Picker(selection: $selectedSize, label: Text("")) {
                    Text("請幫我拿出來").tag(0)}.pickerStyle(SegmentedPickerStyle())
                Picker(selection: $selectedSize, label: Text("")) {
                    Text("寵物類").tag(1)}.pickerStyle(SegmentedPickerStyle())
                Picker(selection: $selectedSize, label: Text("")) {
                    Text("寵物類").tag(2)}.pickerStyle(SegmentedPickerStyle())
            }
             


        }.frame(minWidth: 0, maxWidth: 300)
        .padding()
        Button(action: {
            print(self.selectedMemo)
            let new = MemoInfo(name: "王小花", content: "擋到通知我",role1:true,role2:false,role3:true,laundrynumber: "我是第1台洗衣機", from: "逢甲洗衣店1",time:self.selectedTime)
            Memo.append(new)
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Spacer()
            Text("送出")
            .fontWeight(.bold)
            .font(.title)
             .cornerRadius(20)
            .foregroundColor(.white)
            Spacer()
            }
        }
        .padding(.vertical, 10.0)
        .background(Color.blue)
        .cornerRadius(20)
        .padding(.horizontal, 30)
        }
        .keyboardAdaptive()
        .padding()


    }
}

struct Memolist: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        @State  var name : String
        @State  var Laundm: String
        @State private var inputtext : String = ""
       @State private var actionbutton : Bool = false
        @State private var coun : Int = 0
    
    var body: some View {
    VStack{

        VStack(alignment:.leading){
            //名字
        HStack{
            Text("By: ")
            Text(name)
        }
            //洗衣機型號
        HStack{
            Text("編號: ")
            Text(Laundm)
        }
            //時間
        HStack{
            Text("剩餘時間: ")
            Text("０分鐘")
        }
            //if通知
            HStack{
                Image(systemName: "exclamationmark.circle.fill").foregroundColor(Color.blue)
                Text("擋到通知我")
            }

        }
        //list 人的留言
            List(CommentI.filter({ name.isEmpty ? true : $0.name.contains(name)&&$0.laundrynumber.contains(Laundm) })) { item in
                HStack(alignment:.center){
                    Image(systemName: "person.fill").foregroundColor(Color.blue).font(.title).padding()
                    VStack(alignment:.leading){
                            Text(item.comment)
                        HStack{
                            Text("By: ")
                            Text(item.Author)
                            }.font(.subheadline).foregroundColor(.gray)
                        }
                    Spacer()
                    Button(action: {
                     }) {
                        if item.role {
                            Image(systemName: "hand.thumbsup.fill").foregroundColor(Color.blue).font(.headline).onTapGesture {
                                    print("")
                            }
                            
                        }
                        else{
                            Image(systemName: "hand.thumbsup").foregroundColor(Color.white).font(.headline).onTapGesture {
                                    print("")
                            }
                            
                        }

                         }
                }
        }
        .frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 300)
        
        _TextField(title: "留下留言", text: $inputtext).frame(minWidth: 0, maxWidth: 250).padding()
        HStack{
            Button(action: {
                if self.inputtext .isEmpty{}
                else{
                    let new = CommentInfo(name: self.name,laundrynumber: self.Laundm, Author:"王小花", size: "洗衣機",comment: self.inputtext,role:self.actionbutton)
                    CommentI.append(new)
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                
                
                
                
            }) {
                Text("送出")
                .fontWeight(.bold)
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 4)
                )
                }
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("關閉")
                .fontWeight(.bold)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                    .background(Color.blue)
                .cornerRadius(20)
                }
        
        }
    }
    .padding()
        
    .overlay(
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.blue.opacity(0.7), lineWidth: 4)
    )
    .keyboardAdaptive()
    .padding()
    
    
    
    
    }
}

struct MemoSay_Previews: PreviewProvider {
    static var previews: some View {
        NewMemo(Name: "")
    }
}
