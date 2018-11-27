//
//  DetailViewController.swift
//  iOSApp
//
//  Created by 503-26 on 27/11/2018.
//  Copyright © 2018 502. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    var data : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //data의 데이터가 있으면 - 예외가 발생하지 않도록 하기 위해서 이런 형태로 코드를 작성한다. //java코드라면 변수 != null
        if let addr = data{
            //url 객체로 정상적으로 만들어졌다면
            if let url = URL(string:addr){
                //웹뷰가 로딩
                let request = URLRequest(url: url)
                webView.load(request)
                webView.uiDelegate = self
                webView.navigationDelegate = self
            }
            //url 객체로 만드는 것에 실패했다면
            else{
                let alert = UIAlertController(title: "잘못된 URL 입니다.", message: "", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .cancel)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        }
        //data에 데이터가 없다면
        else{
            let alert = UIAlertController(title: "URL이 없습니다.", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
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
//DetailViewController의 기능확장 : extension
//Protocol : 인터페이스(메소드의 모양만 소유하는데 이 클래스에는 이 메소드가 반드시 구현되어 있다라는 것을 확인하는 용도
extension DetailViewController : WKNavigationDelegate, WKUIDelegate{
    //웹뷰가 로딩을 시작했을 때 호출되는 메소드
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.indicatorView.startAnimating()
    }
    //웹뷰가 로딩을 종료했을 때 호출되는 메소드
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicatorView.stopAnimating()
    }
    //웹 뷰가 로딩에 실패했을 때 호출되는 메소드
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.indicatorView.stopAnimating()
    }
}
