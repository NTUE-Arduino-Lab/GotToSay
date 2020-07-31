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
    init(){
        UITabBar.appearance().backgroundColor = UIColor.gray
    }
	@State var selection = 0
    var body: some View {
        VStack {
			TabView(selection:self.$selection) {
				//tab 0
				NavigationView {
					MapSearchView()
				}.tabItem {
					Image("nav_map_blue").renderingMode(.template)
				}.tag(0)
				//tab 1
				Memberview().tabItem {
					Image("nav_porfile_blue").renderingMode(.template)
				}.tag(1)
				//tab 2
				WardrobeView().tabItem {
					Image("nav_wardrobe_blue").renderingMode(.template)//}
				}.tag(2)
			}
		}
	}
}



struct MapSearchView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @ObservedObject var mapViewState = MapViewState()
    var locationFetcher = LocationFetcher()

    @State private var searchText = ""
    @State private var isEditing = false

    @State private var messText = ""
    @State private var show = true

    @State private var launName = ""
    //控制地圖視圖
    @State private var displayModal:Bool = false
    @State  private var displayName: String = "1逢甲洗衣店"
    @State  private var displayAddress: String = "台中市西屯區文華路100號"
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
        
        ZStack {

            MapView(centerCoordinate: $centerCoordinate, mapViewState: mapViewState, annotations: $locations, text: $messText ,displayModal: $displayModal, displayName:$displayName,displayAddress:$displayAddress)
            .onAppear(perform: makepoint)

            VStack {
                SearchBar(text: $searchText)
                    .padding(.top, 5.0)

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
				Spacer()

            }.keyboardAdaptive()

                .opacity(show ? 1 : 0)

            VStack{
/*               HStack {
//                    Spacer()
//                    Button(action: {
//                        if self.show {
//                            self.show = false
//                        }else{
//                            self.show = true
//                        }
//                        print("我是對話框")
//                    }) {
//                        Image(systemName: "lightbulb")
//                    }
//                    .padding()
//                    .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
//                    .background(Color.white.opacity(0.75))
//                    .foregroundColor(.blue)
//                    .font(.headline)
//                    .cornerRadius(30)
//
//
//                }
                 
 */             Spacer()
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
				
                .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
                 .background(Color.white)
                .foregroundColor(.blue)
                .font(.headline)
                    .clipShape(Circle())

                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black.opacity(0.4), lineWidth: 2)
                )
                }.padding([.top,.trailing])
                //測試用得

                    .padding(.bottom)

             }
        }
        //.navigationBarHidden(false)
            .navigationBarTitle (Text("洗衣地圖"), displayMode: .inline)
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
    }
   // .navigationBarHidden(true)
    .navigationBarTitle (Text(""),displayMode: .inline)

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
