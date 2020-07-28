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
	@FetchRequest(entity: MyClothes.entity(), sortDescriptors: []) var myClotheses: FetchedResults<MyClothes>
	@State var addClothes = false
	@State var prossce = false
	var body: some View {
		NavigationView{
			List{
				ForEach(myClotheses, id: \.id){ myClothes in NavigationLink(destination: ClothesDetialView(clothes: myClothes).environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)){
						if myClothes.image != nil{
							Image(uiImage:self.resizeImage(image: UIImage(data: myClothes.image!))).resizable().scaledToFill().frame(width: 150.0, height: 150.0).clipShape(Circle())
						
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
				.navigationBarItems(leading: Button(action: {self.prossce = true}){
					Text("一起洗")
					}, trailing:  NavigationLink(destination: AddClothesView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)){
						Text("新增衣服")
				})
		}.sheet(isPresented: self.$prossce){
			prossceSelector().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
		}
	}
	func removeClothes(at offsets: IndexSet){
		
		for index in offsets {
			let clothes = myClotheses[index]
			moc.delete(clothes)
		}
		do {
			try moc.save()
		} catch {
			// handle the Core Data error
		}
	}
	func resizeImage(image: UIImage?) -> UIImage {
		if image != nil{
			let scale = 150 / image!.size.width
			let newHeight = image!.size.height * scale
		UIGraphicsBeginImageContext(CGSize(width: 150, height: newHeight))
			image!.draw(in: CGRect(x: 0, y: 0, width: 150, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return newImage!
		}
		return UIImage()
	}

}
struct prossceSelector: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: MyClothes.entity(), sortDescriptors: []) var myClotheses: FetchedResults<MyClothes>
	@State var level:Int = -1
	@State var temperature:Int = -1
	@State var bleach:Int = -1
	let ph:CGFloat = 80
	@State var shouldPresentlLevelSheet = false
	var body: some View{
		NavigationView{
		VStack{
			List{
				ForEach(myClotheses, id: \.id){ myClothes in
					prossceList(level: self.$level, temperature: self.$temperature, bleach: self.$bleach, tagProcess: self.getProcess(clothes: myClothes), clothes: myClothes)
				}
			}
			
			Spacer()
			HStack{
				Spacer()
				VStack{
					Text("洗程")
					Picker(selection: self.$level, label: Text("洗程")){
						Text("請選擇洗程").tag(-1)
						Text("手洗").tag(0)
						Text("超柔洗").tag(1)
						Text("柔洗").tag(2)
						Text("一般").tag(3)
						
					}.labelsHidden().frame(width: 120,height:ph).clipped()
					
				}
				Spacer()
				VStack{
					Text("溫度")
					if level == 3{
						Picker(selection: self.$temperature, label: Text("溫度")){
							Text("請選擇溫度").tag(-1)
							Text("30").tag(30)
							Text("40").tag(40)
							Text("50").tag(50)
							Text("60").tag(60)
							Text("70").tag(70)
							Text("95").tag(95)
						}.labelsHidden().frame(width: 120,height:ph).clipped()
					}
					if level == 2{
						Picker(selection: self.$temperature, label: Text("溫度")){
							Text("請選擇溫度").tag(-1)
							Text("30").tag(30)
							Text("40").tag(40)
							Text("50").tag(50)
							Text("60").tag(60)
						}.labelsHidden().frame(width: 120,height:ph).clipped()
					}
					if level == 1{
						Picker(selection: self.$temperature, label: Text("溫度")){
							Text("請選擇溫度").tag(-1)
							Text("30").tag(30)
							Text("40").tag(40)
						}.labelsHidden().frame(width: 120,height:ph).clipped()
					}
					if level == 0{
						Picker(selection: self.$temperature, label: Text("溫度")){
							Text("40").tag(40)
						}.labelsHidden().frame(width: 120,height:ph).clipped()
					}
					if level == -1{
						Picker(selection: self.$temperature, label: Text("溫度")){
							Text("請選擇溫度").tag(-1)
						}.labelsHidden().frame(width: 120,height:ph).clipped()
					}
				}
				Spacer()
				VStack{
					Text("漂白劑")
					Picker(selection: self.$bleach, label: Text("")){
						Text("請選擇漂白劑").tag(-1)
						Text("不加漂白劑").tag(0)
						Text("無氧漂白劑").tag(1)
						Text("我不確定").tag(2)
					}.labelsHidden().frame(width: 130,height:ph).clipped()
					
				}
				Spacer()
			}
			}
		}
//		List{
//			Button(action: {self.shouldPresentlLevelSheet = true}){
//				HStack{
//					if level == -1{
//						Text("請選擇洗程")
//					}
//					if level == -0{
//						Text("超柔洗")
//					}
//					if level == 1{
//						Text("柔洗")
//					}
//					if level == 2{
//						Text("一般")
//					}
//					if level == 3{
//						Text("手洗")
//					}
//					Spacer()
//				}
				
//			}.actionSheet(isPresented: self.$shouldPresentlLevelSheet) { () -> ActionSheet in
//				ActionSheet(title: Text("請選擇洗程"), buttons: [ActionSheet.Button.default(Text("手洗"), action: {
//					self.level = 3
//				}), ActionSheet.Button.default(Text("一般"), action: {
//					self.level = 2
//				}), ActionSheet.Button.default(Text("柔洗"), action: {
//					self.level = 1
//				}), ActionSheet.Button.default(Text("超柔洗"), action: {
//					self.level = 0
//				}),ActionSheet.Button.cancel()])
//			}
//		}
	}
	func getProcess(clothes: MyClothes) -> washProcess {
		TagDetail().process(wash: clothes.wash, bleach: clothes.bleach)
	}
}

struct prossceList: View {
	@Environment(\.managedObjectContext) var moc
	@Binding var level:Int
	@Binding var temperature:Int
	@Binding var bleach:Int
	@State var tagProcess:washProcess
	@State var clothes: MyClothes
	var body: some View{
		
		HStack{
			if self.tagProcess.level >= self.level && self.tagProcess.temperature <= self.temperature && self.tagProcess.bleach >= self.bleach
			{
				NavigationLink(destination: ClothesDetialView(clothes: clothes).environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)){
					if clothes.image != nil{
						Image(uiImage:self.resizeImage(image: UIImage(data: clothes.image!))).resizable().scaledToFill().frame(width: 150.0, height: 150.0).clipShape(Circle())
					
				}else{
					Image (systemName: "camera").padding().frame(width: 150.0, height: 150.0).clipShape(Circle())
				}
				VStack(alignment: .leading) {
					Text(clothes.name!).font(.title)
					Text(clothes.owner ?? "Mine").font(.subheadline).foregroundColor(Color.secondary)
				}
				}
			}
		}
	}
	func resizeImage(image: UIImage?) -> UIImage {
		if image != nil{
			let scale = 150 / image!.size.width
			let newHeight = image!.size.height * scale
		UIGraphicsBeginImageContext(CGSize(width: 150, height: newHeight))
			image!.draw(in: CGRect(x: 0, y: 0, width: 150, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return newImage!
		}
		return UIImage()
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
		
		VStack{
			VStack{
				ZStack{
					Circle().fill(Color.secondary).frame(width:250,height: 250)
					if self.image != nil{
						self.image?.resizable().scaledToFill()
					}else{
						Text("Tap to select a pic").foregroundColor(.white).font(.headline)
					}
					
				}
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
			}.onAppear(perform: self.loadImage)
				.frame(width:250,height: 250)
			.clipShape(Circle())
								.onTapGesture {
					self.shouldPresentImageActionSheet = true
			}
			_TextField(title: "哪件衣服", text: self.$name).frame(height: 40.0).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 2)).padding(.horizontal)
			_TextField(title: "誰的衣服", text: self.$owner).frame(height: 40.0).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 2)).padding(.horizontal)
			if myTag != washTagInfo(){
				ShowTag(myTag: self.$myTag)
			}
			Spacer()
			Button(action: {self.shouldPresentTagActionSheet = true}){
				ZStack{
					RoundedRectangle(cornerRadius: 15).fill(Color.gray).frame(width: 150, height: 50)
					Text("加入標籤").foregroundColor(Color.primary)
				}
				
			}.actionSheet(isPresented: self.$shouldPresentTagActionSheet) { () -> ActionSheet in
				ActionSheet(title: Text("你想要從哪裡加入標呢？"), buttons:
					[ActionSheet.Button.default(Text("相機掃描"), action: {
						self.shouldPresentTagEdit = true
						self.shouldPresentTagScan = true
					}), ActionSheet.Button.default(Text("自己編輯"), action: {
						self.shouldPresentTagEdit = true
					}), ActionSheet.Button.cancel()])
			}.sheet(isPresented: self.$shouldPresentTagEdit){
			if self.shouldPresentTagScan{
				myController(washTag: self.$myTag)
			}else{
				TagEditor(myTag: self.$myTag)

			}
					}.navigationBarTitle("增加衣服",displayMode: .automatic).navigationBarItems(trailing: Button(action: {
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
			Spacer()
		}
		.keyboardAdaptive()
	}
	func resizeImage(image: UIImage?) -> UIImage {
		if image != nil{
			let scale = 250 / image!.size.width
			let newHeight = image!.size.height * scale
		UIGraphicsBeginImageContext(CGSize(width: 250, height: newHeight))
			image!.draw(in: CGRect(x: 0, y: 0, width: 250, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return newImage!
		}
		return UIImage()
	}

	func loadImage(){
		guard let inputImage = inputImage else {return}
		var reSize:UIImage = self.resizeImage(image: inputImage)
		image = Image(uiImage: reSize)
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
			HStack{
			Button(action: {
				self.myTag = nil
				self.state = false
			}){
				Text("不要選取")
				}
			Spacer()
			if  self.myTag == nil{
				Image(systemName: "checkmark.circle.fill").imageScale(.large).foregroundColor(.accentColor)

			}else{
				Image(systemName: "checkmark.circle").imageScale(.large).foregroundColor(.secondary)
			}

			}
			ForEach(Tags, id: \.self) {theTag in
				Button(action: {
					self.myTag = theTag
					self.state = false
				}){
					HStack{
					DetialView(input: theTag)
					if theTag == self.myTag{
						Image(systemName: "checkmark.circle.fill").imageScale(.large).foregroundColor(.accentColor)

					}else{
						Image(systemName: "checkmark.circle").imageScale(.large).foregroundColor(.secondary)
						
						}
					}
				}
			}
		}.navigationBarTitle("請選擇標籤")
	}
}

struct ClothesDetialView: View {
	@Environment(\.managedObjectContext) var moc
	var clothes:MyClothes
	@State var myTag = washTagInfo()
	@State var editMode = false
	@State var inputImage: UIImage?
	@State var name: String = ""
	@State var owner: String = ""
	@State var shouldPresentTagActionSheet = false
	@State var shouldPresentTagScan = false
	@State var shouldPresentTagEdit = false
	@State var goSave = false
	@State var shouldPresentImagePicker = false
	@State var shouldPresentImageActionSheet = false
	@State var shouldPresentCamera = false
	func loadTag() {
		self.myTag = washTagInfo(wash: clothes.wash, bleach: clothes.bleach, wetClean: clothes.wetClean, dryClean: clothes.dryClean, tumbleDry: clothes.tumbleDry, dry: clothes.dry, pce: clothes.pce, hcs: clothes.hcs, iron: clothes.iron)
		if clothes.owner != nil{
			self.owner = clothes.owner!
		}
		if clothes.name != nil{
			self.name = clothes.name!
		}
	}
	
	var body: some View{
		VStack{
			if !editMode{
				VStack{
					VStack{
					if self.clothes.image != nil{
						Image(uiImage: resizeImage(image: UIImage(data: self.clothes.image!))).resizable().scaledToFill()
					}else{
						ZStack{
							Circle().fill(Color.gray).frame(width:250, height:250)
							Image(systemName: "photo").resizable().scaledToFill().frame(width:150, height:150)
						}
					}
					}.frame(width:250,height: 250)
						.clipShape(Circle())
					if clothes.owner != nil{
						Text(clothes.owner!+"的衣服")
					}else{
						Text("")
					}

					Form{
						Section{
							if myTag != washTagInfo(){
								ShowTag(myTag: self.$myTag)
							}

						}
					}
									
				Spacer()

				}
			}else{
				VStack{
					ZStack{
						Circle().fill(Color.secondary).frame(width:250,height: 250)
						if self.inputImage != nil{
							Image(uiImage: resizeImage(image: self.inputImage)).resizable().scaledToFill()
						}else{
							if self.clothes.image != nil{
								Image(uiImage: resizeImage(image: UIImage(data: self.clothes.image!))).resizable().scaledToFill()
							}else{
								Text("Tap to select a pic").foregroundColor(.white).font(.headline)
							}
						}
						
					}
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
				}.onAppear(perform: self.loadImage)
					.frame(width:250,height: 250)
					.clipShape(Circle())
					.onTapGesture {
						self.shouldPresentImageActionSheet = true
				}
				_TextField(title: self.name, text: self.$name).frame(height: 40.0).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 2)).padding(.horizontal)
				_TextField(title: self.owner, text: self.$owner).frame(height: 40.0).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 2)).padding(.horizontal)
				if myTag != washTagInfo(){
					ShowTag(myTag: self.$myTag)
				}
				Spacer()
				Button(action: {self.shouldPresentTagActionSheet = true}){
					ZStack{
						RoundedRectangle(cornerRadius: 15).fill(Color.gray).frame(width: 150, height: 50)
						Text("加入標籤").foregroundColor(Color.primary)
					}
					
				}.actionSheet(isPresented: self.$shouldPresentTagActionSheet) { () -> ActionSheet in
					ActionSheet(title: Text("你想要從哪裡加入標呢？"), buttons:
						[ActionSheet.Button.default(Text("相機掃描"), action: {
							self.shouldPresentTagEdit = true
							self.shouldPresentTagScan = true
						}), ActionSheet.Button.default(Text("自己編輯"), action: {
							self.shouldPresentTagEdit = true
						}), ActionSheet.Button.cancel()])
				}.sheet(isPresented: self.$shouldPresentTagEdit){
					if self.shouldPresentTagScan{
						myController(washTag: self.$myTag)
					}else{
						TagEditor(myTag: self.$myTag)
						
					}
				}
				Spacer()
				
			}
			}.keyboardAdaptive()
			.onAppear(perform: self.loadTag)
			.navigationBarTitle(Text(clothes.name ?? ""))
			.navigationBarItems(trailing: Button(action: {
				if self.editMode{
					let chooseName = self.name
					let chooseOwner = self.owner
					self.clothes.name = "\(chooseName)"
					self.clothes.owner = "\(chooseOwner)"
					self.clothes.bleach = self.myTag.bleach
					self.clothes.dry = self.myTag.dry
					self.clothes.dryClean = self.myTag.dryClean
					self.clothes.hcs = self.myTag.hcs
					self.clothes.iron = self.myTag.iron
					self.clothes.pce = self.myTag.pce
					self.clothes.tumbleDry = self.myTag.tumbleDry
					self.clothes.wash = self.myTag.wash
					self.clothes.wetClean = self.myTag.wetClean
					if self.inputImage != nil{
						self.clothes.image = self.inputImage?.jpegData(compressionQuality: 1.0)
						
					}
					try? self.moc.save()
				}
				self.editMode = !self.editMode}){
					if !editMode{
						Text("編輯")
					}else{
						Text("完成")
					}
			})
	}
	func resizeImage(image: UIImage?) -> UIImage {
		if image != nil{
			let scale = 250 / image!.size.width
			let newHeight = image!.size.height * scale
			UIGraphicsBeginImageContext(CGSize(width: 250, height: newHeight))
			image!.draw(in: CGRect(x: 0, y: 0, width: 250, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return newImage!
		}
		return UIImage()
	}
	func loadImage(){
		guard let inputImage = inputImage else {return}
		let reSize:UIImage = self.resizeImage(image: inputImage)
		self.clothes.image = reSize.jpegData(compressionQuality: 1.0)
		
	}
}

struct WardrobeView_Previews: PreviewProvider {
	static var previews: some View {
		WardrobeView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
		//		AddClothesView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
	}
}
