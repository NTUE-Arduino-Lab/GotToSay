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
	@State var myTag = washTagInfo()
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
					if myTag.wash != nil{
							Text(String(myTag.wash ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag.bleach != nil{
							Text(String(myTag.bleach ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag.wetClean != nil{
							Text(String(myTag.wetClean ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag.dryClean != nil{
							Text(String(myTag.dryClean ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag.tumbleDry != nil{
							Text(String(myTag.tumbleDry ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag.dry != nil{
							Text(String(myTag.dry ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag.pce != nil{
							Text(String(myTag.pce ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag.hcs != nil{
							Text(String(myTag.hcs ?? "")).foregroundColor(.white).bold().font(.title)
					}
					if myTag.iron != nil{
							Text(String(myTag.iron ?? "")).foregroundColor(.white).bold().font(.title)
					}
				}
            }
        }
    }
}

struct myController: UIViewControllerRepresentable {
	typealias UIViewControllerType = ViewController
	
	@Environment(\.presentationMode) var presentationMode
    @Binding var washTag: washTagInfo
	
	class Coordinator: NSObject,UINavigationControllerDelegate,ARSCNViewDelegate {
		let parent: myController
		init(_ parent: myController){
			self.parent = parent
			}
		func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
			let imageAnchor = anchor as? ARImageAnchor
			let imageName = imageAnchor?.name
			if imageName != nil{
				let plane = SCNPlane(width: imageAnchor!.referenceImage.physicalSize.width, height: imageAnchor!.referenceImage.physicalSize.height)
				let planeNode = SCNNode(geometry: plane)
				planeNode.eulerAngles.x = -.pi/2
				if imageName == "tagSisley"{
					parent.washTag.wash = "GentleWashAtOrBelow30"
					parent.washTag.bleach = "DoNotBleach"
					parent.washTag.tumbleDry = "DoNotTumbleDry"
					parent.washTag.dry = "LineDryInShade"
					parent.washTag.iron = "IronAtLowTemperature"
					parent.washTag.dryClean = "DoNotDryClean"
					parent.presentationMode.wrappedValue.dismiss()
				}
				if imageName == "tagSky"{
					parent.washTag.wash = "WashAtOrBelow30"
					parent.washTag.bleach = "DoNotBleach"
					parent.washTag.tumbleDry = "DoNotTumbleDry"
					parent.washTag.iron = "DoNotIron"
					parent.washTag.dryClean = "DoNotDryClean"
					parent.presentationMode.wrappedValue.dismiss()
				}
				if imageName == "tagKeynote"{
					parent.washTag.wash = "GentleWashAtOrBelow30"
					parent.washTag.bleach = "DoNotBleach"
					parent.washTag.tumbleDry = "DoNotTumbleDry"
					parent.washTag.dry = "LineDry"
					parent.washTag.iron = "IronAtMediumTemperature"
					parent.washTag.dryClean = "DoNotDryClean"
					parent.presentationMode.wrappedValue.dismiss()
				}
				if imageName == "tagC"{
					parent.washTag.wash = "WashAtOrBelow30"
					parent.washTag.bleach = "DoNotBleach"
					parent.washTag.tumbleDry = "TumbleDryingLowTemperature"
					parent.washTag.iron = "DoNotTumbleDry"
					parent.washTag.dryClean = "DoNotDryClean"
					parent.washTag.wetClean = "ProfessionalWetCleaning"
					parent.presentationMode.wrappedValue.dismiss()
				}
				if imageName == "tagUT"{
					parent.washTag.wash = "GentleWashAtOrBelow40"
					parent.washTag.bleach = "Non-chlorineBleachWhenNeeded"
					parent.washTag.tumbleDry = "TumbleDryingLowTemperature"
					parent.washTag.dry = "LineDryInShade"
					parent.washTag.iron = "IronAtMediumTemperature"
					parent.washTag.dryClean = "DoNotDryClean"
					parent.presentationMode.wrappedValue.dismiss()
				}
			}
		}
	}
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	
	func makeUIViewController(context: UIViewControllerRepresentableContext<myController>) -> ViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let controller = storyBoard.instantiateViewController(identifier: "Home")
			as! ViewController
		
		return controller
    }
	
    func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<myController>) {
		if uiViewController.isViewLoaded{
			uiViewController.sceneView.delegate = context.coordinator
		}
    }
}
struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView(name:"YUI",num: 0)
    }
}
