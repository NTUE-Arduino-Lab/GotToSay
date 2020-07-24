//
//  ShowTag.swift
//  GotToSay
//
//  Created by e2ne0 on 2020/7/24.
//  Copyright © 2020 god. All rights reserved.
//

import SwiftUI

struct ShowTag: View {
	@Binding var myTag:washTagInfo
    var body: some View {
		VStack{
			HStack{
				if myTag.wash != nil{
					Image(myTag.wash!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
				if myTag.bleach != nil{
					Image(myTag.bleach!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
				if myTag.tumbleDry != nil{
					Image(myTag.tumbleDry!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
				if myTag.dry != nil{
					Image(myTag.dry!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
				if myTag.iron != nil{
					Image(myTag.iron!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
			}
			HStack{
				if myTag.wetClean != nil{
					Image(myTag.wetClean!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
				if myTag.dryClean != nil{
					Image(myTag.dryClean!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
				if myTag.pce != nil{
					Image(myTag.pce!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
				if myTag.hcs != nil{
					Image(myTag.hcs!).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				}
				Text(TagDetail().tagDetail(input: myTag.wash ?? ""))
			}
		}
		
    }
}

class TagDetail {
	
	func tagDetail(input:String) -> String {
		if input == "GentleWashAtOrBelow30"{
			let detail = "我要怎麼洗"
			return detail
		}
		if input == "洗標"{
			let detail = "我要怎麼洗"
			return detail
		}
		if input == "洗標"{
			let detail = "我要怎麼洗"
			return detail
		}
		
		return ""
	}
	
}


struct preShowTag: View{
	@State var myTag = washTagInfo(wash: "GentleWashAtOrBelow30", bleach: nil, wetClean: nil, dryClean: nil, tumbleDry: nil, dry: nil, pce: nil, hcs: nil, iron: nil)
	
	var body:some View{
		ShowTag(myTag:$myTag)
	}

}

struct ShowTag_Previews: PreviewProvider {
    static var previews: some View {
		preShowTag()
    }
}
