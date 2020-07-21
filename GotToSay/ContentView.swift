//
//  ContentView.swift
//  GodToSay
//
//  Created by apple on 2020/7/17.
//  Copyright © 2020 god. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var locations = [MKPointAnnotation]()
    var locationFetcher = LocationFetcher()
    @State private var LaundryInfo_ = LaundryInfo(Num: 5,Name:"洗衣店5",Address:"宜蘭市",Longitude:0.0,Latitude:0.0)
    @State private var testCppleD = CppleD(number:1,name: "我是第一台洗衣機", first: "台北市大安區和平東路二段134號", member: "apple",imagename:"goforward.90")

    func makepoint(){
        for Laundrys in info{
            let newLocation = MKPointAnnotation()
            newLocation.title = Laundrys.Name
            newLocation.subtitle = Laundrys.Address
            newLocation.coordinate = CLLocationCoordinate2D(latitude: Laundrys.Latitude, longitude: Laundrys.Longitude)
            locations.append(newLocation)
     
        }
    }
    var body: some View {
        VStack {
                TabView {
                        MapSearchView(Laundry:LaundryInfo_, info: info
                                    )

                            .tabItem {NavigationLink(destination: MapSearchView(Laundry:LaundryInfo_, info: info)) {
                                Image("nav_map_blue" )
									.tag(0)
                            }

                        }

                        VStack{
                            BarView()
                            List(CppleData) { CppleD in
                                MemoView(CppleData: CppleData, Cpple: CppleD)
                            }
                    }.tabItem {
                        NavigationLink(destination: MemoView(CppleData: CppleData, Cpple: testCppleD))
                                {Image("nav_porfile_blue")}.tag(1)}
                    
                    WardrobeView().tabItem {
                            NavigationLink(destination: WardrobeView()) {
                                    Image("nav_wardrobe_blue") }.tag(2)

                            }
                    }
                }
            }
    }
class  Located: ObservableObject {
    @Published var items = [LaundryInfo]()
}
struct MapSearchView: View {

    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @ObservedObject var mapViewState = MapViewState()

    @ObservedObject var locate = Located()
    var locationFetcher = LocationFetcher()

    @State private var searchText = ""
    @State private var isEditing = false
    var Laundry:LaundryInfo
    var info:[LaundryInfo]
    @State private var show = false

    var body: some View {
        ZStack(alignment: .top) {
            MapView(centerCoordinate: $centerCoordinate, mapViewState: mapViewState, annotations: $locations )
            VStack {
                SearchBar(text: $searchText)
                    .padding(.top, 7.0)
                    
                
                HStack {
                    List(info.filter({ searchText.isEmpty ? true : $0.Name.contains(searchText) })) { item in
                        Button(action: {print(self.$searchText)}) {
                        Image(systemName: "flag.fill")}
                        Text(item.Name)
                            .font(.subheadline)
                            .padding(.horizontal,10)
                    }
                }
                    
                        }
                .background(Color.white)
                .frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 200)
                .shadow(radius: 3)
                .border(Color.black.opacity(0.4), width: 1)
                .opacity(show ? 1 : 0)
            VStack{
                HStack {
                    Spacer()
                    Button(action: {
                        if self.show {
                            self.show = false
                        }else{
                            self.show = true
                        }
                        print("我是對話框")
                        for Laundrys in self.info{
                               let newLocation = MKPointAnnotation()
                               newLocation.title = Laundrys.Name
                               newLocation.subtitle = Laundrys.Address
                               newLocation.coordinate = CLLocationCoordinate2D(latitude: Laundrys.Latitude, longitude: Laundrys.Longitude)
                            self.locations.append(newLocation)
                           }
                    }) {
                        Image(systemName: "lightbulb")
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
                    .background(Color.white.opacity(0.75))
                    .foregroundColor(.blue)
                    .font(.headline)
                    .cornerRadius(30)
                    
                    
                }
                HStack{
                 Spacer()
                 Button(action: {
                    print("回到座標點")
                    self.locationFetcher.start()
                    let location = self.locationFetcher.lastKnownLocation
                    print(location as Any)
                     self.mapViewState.center = location
                    

                 }
                    
                 ) {
                    Image(systemName: "location")
                 }
                .padding()
                .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
                .background(Color.white.opacity(0.75))
                .foregroundColor(.blue)
                .font(.headline)
                .cornerRadius(30)
            
                }
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example location"
                        self.locations.append(newLocation)
                        print("當前位置點：")
                        print(newLocation.coordinate)
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    
                    
                }
                Spacer()
            }

            }
        
    }
}
struct BarView: View {
     var body: some View {
        HStack{
        Image(systemName: "location.circle.fill")
            .foregroundColor(.blue)
            .frame(width: 50, height: 50)
            .font(.title)
            .clipShape(Circle())
            Spacer()
        VStack(alignment: .leading) {
            Text("台北教育大學洗衣機")
                .font(.headline)
                .foregroundColor(Color.blue)

            Text("台北市大安區和平東路二段134號")
                .font(.subheadline)
            .foregroundColor(Color.gray)
                }
            Spacer()
            Button(action: {}) {
               Image(systemName: "ellipsis.circle.fill")
                                      }
             .foregroundColor(.blue)
             .font(.title)
        }
        .padding()
        .background(Color(hue: 0.454, saturation: 0.898, brightness: 0.918, opacity: 0.2))
        
        
    }
}

struct MemoView: View {
    var CppleData: [CppleD]
    var Cpple:CppleD
    var body: some View {
        VStack {
            HStack{
                Image(systemName:Cpple.imagename)
                    .foregroundColor(.blue)
                    .frame(width: 50, height: 50)
                    .font(.largeTitle)
                    .clipShape(Circle())
            
                VStack(alignment: .leading) {
                    Text(Cpple.name)
                        .font(.headline)
                        .foregroundColor(Color.blue)
                            HStack {
                                Text("By")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(Cpple.member)
                                    .font(.subheadline)
                                    .foregroundColor(Color.blue.opacity(0.8))
                                    }
                                            }

                Spacer()
                Button(action: {}) {
                    Image(systemName: "circle.grid.2x2.fill")
                                  }
                                    .foregroundColor(.blue)
                                    .font(.title)
    }
        .padding()
        .background(Color(hue: 0.556, saturation: 0.898, brightness: 0.918, opacity: 0.2))
        .cornerRadius(30)
        }
    }
}

struct WardrobeView: View {
//    @State private var showAlert = false
//    var BppleData: [BppleD]
    var body: some View {
        ARView(name:"YUI",num: 0,myTag: nil)
		}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
