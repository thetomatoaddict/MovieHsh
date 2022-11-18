//
//  ViewController.swift
//  MovieHsh
//
//  Created by sujin on 2022/11/16.
//

import UIKit
let name = ["aaa","bbb","ccc","ddd","eee"]
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
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var movieData : MovieData?
    
    @IBOutlet weak var table: UITableView!
    let movieURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=c71db7da6c938d7e472cfb4fbca2f9b8&targetDt=20221115"
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        getData()
        // Do any additional setup after loading the view.
    }
    func getData(){
        if let url = URL(string: movieURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONdata = data {
                    //print(JSONdata)
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
                        //print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
                        //print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].audiCnt)
                        self.movieData = decodedData
                        self.table.reloadData()
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! myTableViewCell
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }
    
}

