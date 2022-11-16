//
//  ViewController.swift
//  MovieHsh
//
//  Created by sujin on 2022/11/16.
//

import UIKit
let name = ["aaa","bbb","ccc","ddd","eee"]
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    

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
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! myTableViewCell
        cell.movieName.text = name[indexPath.row]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }

}

