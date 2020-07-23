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
        .background(Color(hue: 0.454, saturation: 0.898, brightness: 0.918, opacity: 0.2))
        
        
    }
}
