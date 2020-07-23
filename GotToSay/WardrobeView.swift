//
//  SwiftUIView.swift
//  GotToSay
//
//  Created by e2ne0 on 2020/7/22.
//  Copyright © 2020 god. All rights reserved.
//

import SwiftUI

struct WardrobeView: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: MyClothes.entity(), sortDescriptors: []) var myClothes: FetchedResults<MyClothes>
	@State var addClothes = false
	var body: some View {
		NavigationView{
			VStack{
				List{
					ForEach(myClothes, id: \.id){ myClothes in
						Text(myClothes.name ?? "unknow")
					}
				}
				Button("ADD"){
					let name = ["Sisley", "Sky", "Uniqlo"]
					let chooseName = name.randomElement()!
					let myClothes = MyClothes(context: self.moc)
					myClothes.id = UUID()
					myClothes.name = "\(chooseName)"
					try? self.moc.save()
				}
			}.navigationBarTitle("我的衣櫃",displayMode: .inline)
				.navigationBarItems(trailing: Button(action: {self.addClothes = true}){
						Image(systemName: "plus")
				})
			.sheet(isPresented: $addClothes)
			{
				AddClothesView()
			}
		}
		
	}
}

struct AddClothesView: View{
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: MyClothes.entity(), sortDescriptors: []) var myClothes: FetchedResults<MyClothes>
	
	@State private var name = ""
	@State private var owner = ""
	@State var myTag: washTagInfo?
	@State var tag = false
	@State var goSave = false
	@State var showImagePicker = false
	@State var image: Image?
	@State var inputImage: UIImage?
	var body: some View{
		NavigationView{
			VStack{
				ZStack{
					Circle().fill(Color.secondary)
					if image != nil{
						image?.resizable().scaledToFit()
					}else{
						Text("Tap to select a pic").foregroundColor(.white).font(.headline)
					}
				}
				.padding(.horizontal)
				.frame(width: 200.0, height: 200.0)
				.onTapGesture {
					self.showImagePicker = true
				}
				TextField("什麼衣服", text: $name)					.padding(.horizontal).textFieldStyle(RoundedBorderTextFieldStyle())
				TextField("誰的衣服", text: $owner).padding(.horizontal).textFieldStyle(RoundedBorderTextFieldStyle())
				
				Button(action: {self.tag = true}){
					ZStack{
						RoundedRectangle(cornerRadius: 15).fill(Color.gray).frame(width: 150, height: 50)
						Text("Scan")
					}
				}.sheet(isPresented: $tag) {
					myController(washTag: self.$myTag)
				}
			}.navigationBarTitle("增加衣服",displayMode: .inline)
			.navigationBarItems(trailing: Button(action: {
				self.tag = true}){Text("完成")})
			.sheet(isPresented: $showImagePicker, onDismiss: loadImage){
				ImagePicker(image: self.$inputImage)
			}
		}
	}
	func loadImage(){
		guard let inputImage = inputImage else {return}
		image = Image(uiImage: inputImage)
	}
}

struct WardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeView()
    }
}
