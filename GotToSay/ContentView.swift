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
    @State private var testCppleD = CppleD(number:1,name: "我是第一台洗衣機", first: "台北市大安區和平東路二段134號", member: "apple",imagename:"goforward.90")
    @State private var launName = ""
    var body: some View {
        VStack {
                TabView {
                    NavigationView {
                    //視窗１
                        MapSearchView()
                    }

                        .tabItem {NavigationLink(destination: MapSearchView()) {
                                Image("nav_map_blue")
                                    .tag(0)
                            }
                                
                        }
                    //視窗２
                    ToMemo(launname: launName)
                    .tabItem {
                        NavigationLink(destination: MemoView(CppleData: CppleData, Cpple: testCppleD))
                                {Image("nav_porfile_blue")}.tag(1)
                        
                    }
                    //視窗３
                    WardrobeView()
                        .tabItem {
                            NavigationLink(destination: WardrobeView()) {
                                    Image("nav_wardrobe_blue")}.tag(2)
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

    @State private var show = true
    @State private var launName = ""
    init(){
        locationFetcher.start()
    }

    func makepoint(){
        print("makepoint()：我是用來顯示標記點的")
        for Laundrys in info{
            let newLocation = MKPointAnnotation()
            newLocation.title = Laundrys.Name
            newLocation.subtitle = Laundrys.Address
            newLocation.coordinate = CLLocationCoordinate2D(latitude: Laundrys.Latitude, longitude: Laundrys.Longitude)
            locations.append(newLocation)
        }
    }
    var body: some View {
        
        ZStack(alignment: .top) {

            MapView(centerCoordinate: $centerCoordinate, mapViewState: mapViewState, annotations: $locations)
            .onAppear {
                self.makepoint()
            }

            VStack {
                SearchBar(text: $searchText)
                    .frame(minWidth: 0, maxWidth: 260)
                    .padding(.top, 7.0)
                if searchText.isEmpty{
                    
                }else{

                HStack {
                        List(info.filter({ searchText.isEmpty ? true : $0.Name.contains(searchText) })) { item in
                            NavigationLink(destination: ToMemo(launname: item.Name)) {
                        Button(action: {
                            
                            
                            print(item.Name)})
                        {
                        Image(systemName: "flag.fill")}
                        Text(item.Name)
                            .font(.subheadline)
                            .padding(.horizontal,10)
                            }
                    }
                        .background(Color.white)
                        .frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 250)
                        .shadow(radius: 3)
                        .border(Color.black.opacity(0.4), width: 1)

                    }
                    
                    
                }
            }


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
                    .hidden()
                    
                    
                }
                Spacer()
            }
            }
            
         .navigationBarHidden(true)
         .navigationBarTitle("")
    }
}
struct ToMemo: View {
    @State  var  launname: String
    var body: some View {
    VStack{
            Text(launname)
        BarView(name: launname)
            List(CppleData) { CppleD in
                MemoView(CppleData: CppleData, Cpple: CppleD)
            }
        }
        .navigationBarTitle (Text(""), displayMode: .inline)
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
