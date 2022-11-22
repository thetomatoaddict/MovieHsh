//
//  ViewController.swift
//  MovieHsh
//
//  Created by sujin on 2022/11/16.
//

import UIKit
// api 구조체 파싱을 위한 스트럭처 //
struct MovieData : Codable {
    let boxOfficeResult : BoxOfficeResult
}
struct BoxOfficeResult : Codable {
    let dailyBoxOfficeList : [DailyBoxOfficeList]
}
struct DailyBoxOfficeList : Codable {
    let movieNm : String
    let audiCnt : String
}


//뷰컨트롤러 구문 시작//
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    // movieData 변수 선언 //
    var movieData : MovieData?
    
    //  table 테이블뷰 아웃렛 선언 //
    @IBOutlet weak var table: UITableView!
    
    // 변수에 api 주소 저장 //
    var movieURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=c71db7da6c938d7e472cfb4fbca2f9b8&targetDt="

    // viewDidLoad 함수에 테이블,URL,getData 추가 //
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        movieURL += yesterdayStr()
        getData()
        // Do any additional setup after loading the view.
    }
    
    // 어제 날짜 계산하여 string으로 반환하는 함수 선언//
    func yesterdayStr() -> String {
        let yDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let str = dateFormatter.string(from: yDate)
        print(str)
        return str
        
        
    }
    
    // api(MovieData)에서 받아온 json데이터를 디코드하는 getData 함수 선언//
    func getData(){
        if let url = URL(string: movieURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONdata = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
                        self.movieData = decodedData
                        DispatchQueue.main.async {
                            self.table.reloadData()
                        }
                        
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    // 테이블뷰 row갯수 설정//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //dequeueReusableCell로 각 셀의 인덱스패스에 따라 리유즈 될 내용 설정 //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! myTableViewCell
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        return cell
    }
    
    // 테이블뷰 섹션 갯수 설정 //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // row가 선택되었을 때 ( 탭되었을 때 ) 실행될 내용 설정 //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }
    
}

