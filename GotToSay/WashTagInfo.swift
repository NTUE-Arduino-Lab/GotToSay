//
//  WashTagInfo.swift
//  HelloSwiftUI
//
//  Created by e2ne0 on 2020/7/16.
//  Copyright © 2020 e2ne0. All rights reserved.
//

struct washTagInfo: Codable {
	var	wash: String?
	var bleach: String?
	var wetClean: String?
	var dryClean: String?
	var tumbleDry: String?
	var dry: String?
	var pce: String?
	var hcs: String?
	var iron: String?
}
class sendTag{
	static let send = sendTag()
	var data:washTagInfo?
	private init() {}
}
