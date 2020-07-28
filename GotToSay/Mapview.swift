import SwiftUI
import MapKit
import CoreLocation


class MapViewState: ObservableObject {
    var span: MKCoordinateSpan?
    @Published var center: CLLocationCoordinate2D?

    
}

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @ObservedObject var mapViewState: MapViewState    
    @Binding var annotations: [MKPointAnnotation]
    @Binding var text: String
    
    
    @Binding var displayModal: Bool
    @Binding  var displayName: String
    @Binding  var displayAddress: String

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        //逢甲座標
        let center = CLLocationCoordinate2D(latitude: 24.178693 , longitude: 120.646740)
        let region = MKCoordinateRegion(center: center,
                                    latitudinalMeters: CLLocationDistance(1000),
                                    longitudinalMeters: CLLocationDistance(1000))
        mapView.setRegion(region, animated: true)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
       // print(displayModal)
        // Set the map display region
        if var center = mapViewState.center {
            var region: MKCoordinateRegion
            
            if var span = mapViewState.span {
                center = CLLocationCoordinate2D(latitude: 24.178693, longitude: 120.646740)

                span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                region = MKCoordinateRegion(center: center,
                                            span: span)
            } else {
                region = MKCoordinateRegion(center: center,
                                            latitudinalMeters: CLLocationDistance(500),
                                            longitudinalMeters: CLLocationDistance(500))
            }
            view.setRegion(region, animated: true)

            mapViewState.center = nil
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self, displayModal: $displayModal,displayName:$displayName,displayAddress:$displayAddress)
    }
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        var count = 0
        @Binding  var displayModal: Bool
        @Binding  var displayName: String
        @Binding  var displayAddress: String

        
        init(_ parent: MapView,displayModal:Binding<Bool>,displayName:Binding<String>,displayAddress:Binding<String>) {
            self.parent = parent
            self._displayModal = displayModal
             self._displayName = displayName
             self._displayAddress = displayAddress
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
           // print(parent.centerCoordinate)
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "placemark"

            // attempt to find a cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            //annotationView?.image = UIImage(named: "nav_map_blue")

            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.image = UIImage(named: "icon_map.png")
                //這裡是圖片樣子
                let infoButton = UIButton(type: .detailDisclosure)
                infoButton.setImage(UIImage(named: "nav_map_blue"), for: [] )
                // 按鈕按下後的動作
                infoButton.addTarget(self, action: #selector(Coordinator.onClickDetailButton(_:forEvent:)),
                 for: UIControl.Event.touchUpInside)
                annotationView?.rightCalloutAccessoryView = infoButton

                                  
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
            @objc func onClickDetailButton(_ sender: Any, forEvent event: UIEvent) {
                
                if count >= 1{
                self.displayModal = true
                }
                count = count+1
                if count >= 2{
                    count = 0
                }
            }

        func mapView(_ mapView: MKMapView,annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

          for loca in Memo {
            if view.annotation?.title == loca.from{
                var accessoryView: UIView
                //不完整程式碼Memo.count
                let count :Int = 5 - Memo.count
                let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                textView.text = loca.name+":  "+"\n"+loca.content+"\n\n\n使用人數："+String(Memo.count)+"\n剩餘台數："+String(count)
                textView.isEditable = false
                textView.font = UIFont(name: "Helvetica-Light", size: 13)
                textView.layer.cornerRadius = 10.0
                
            accessoryView = textView
            let widthConstraint = NSLayoutConstraint(item: accessoryView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
            accessoryView.addConstraint(widthConstraint)
            let heightConstraint = NSLayoutConstraint(item: accessoryView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
            accessoryView.addConstraint(heightConstraint)
            view.detailCalloutAccessoryView = accessoryView
            view.canShowCallout = true

            }
            /*
            guard let placemark = view.annotation as? MKPointAnnotation else { return }

            parent.selectedPlace = placemark
            parent.showingPlaceDetails = true
             */
        }
        }
   }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 24.178693, longitude: 120.64674)
        return annotation
    }
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {

    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

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

    }
    
}
