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
			}
		}
    }
}

class TagDetail {
	
	func tagDetail(input:String) -> String {
		if input == "WashSymbol"{
			let detail = "水洗"
			return detail
		}
		if input == "WashAtOrBelow95"{
			let detail = "洗滌最高水溫95度"
			return detail
		}
		if input == "WashAtOrBelow70"{
			let detail = "洗滌最高水溫70度"
			return detail
		}
		if input == "WashAtOrBelow60"{
			let detail = "洗滌最高水溫60度"
			return detail
		}
		if input == "WashAtOrBelow50"{
			let detail = "洗滌最高水溫50度"
			return detail
		}
		if input == "WashAtOrBelow40"{
			let detail = "洗滌最高水溫40度"
			return detail
		}
		if input == "WashAtOrBelow30"{
			let detail = "洗滌最高水溫30度"
			return detail
		}
		if input == "VeryGentleWetCleaning"{
			let detail = "非常溫和專業濕洗"
			return detail
		}
		if input == "VeryGentleWashAtOrBelow40"{
			let detail = "水溫40度非常溫和洗滌"
			return detail
		}
		if input == "VeryGentleWashAtOrBelow30"{
			let detail = "水溫30度非常溫和洗滌"
			return detail
		}
		if input == "TumbleDryingNormal"{
			let detail = "不可烘乾"
			return detail
		}
		if input == "TumbleDryingLowTemperature"{
			let detail = "可低溫烘乾"
			return detail
		}
		if input == "ProfessionalWetCleaning"{
			let detail = "溫和專業濕洗"
			return detail
		}
		if input == "ProfessionalCleaningSymbol"{
			let detail = "以烴類溶劑清洗（乾洗）"
			return detail
		}
		if input == "PCE"{
			let detail = "以四氯乙烯溫和清洗"
			return detail
		}
		if input == "Non-chlorineBleachWhenNeeded"{
			let detail = "無氧漂白"
			return detail
		}
		if input == "LineDryInShade"{
			let detail = "在陰涼處懸掛晾乾"
			return detail
		}
		if input == "LineDry"{
			let detail = "懸掛晾乾"
			return detail
		}
		if input == "IroningSymbol"{
			let detail = "熨燙"
			return detail
		}
		if input == "IronAtMediumTemperature"{
			let detail = "熨斗底板最高溫度150°C"
			return detail
		}
		if input == "IronAtLowTemperature"{
			let detail = "熨斗底板最高溫度110°C"
			return detail
		}
		if input == "IronAtHighTemperature"{
			let detail = "熨斗底板最高溫度200°C"
			return detail
		}
		if input == "HCS"{
			let detail = "以烴類溶劑溫和清洗"
			return detail
		}
		if input == "HandWash"{
			let detail = "手洗（水溫最高40度）"
			return detail
		}
		if input == "GentleWetCleaning"{
			let detail = "非常溫和專業濕洗"
			return detail
		}
		if input == "GentleWashAtOrBelow60"{
			let detail = "最高洗滌溫度60°C，溫和洗滌"
			return detail
		}
		if input == "GentleWashAtOrBelow50"{
			let detail = "最高洗滌溫度50°C，溫和洗滌"
			return detail
		}
		if input == "GentleWashAtOrBelow40"{
			let detail = "最高洗滌溫度40°C，溫和洗滌"
			return detail
		}
		if input == "GentleWashAtOrBelow30"{
			let detail = "最高洗滌溫度30°C，溫和洗滌"
			return detail
		}
		if input == "GentleCleaningWithPCE"{
			let detail = "以四氯乙烯非常溫和清洗"
			return detail
		}
		if input == "GentleCleaningWithHCS"{
			let detail = "以烴類溶劑非常溫和清洗"
			return detail
		}
		if input == "FlatDripInShade"{
			let detail = "在陰涼處平放滴乾"
			return detail
		}
		if input == "FlatDrip"{
			let detail = "平放滴乾"
			return detail
		}
		if input == "DryingSymbol"{
			let detail = "乾燥"
			return detail
		}
		if input == "DryFlatInShade"{
			let detail = "在陰涼處平放晾乾"
			return detail
		}
		if input == "DryFlat"{
			let detail = "平放晾乾"
			return detail
		}
		if input == "DripDryInShade"{
			let detail = "在陰涼處掛乾"
			return detail
		}
		if input == "DripDry"{
			let detail = "掛乾"
			return detail
		}
		if input == "DoNotWash"{
			let detail = "不可水洗"
			return detail
		}
		if input == "DoNotTumbleDry"{
			let detail = "不可烘乾"
			return detail
		}
		if input == "DoNotIron"{
			let detail = "不可燙熨"
			return detail
		}
		if input == "DoNotDryClean"{
			let detail = "不可乾洗"
			return detail
		}
		if input == "DoNotBleach"{
			let detail = "不可漂白"
			return detail
		}
		if input == "BleachingSymbol"{
			let detail = "允洗任何漂白劑"
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
