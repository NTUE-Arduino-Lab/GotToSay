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
					Circle().fill(Color.secondary)
					if self.image != nil{
						self.image?.resizable()
					}else{
						Text("Tap to select a pic").foregroundColor(.white).font(.headline)
					}
				}.onAppear(perform: self.loadImage)
					.padding(.horizontal)
					.frame(width: 250.0, height: 250.0)
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
					ActionSheet(title: Text("你想要從哪裡加入標呢？"), buttons:
						[ActionSheet.Button.default(Text("相機掃描"), action: {
							self.shouldPresentTagScan = true
						}), ActionSheet.Button.default(Text("自己編輯"), action: {
							self.shouldPresentTagEdit = true
						}), ActionSheet.Button.cancel()])
					//							selector(list: TagType.wash))
				}.sheet(isPresented: self.$shouldPresentTagScan){
					myController(washTag: self.$myTag)
				}.sheet(isPresented: self.$shouldPresentTagEdit){
					TagEditor(myTag: self.$myTag)
				}
				Spacer()
			}.keyboardAdaptive()
			
		}.navigationBarTitle("增加衣服",displayMode: .automatic)
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
	//	func selector(list:[String]) -> [ActionSheet.Button] {
	//		var myButton :[ActionSheet.Button] = []
	//		list.forEach{value in
	//			myButton.append(ActionSheet.Button.default(Text(value)
	//			, action: {print(value)}))
	//
	//		}
	//		myButton.append(ActionSheet.Button.cancel())
	//		return myButton
	//	}
}

struct TagEditor: View {
	@Binding var myTag: washTagInfo
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View{
		NavigationView{
			List{
				TagList(input: self.$myTag.wash, Tags: TagType.wash)
				TagList(input: self.$myTag.bleach, Tags: TagType.bleach)
				TagList(input: self.$myTag.tumbleDry, Tags: TagType.tumbleDry)
				TagList(input: self.$myTag.dry, Tags: TagType.dry)
				TagList(input: self.$myTag.iron, Tags: TagType.iron)
				TagList(input: self.$myTag.dryClean, Tags: TagType.dryClean)
				TagList(input: self.$myTag.wetClean, Tags: TagType.wetClean)
				TagList(input: self.$myTag.pce, Tags: TagType.pce)
				TagList(input: self.$myTag.hcs, Tags: TagType.hcs)
			}.navigationBarTitle(Text("標籤編輯")).navigationBarItems(trailing: Button(action: {self.presentationMode.wrappedValue.dismiss()}){
				Text("完成")
			})
		}
	}
}
struct TagList:View {
	@Binding var input: String?
	@State var select = false
	let Tags:Array<String>
	var body: some View{
		NavigationLink(destination:TagSelector(myTag: self.$input, state: self.$select, Tags: Tags),isActive: self.$select){
			if input != nil{
				DetialView(input: input!)
					.onTapGesture {
						self.select = true
				}
			}else{
				HStack{
					Image(Tags[0]).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.secondary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
					Spacer()
					Text("還沒有選擇標籤").foregroundColor(Color.secondary)
				}.onTapGesture {
					self.select = true
				}
			}
		}
	}
}

struct TagSelector:View {
	@Binding var myTag: String?
	@Binding var state: Bool
	let Tags:Array<String>
	var body: some View{
		List{
			Button(action: {
				self.myTag = nil
				self.state = false
			}){
				Text("不要選取")
			}
			ForEach(Tags, id: \.self) {theTag in
				Button(action: {
					self.myTag = theTag
					self.state = false
				}){
					DetialView(input: theTag)
				}
			}
		}.navigationBarTitle("請選擇標籤")
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
//		AddClothesView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
	}
}
