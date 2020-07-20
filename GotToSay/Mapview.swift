import SwiftUI
import MapKit
import CoreLocation


struct MapView: UIViewRepresentable{
    let locationFetcher = LocationFetcher()
    var latDelta = 25.024
    var longDelta = 121.545
    //var latDelta = self.locationFetcher.latitude
    //var longDelta = self.locationFetcher.latitude
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = mapView as? MKMapViewDelegate
        return mapView
    }
    
     func updateUIView(_ uiView: MKMapView, context: Context) {
        let locationFetcher = LocationFetcher()
        locationFetcher.start()
        print("hi")


        let coordinate = CLLocationCoordinate2D(latitude: latDelta, longitude: longDelta)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.title = "我的位置"

        objectAnnotation.coordinate = CLLocation(latitude: latDelta, longitude: longDelta).coordinate

        uiView.addAnnotation(objectAnnotation)
        
        
    }

        
    }
class LocationFetcher: NSObject, CLLocationManagerDelegate {

    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var latitude:Double = 0.0
    var longitude:Double = 0.0

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // lastKnownLocation = locations.first?.coordinate
        lastKnownLocation = (locations.first?.coordinate)!
        latitude = lastKnownLocation!.latitude
        longitude = lastKnownLocation!.longitude
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
