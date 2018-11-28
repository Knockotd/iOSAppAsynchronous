//
//  TheaterMapController.swift
//  iOSApp
//
//  Created by 503-26 on 28/11/2018.
//  Copyright © 2018 502. All rights reserved.
//

import UIKit
import MapKit

class TheaterMapController: UIViewController {
    var theater : NSDictionary?
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //극장 이름 출력
        self.navigationItem.title = theater!["상영관명"] as? String

        //위도와 경도 찾기 - 위도와 경도라는 키에 저장되어 있는데
        //정수로 변환해야 함
            let latitude = (theater!["위도"] as? NSString)?.doubleValue
            let longitude = (theater!["경도"] as? NSString)?.doubleValue
        
        //지도에 출력할 영역을 만들기
            //지표의 중심점 좌표 생성
            let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            //영역 만들기
            let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            //지도에 출력
            mapView.setRegion(coordinateRegion, animated: true)
        
        //영화관에 마커(=핀=어노테이션) 출력
            //어노테이션 객체 생성
            let point = MKPointAnnotation()
            //위치 만들기
            point.coordinate = location
            //어노테이션에 타이틀 달기
            point.title = theater!["상영관명"] as? String
            //지도에 출력
            mapView.addAnnotation(point)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
