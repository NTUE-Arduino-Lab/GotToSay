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
                Button(action: {}) {
                    Image(systemName: "circle.grid.2x2.fill")
                                  }
                                    .foregroundColor(.blue)
                                    .font(.title)
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
                .font(.headline)
                .foregroundColor(Color.blue)

            Text(address)
                .font(.subheadline)
            .foregroundColor(Color.gray)
                }
            Spacer()
            Button(action: {}) {
               Image(systemName: "ellipsis.circle.fill")
                                      }
             .foregroundColor(.blue)
             .font(.title)
            
        }
            
        .padding()
        .background(Color(hue: 0.454, saturation: 0.898, brightness: 0.918,opacity: 0.75))
        
        
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
         Role(name: "烘乾機", gender: "男",image:"view_dryer_disable.png"),
    ]
    var roles2 = [
        Role2(size: "大型",size2:"Large"),
        Role2(size: "中型",size2:"Medium"),
        Role2(size: "小型",size2:"Small"),
    ]
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var selectedName = "洗衣機"
    @State private var selectedSize = "大型"
    @State private var selectedAge = ""
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
                    Picker(selection: $selectedName, label: Text("選擇角色")) {
                    ForEach(roles, id: \.name) { (role) in
                     HStack {

                         Image(role.image)
                         Text(role.name)
                            .foregroundColor(.blue)

                     }
                   }
                }
                 .pickerStyle(DefaultPickerStyle())
                .frame(width: 250, height: 40)
            }
            }
            
       
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
            }

        VStack(alignment:.leading){
            Text("時間")
                .padding()
                .font(.title)
                .foregroundColor(.blue)
            
               TextField("你的年紀", text: $selectedAge)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))


        }

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
             


        }
        .padding()
        Button(action: {
            print(self.selectedMemo)
            let new = MemoInfo(number:1,name: "小冬瓜", content: "可以幫我拿一下衣服嗎？",laundrynumber: "第一台洗衣機", from: self.Name,time:"goforward.90")
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
        .padding()
    }
}
/*
struct NewMemo_Previews: PreviewProvider {
    static var previews: some View {
        NewMemo(Name: "二樓洗衣店2")
    }
}

*/
