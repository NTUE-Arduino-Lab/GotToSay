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
			List{
				if myTag.wash != nil{
					DetialView(input: myTag.wash!)
				}
				if myTag.bleach != nil{
					DetialView(input: myTag.bleach!)
				}
				if myTag.tumbleDry != nil{
					DetialView(input: myTag.tumbleDry!)
				}
				if myTag.dry != nil{
					DetialView(input: myTag.dry!)
				}
				if myTag.iron != nil{
					DetialView(input: myTag.iron!)
				}
				if myTag.wetClean != nil{
					DetialView(input: myTag.wetClean!)
				}
				if myTag.dryClean != nil{
					DetialView(input: myTag.dryClean!)
				}
				if myTag.pce != nil{
					DetialView(input: myTag.pce!)
				}
				if myTag.hcs != nil{
					DetialView(input: myTag.hcs!)
				}
			}
	}
}
struct DetialView:View {
	let input: String
	var body: some View{
		VStack{
			HStack{
				Image(input).resizable().renderingMode(.template).scaledToFill().foregroundColor(Color.primary).frame(width: 50.0, height: 50.0).clipShape(Rectangle())
				Spacer()
				Text(TagDetail().tagDetail(input: input))
			}
		}
	}
}


struct preShowTag: View{
	@State var myTag = washTagInfo(wash: "GentleWashAtOrBelow30", bleach: nil, wetClean: nil, dryClean: "DoNotDryClean", tumbleDry: nil, dry: nil, pce: nil, hcs: nil, iron: nil)
	
	var body:some View{
		ShowTag(myTag:$myTag)
	}
	
}

struct ShowTag_Previews: PreviewProvider {
	static var previews: some View {
		preShowTag()
	}
}
