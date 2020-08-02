//
//  SwiftUIView.swift
//  GotToSay
//
//  Created by e2ne0 on 2020/8/1.
//  Copyright © 2020 god. All rights reserved.
//

import SwiftUI

struct LaunchScreenView: View {
	static var shouldAnimate = true
	@State var iconScale:CGFloat = 0 //0 -> 100
	@State var shadowScale:CGFloat = 0 //0 -> 110
	@State var rotation = 90.0 //90.0 -> 0.0
	@State var topLineHeight:CGFloat = 0 //0 -> 60 -> 0
	@State var topLinePos:CGFloat = -85 // -85 -> -250
	@State var circlePos:CGFloat = 0 // 0 -> -300 ->0
	@State var circleAlpha = 0.0 // 0 -> 1 appear
	@State var botLineWidthAppear:CGFloat = 0.0 // 0 -> 170
	@State var botLineWidthDisappear:CGFloat = 0.0 // 0 -> 170
	@State var botLineAlpha = 1.0 // 1 -> 0
	@State var textPos:CGFloat = 120.0 // 120 -> 150
	@State var textAlpha = 0.0 // 0 -> 1
	@State var circleScale:CGFloat = 1.0 // 1 -> 1000

    var body: some View {
		ZStack{
			HStack{
				RoundedRectangle(cornerRadius: 15).frame(width: 3.0, height: self.topLineHeight).offset(y: topLinePos).foregroundColor(.primary).colorInvert()
				RoundedRectangle(cornerRadius: 15).frame(width: 3.0, height: self.topLineHeight).offset(y: topLinePos + 15.0).foregroundColor(.primary).colorInvert()
			}
			Circle().frame(width: 35.0, height: 35.0).offset(y: circlePos).opacity(self.circleAlpha).foregroundColor(.primary).colorInvert().scaleEffect(self.circleScale)
			Group{
				Image("Shadow").resizable().scaledToFit().frame(height: self.shadowScale).offset(x: 5, y: 5)
				Image("WashMachine").resizable().scaledToFit().rotationEffect(.degrees(self.rotation)).frame(height: self.iconScale).onAppear(perform: runAnimationPart1)
			}
			RoundedRectangle(cornerRadius: 15).frame(width: self.botLineWidthAppear, height: 3.0).offset(y: 130).opacity(self.botLineAlpha)
			RoundedRectangle(cornerRadius: 15).frame(width: self.botLineWidthDisappear, height: 3.0).offset(y: 130).foregroundColor(Color(UIColor(named: "LaunchBackground")!)).opacity(self.botLineAlpha)
			
			Text("GOT TO SAY").font(.system(size:30, weight:.semibold)).italic().offset(y: self.textPos).opacity(self.textAlpha)
				
		}.background(Rectangle().scale(100.0).foregroundColor(Color(UIColor(named: "LaunchBackground")!)))
		
	}
}
extension LaunchScreenView {
	var rotateAnimationDuration: Double { return 0.5 }
	var topLineExitDuration: Double {return 0.3}
	var circleDuration: Double {return 0.3}
	var botLineDuration: Double {return 0.3}
	func runAnimationPart1() {
		withAnimation(.easeIn(duration: rotateAnimationDuration)) {
			self.rotation = 0
			self.iconScale = 100
		}
		withAnimation(Animation.easeIn(duration: rotateAnimationDuration).delay(0.2)) {
			self.topLineHeight = 100.0
			self.topLinePos = -250
			self.circleAlpha = 1.0
		}
		withAnimation(Animation.easeOut(duration: circleDuration).delay(0.5)){
			self.circlePos = -300
		}
		withAnimation(Animation.easeOut(duration: botLineDuration).delay(1.1)){
			self.botLineWidthAppear = 170
		}
		withAnimation(Animation.easeIn(duration: botLineDuration).delay(1.3)){
			self.botLineWidthDisappear = 170
			
		}
		withAnimation(Animation.easeIn(duration: botLineDuration).delay(1.2)){
			self.textPos = 150
			self.textAlpha = 1.0
		}
		
		
		
		let deadline: DispatchTime = .now() + rotateAnimationDuration
		DispatchQueue.main.asyncAfter(deadline: deadline) {
		  withAnimation(.easeOut(duration: self.topLineExitDuration)) {
			self.topLineHeight = 0
			}
			withAnimation(Animation.easeIn(duration: self.circleDuration).delay(0.35)) {
			  self.circlePos = 0
			}
			withAnimation(Animation.easeIn(duration: self.rotateAnimationDuration).delay(0.35)) {
				self.shadowScale = 110
			}
			withAnimation(Animation.easeIn(duration: 0.1).delay(1.3)){
				self.botLineWidthDisappear = 0
				self.botLineWidthAppear = 0
			}
			withAnimation(Animation.easeIn(duration: self.botLineDuration).delay(1.4)){
				self.circleScale = 100
			}
		}
	}
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
		Group{
			LaunchScreenView()

			LaunchScreenView().environment(\.colorScheme, .dark)
		}
    }
}
