//
//  DetailHospitalTableViewController.swift
//  HospotalMap
//
//  Created by KPUGAME on 2019. 4. 28..
//  Copyright © 2019년 YuShinSong. All rights reserved.
//

import UIKit

class DetailHospitalTableViewController: UITableViewController, XMLParserDelegate {

    //table view를 CTRL-drag
    @IBOutlet var detailTableView: UITableView!
    
    //HospitalTableViewController로 부터 segue를 통해 전달받은 OpenAPI url 주소
    var url :  String?
    
    //xml파일을 다운로드 및 파싱하는 오브젝트
    var parser = XMLParser()
    //feed 데이터를 저장하는 mutable array : 병원이 1개이므로 item이 1개
    //11개 정보를 저장하는 array
    let postsname : [String] = ["병원명", "주소", "전화번호", "홈페이지", "종별코드명", "개설일자", "의사총수", "전문의 인원수", "일반의 인원수", "레지던트 인원수", "인턴 인원수"]
    var posts : [String] = ["","","","","","","","","","",""]
    //dictionary는 사용하지 않음
    //      var elements = NSMutableDictionary()
    var element = NSString()
    //저장 문자열 변수
    var yadmNm = NSMutableString()
    var addr = NSMutableString()
    var telno = NSMutableString()
    var hospUrl = NSMutableString()
    var clCdNm = NSMutableString()
    var estbDd = NSMutableString()
    var drTotCnt = NSMutableString()
    var sdrCnt = NSMutableString()
    var gdrCnt = NSMutableString()
    var resdntCnt = NSMutableString()
    var intnCnt = NSMutableString()
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string: url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    
    //parser가 새로운 element를 발견하면 변수를 생성한다.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as String).isEqual("item") // url마다 item date pubdata 명칭들이 각각 다름
        {
            //          elements = NSMutableDictionary()
            //          elements = [:]
            //새로운 item (병원)이 발견될 때 마다 posts를 초기화함.
            posts = ["","","","","","","","","","",""]
            
            yadmNm = NSMutableString()
            yadmNm = ""
            addr = NSMutableString()
            addr = ""
            
            telno = NSMutableString()
            telno = ""
            hospUrl = NSMutableString()
            hospUrl = ""
            clCdNm = NSMutableString()
            clCdNm = ""
            estbDd = NSMutableString()
            estbDd = ""
            drTotCnt = NSMutableString()
            drTotCnt = ""
            sdrCnt = NSMutableString()
            sdrCnt = ""
            gdrCnt = NSMutableString()
            gdrCnt = ""
            resdntCnt = NSMutableString()
            resdntCnt = ""
            intnCnt = NSMutableString()
            intnCnt = ""
        }
    }
    //병원 정보 11개를 완성 이름(yadmNm)과 주소(addr) 등
    func parser(_ parser:XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "yadmNm") {
            yadmNm.append(string)
        } else if element.isEqual(to: "addr") {
            addr.append(string)
        } else if element.isEqual(to: "telno") {
            telno.append(string)
        } else if element.isEqual(to: "hospUrl") {
            hospUrl.append(string)
        } else if element.isEqual(to: "clCdNm") {
            clCdNm.append(string)
        } else if element.isEqual(to: "estbDd") {
            estbDd.append(string)
        } else if element.isEqual(to: "drTotCnt") {
            drTotCnt.append(string)
        } else if element.isEqual(to: "sdrCnt") {
            sdrCnt.append(string)
        } else if element.isEqual(to: "gdrCnt") {
            gdrCnt.append(string)
        } else if element.isEqual(to: "resdntCnt") {
            resdntCnt.append(string)
        } else if element.isEqual(to: "intnCnt") {
            intnCnt.append(string)
        }
    }
    //item의 끝에서 11개 정보를 posts 배열에 차례로 삽입함
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName as NSString).isEqual(to: "item") {
            if !yadmNm.isEqual(nil) {
                posts[0] = yadmNm as String
            }
            if !addr.isEqual(nil) {
                posts[1] = addr as String
            }
            if !telno.isEqual(nil) {
                posts[2] = telno as String
            }
            if !hospUrl.isEqual(nil) {
                posts[3] = hospUrl as String
            }
            if !clCdNm.isEqual(nil) {
                posts[4] = clCdNm as String
            }
            if !estbDd.isEqual(nil) {
                posts[5] = estbDd as String
            }
            if !drTotCnt.isEqual(nil) {
                posts[6] = drTotCnt as String
            }
            if !sdrCnt.isEqual(nil) {
                posts[7] = sdrCnt as String
            }
            if !gdrCnt.isEqual(nil) {
                posts[8] = gdrCnt as String
            }
            if !resdntCnt.isEqual(nil) {
                posts[9] = resdntCnt as String
            }
            if !intnCnt.isEqual(nil) {
                posts[10] = intnCnt as String
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // XML 파싱
        beginParsing()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCell", for: indexPath)
        cell.textLabel?.text = postsname[indexPath.row] //11개 정보 타이틀
        cell.detailTextLabel?.text = posts[indexPath.row] //11개 정보 값
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }


}
