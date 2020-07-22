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
	var body: some View {
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
		}
	}
}

struct WardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeView()
    }
}
