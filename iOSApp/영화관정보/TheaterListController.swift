//
//  TheaterListController.swift
//  iOSApp
//
//  Created by 503-26 on 27/11/2018.
//  Copyright © 2018 502. All rights reserved.
//

import UIKit

class TheaterListController: UITableViewController {
    //파싱한 결과를 저장할 변수
    var data = [NSDictionary]()
    //데이터를 읽을 시작 위치
    var startLocation = 0
    
    //웹에서 데이터를 다운로드 받아서 파싱한 후 결과를 저장하는 메소드 작성
    func parsingg(){
            //URL을 생성해서 다운로드 받기
            //다운로드 받을 URL 만들기
            let urlString = "http://swiftapi.rubypaper.co.kr:2029/theater/list?s_page=\(startLocation)&s_list=10"
            let url = URL(string: urlString)
   /* 데이터까지는 받아지는데 Dictionary 나 Array로 변환할 때 에러가 나면 대부분 Encoding 문제입니다.
    //이런 경우에는 문자열로 다운로드 받은 Data로 변환해서 수행하면 됩니다.
    //map의 key가 한글이라서 벌어진 문제.
            //print(url!)
            let apidata = try! Data(contentsOf: url!)
            //데이터가 출력되지 않으면 url을 확인해보고 인터넷 권한 부분을 확인
            //print(apidata)
        
    //데이터 파싱
        let result = try! JSONSerialization.jsonObject(with: apidata, options: []) as? NSArray
        print(result)
 */
        //문자열로 다운로드 받기
        let stringdata = try! NSString(contentsOf: url!, encoding: 0x80_000_422)
        //print(stringdata)
        //문자열을 바이트 배열로 변환
        let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
        let result = try! JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
        //print(result!)
        //배열의 데이터를 순회하면서 self.data에 추가
        for imsi in result!{
            self.data.append(imsi as! NSDictionary)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        parsingg()
        self.title = "영화관 목록보기"
        //== self.navigationItem.title = ""
        
        //테이블 뷰 재출력
        self.tableView.reloadData()
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parsingg()
        self.title = "영화관 목록보기"
        //== self.navigationItem.title = ""
        
        //테이블 뷰 재출력
        self.tableView.reloadData()
    }
 */

    // MARK: - Table view data source
    //섹션의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    //셀을 만들어주는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheaterCell", for: indexPath) as? TheaterCell
        //출력할 데이터 찾아오기
        let theater = self.data[indexPath.row]
        //데이터 출력
        cell?.lblName.text = theater["상영관명"] as? String
        cell?.lblAddr.text = theater["소재지지번주소"] as? String
        cell?.lblPhone.text = theater["연락처"] as? String

        // Configure the cell...

        return cell!
    }
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //데이터 찾아오기
        let theater = self.data[indexPath.row]
        //하위 뷰 컨트롤러 객체 생성
        let theaterMapController = self.storyboard?.instantiateViewController(withIdentifier: "TheaterMapController") as! TheaterMapController
        //데이터 넘겨주기
        theaterMapController.theater = theater
        //비동기적으로 푸시
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(theaterMapController, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
