//
//  ARView.swift
//  HelloARKit
//
//  Created by e2ne0 on 2020/7/2.
//  Copyright © 2020 e2ne0. All rights reserved.
//

import SwiftUI
import UIKit
import ARKit
import SceneKit

struct ARView: View {
    @State var name: String
    @State var num: Int
	@State var myTag: washTagInfo?
	@State var tag = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)).edgesIgnoringSafeArea(.all)
            VStack{
                Text(name).foregroundColor(.white).bold().font(.title)
                Text(String(num)).foregroundColor(.white).bold().font(.title)
				Button(action: {self.tag = true}){
				ZStack{
					RoundedRectangle(cornerRadius: 15).fill(Color.white).frame(width: 150, height: 50)
					Text("Tap Me")
					}
				}.sheet(isPresented: $tag) {
					myController(washTag: self.$myTag)
					}
				Group{
					if myTag?.wash != nil{
							Text(String(myTag?.wash ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag?.bleach != nil{
							Text(String(myTag?.bleach ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag?.wetClean != nil{
							Text(String(myTag?.wetClean ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag?.dryClean != nil{
							Text(String(myTag?.dryClean ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag?.tumbleDry != nil{
							Text(String(myTag?.tumbleDry ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag?.dry != nil{
							Text(String(myTag?.dry ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag?.pce != nil{
							Text(String(myTag?.pce ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag?.hcs != nil{
							Text(String(myTag?.hcs ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag?.iron != nil{
							Text(String(myTag?.iron ?? "")).foregroundColor(.white).bold().font(.title)
					}
				}
            }
        }
    }
//	func loadTag() {
//		guard let myTag = myTag else { return }
//
//	}
}

struct myController: UIViewControllerRepresentable {
	@Environment(\.presentationMode) var presentationMode
    @Binding var washTag: washTagInfo?
	func makeUIViewController(context: UIViewControllerRepresentableContext<myController>) -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyBoard.instantiateViewController(identifier: "Home") as! ViewController
		sendTag.send.data = nil
		print(sendTag.send.data)
		return controller
    }
	
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<myController>) {
		if sendTag.send.data != nil{
			washTag = sendTag.send.data
			presentationMode.wrappedValue.dismiss()
		}
    }
}
struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView(name:"YUI",num: 0)
    }
}
