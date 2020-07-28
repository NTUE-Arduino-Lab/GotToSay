//
//  ContentView.swift
//  GodToSay
//
//  Created by apple on 2020/7/17.
//  Copyright © 2020 god. All rights reserved.
//

import SwiftUI
import MapKit
import Combine


struct ContentView: View {
    @State private var MemoInf = MemoInfo(name: "王小花", content: "擋到通知我",role1:true,role2:false,role3:true,laundrynumber: "我是第1台洗衣機", from: "逢甲洗衣店1",time:"goforward.90")
    @State private var launName = "逢甲洗衣店1"
    @State private var launAddress = "台北市大安區和平東路二段118號"
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
                    Memberview()
                        .tabItem {
                            NavigationLink(destination: Memberview()) {
                                   // Image("nav_porfile_blue")}.tag(1)
                                Image(systemName: "equal.square.fill").font(.title)}.tag(1)
                            }
                    /*
                    //視窗２
                    ToMemo(launname: launName, launaddress: launAddress)
                    .tabItem {
                        NavigationLink(destination: ToMemo(launname: launName, launaddress: launAddress))
                                {
                                    Image(systemName: "equal.square.fill").font(.title)}.tag(1)

                    }
 */
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
    
    @State private var messText = ""
    @State private var show = true

    @State private var launName = ""
    //控制地圖視圖
    @State private var displayModal:Bool = false
    @State  private var displayName: String = "逢甲洗衣店1"
    @State  private var displayAddress: String = "台北市大安區和平東路二段118號"
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
            for loca in Memo {
            if Laundrys.Name == loca.from{
                self.messText = loca.content
            }
                
            }
            }

    }
    var body: some View {
        
        ZStack(alignment: .top) {

            MapView(centerCoordinate: $centerCoordinate, mapViewState: mapViewState, annotations: $locations, text: $messText ,displayModal: $displayModal, displayName:$displayName,displayAddress:$displayAddress)
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
                            NavigationLink(destination: ToMemo(launname: item.Name, launaddress: item.Address)) {
                        Button(action: {
                            
                            
                            print(item.Name)})
                        {
                            Image(systemName: "flag.fill").foregroundColor(Color.blue)}
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
                //測試用得
                HStack {
                    Spacer()
                    Button(action: {
                        if self.displayModal{
                            self.displayModal = false}
                        else{
                            self.displayModal = true
                        }
                        /*
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example location"
                        self.locations.append(newLocation)
                        print("當前位置點：")
                        print(newLocation.coordinate)
 */
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.white.opacity(0.75))
                    .foregroundColor(.blue)
                    .font(.headline)
                    .clipShape(Circle())
                     .hidden()
                        .sheet(isPresented: $displayModal) {
                            //NewMemo(Name: self.launName)
                            ToMemo(launname: self.displayName, launaddress: self.displayAddress)
                    }
                   // .hidden()
                    
                }
                
                Spacer()
                
            }

                    
                
            
            }
            
         .navigationBarTitle (Text(""), displayMode: .inline)
    }
}
struct ToMemo: View {
    @State  var  launname: String
    @State  var  launaddress: String

    @State private var showSecondView = false
    
    
    var body: some View {
    VStack{
        BarView(name: launname, address: launaddress)
            List(Memo.filter({ launname.isEmpty ? true : $0.from.contains(launname) })) { item in
                MemoView(MemoInfo: item.laundrynumber, MemoName: item.name)
        }

        HStack {
        Spacer()
            Button(action: {
                if self.showSecondView{
                    self.showSecondView = false}
                else{
                    self.showSecondView = true
                }
            }) {
                Image(systemName: "plus")
                    .sheet(isPresented: $showSecondView) {
                        NewMemo(Name: self.launname)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.75))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
            
        }.padding()

      /*
        List(Memo) { MemoInfo in
                MemoView(MemoInfo: Memo, Memo: MemoInfo)
            }
 */
        }
        
        .navigationBarTitle (Text(""), displayMode: .inline)

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
