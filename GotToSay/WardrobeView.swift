//
//  SwiftUIView.swift
//  GotToSay
//
//  Created by e2ne0 on 2020/7/22.
//  Copyright © 2020 god. All rights reserved.
//

import SwiftUI
import CoreImage
struct WardrobeView: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: MyClothes.entity(), sortDescriptors: []) var myClothes: FetchedResults<MyClothes>
	@State var addClothes = false
	var body: some View {
		VStack{
			NavigationView{
				List{
					ForEach(myClothes, id: \.id){ myClothes in NavigationLink(destination: ClothesDetialView(name:myClothes.name, owner: myClothes.owner, image: myClothes.image)){
						if myClothes.image != nil{
							Image(uiImage:UIImage(data: myClothes.image!)!).resizable().scaledToFill().frame(width: 150.0, height: 150.0).clipShape(Circle())
							
						}else{
							Image (systemName: "camera").padding().frame(width: 150.0, height: 150.0).clipShape(Circle())
						}
						VStack(alignment: .leading) {
							Text(myClothes.name!).font(.title)
							Text(myClothes.owner ?? "Mine").font(.subheadline).foregroundColor(Color.secondary)
						}
						}
					}.onDelete(perform: removeClothes)
				}.navigationBarTitle(Text("我的衣櫃"),displayMode: .automatic)
					.navigationBarItems(leading: Button(action: {}){
						Text("一起洗")
						}, trailing: NavigationLink(destination: AddClothesView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)){
							Text("新增衣服")
					})
			}
		}}
	func removeClothes(at offsets: IndexSet){
		
		for index in offsets {
			let clothes = myClothes[index]
			moc.delete(clothes)
		}
		do {
			try moc.save()
		} catch {
			// handle the Core Data error
		}
	}
}

struct AddClothesView: View{
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	@FetchRequest(entity: MyClothes.entity(), sortDescriptors: []) var myClothes: FetchedResults<MyClothes>
	
	@State private var name = ""
	@State private var owner = ""
	@State private var keyboardHeight: CGFloat = 0
	@State var myTag = washTagInfo()
	
	
	@State var shouldPresentTagActionSheet = false
	@State var shouldPresentTagScan = false
	@State var shouldPresentTagEdit = false
	@State var goSave = false
	@State var shouldPresentImagePicker = false
	@State var shouldPresentImageActionSheet = false
	@State var shouldPresentCamera = false
	
	
	@State var image: Image?
	@State var inputImage: UIImage?
	var body: some View{
		NavigationView{
			
			VStack{
				ZStack{
					Rectangle().fill(Color.secondary)
					if self.image != nil{
						self.image?.resizable()
					}else{
						Text("Tap to select a pic").foregroundColor(.white).font(.headline)
					}
				}.onAppear(perform: self.loadImage)
					.padding(.horizontal)
					.frame(width: 200.0, height: 200.0)
					.onTapGesture {
						self.shouldPresentImageActionSheet = true
				}
				
				_TextField(title: "哪件衣服", text: self.$name).frame(height: 40.0).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 2)).padding(.horizontal)
				_TextField(title: "誰的衣服", text: self.$owner).frame(height: 40.0).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 2)).padding([.leading, .bottom, .trailing])
				
				
				
				if myTag != washTagInfo(){
					ShowTag(myTag: self.$myTag)
				}
				
				Button(action: {self.shouldPresentTagActionSheet = true}){
					ZStack{
						RoundedRectangle(cornerRadius: 15).fill(Color.gray).frame(width: 150, height: 50)
						Text("加入標籤")
					}
				}.actionSheet(isPresented: self.$shouldPresentTagActionSheet) { () -> ActionSheet in
						ActionSheet(title: Text("你想要從哪裡加入標呢？"), buttons: [ActionSheet.Button.default(Text("相機掃描"), action: {
							self.shouldPresentTagScan = true
						}), ActionSheet.Button.default(Text("自己編輯"), action: {
							self.shouldPresentTagEdit = true
						}), ActionSheet.Button.cancel()])
				}.sheet(isPresented: self.$shouldPresentTagScan){
					myController(washTag: self.$myTag)
				}.sheet(isPresented: self.$shouldPresentTagEdit){
					TagEditor(myTag: self.$myTag)
				}
			}.keyboardAdaptive()
		}.navigationBarTitle("增加衣服",displayMode: .inline)
			.navigationBarItems(trailing: Button(action: {
				let chooseName = self.name
				let chooseOwner = self.owner
				let myClothes = MyClothes(context: self.moc)
				myClothes.id = UUID()
				myClothes.name = "\(chooseName)"
				myClothes.owner = "\(chooseOwner)"
				myClothes.bleach = self.myTag.bleach
				myClothes.dry = self.myTag.dry
				myClothes.dryClean = self.myTag.dryClean
				myClothes.hcs = self.myTag.hcs
				myClothes.iron = self.myTag.iron
				myClothes.pce = self.myTag.pce
				myClothes.tumbleDry = self.myTag.tumbleDry
				myClothes.wash = self.myTag.wash
				myClothes.wetClean = self.myTag.wetClean
				myClothes.image = self.inputImage?.jpegData(compressionQuality: 1.0)
				try? self.moc.save()
				self.presentationMode.wrappedValue.dismiss()
			}){Text("完成")})
			.actionSheet(isPresented: self.$shouldPresentImageActionSheet) { () -> ActionSheet in
				ActionSheet(title: Text("你想要從哪裡加入圖片呢？"), buttons: [ActionSheet.Button.default(Text("拍一張照片"), action: {
					self.shouldPresentImagePicker = true
					self.shouldPresentCamera = true
				}), ActionSheet.Button.default(Text("從相簿選取"), action: {
					self.shouldPresentImagePicker = true
					self.shouldPresentCamera = false
				}), ActionSheet.Button.cancel()])
		}.sheet(isPresented: self.$shouldPresentImagePicker, onDismiss: self.loadImage){
			ImagePicker(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,image: self.$inputImage)
		}
	}
	func loadImage(){
		guard let inputImage = inputImage else {return}
		image = Image(uiImage: inputImage)
	}
}

struct TagEditor: View {
	@Binding var myTag: washTagInfo
	@State var shouldPresentWashSelector = false
	var body: some View{
		List{
			if myTag.wash != nil{
				DetialView(input: myTag.wash!)
			}else{
				VStack{
					HStack{
						Image("WashSymbol").resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.secondary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
						Spacer()
						Text("還沒有選擇標籤").foregroundColor(Color.secondary)
					}
				}
			}
		}
	}
}

struct ClothesDetialView: View {
	
	@State var name: String?
	@State var owner: String?
	@State var image: Data?
	@State var myTag: washTagInfo?
	
	
	var body: some View{
		Text("Hello")
	}
	
}

struct WardrobeView_Previews: PreviewProvider {
	static var previews: some View {
		WardrobeView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
	}
}
