//
//  AttractionTableViewController.swift
//  TableView
//
//  Created by SeokkiKwon on 11/16/23.
//

import UIKit

class AttractionTableViewController: UITableViewController {
    
    // 테이블 목록
    var attractionImages = [String]()
    var attractionNames = [String]()
    var webAddresses = [String]()
    
    // UISearchController 인스턴스 및 일치하는 검색 결과가 저장될 배열 추가
    var searching = false
    var matches = [Int]()
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        // edit버튼 활성화
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // 검색 초기화
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Attractions"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        initialize()
    }
    
    // 테이블 뷰 데이터 소스 생성
    func initialize() {
        attractionNames = ["Buckingham Palace",
                           "The Eiffel Tower",
                           "The Grand Canyon",
                           "Windsor Castle",
                           "Empire State Building"]
        
        webAddresses = ["https://en.wikipedia.org/wiki/Buckingham_Palace",
                        "https://en.wikipedia.org/wiki/Eiffel_Tower",
                        "https://en.wikipedia.org/wiki/Grand_Canyon",
                        "https://en.wikipedia.org/wiki/Windsor_Castle",
                        "https://en.wikipedia.org/wiki/Empire_State_Building"]
        
        attractionImages = ["buckingham_palace.jpg",
                            "eiffel_tower.jpg",
                            "grand_canyon.jpg",
                            "windsor_castle.jpg",
                            "empire_state_building.jpg"]
        // 테이블 뷰의 예상 행 높이 설정
        // 테이블 보기 탐색을 추가할 때 행 높이가 축소되는 것을 방지하고, 테이블 렌더링 성능도 향상
        self.tableView.estimatedRowHeight = 50
    }
    
    // 뷰가 보일때마다 리스트의 데이터를 다시 불러옴
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }
    
    // MARK: - Table view data source
    
    // 테이블 안에 섹션이 1개
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 섹션별 행의 개수
    // 검색 모드에서 행 수는 일치한 배열의 항목 수에 따라 달라짐
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searching ? matches.count : attractionNames.count
    }
    
    // items 배열의 값을 셀에 추가
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 지정한 TableCell의 Identifier를 입력해준다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttractionTableCell", for: indexPath) as! AttractionTableViewCell
        
        let row = indexPath.row
        cell.attractionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.attractionLabel.text = searching ? attractionNames[matches[row]] : attractionNames[row]
        cell.attractionImage.image =  UIImage(named: searching ? attractionImages[matches[row]] : attractionImages[row])
        
        return cell
    }
    
    // Delete를 한글로 변경
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "\(indexPath.row)번 삭제"
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searching = false
           tableView.reloadData()
       }
    
    
    // 목록 삭제하기
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // 실제 데이터를 지우는 로직
            
            // 삭제할 아이템 위치를 기록
            let row = indexPath.row
        
            if self.searching {
                self.attractionNames.remove(at: matches[row])
                self.attractionImages.remove(at: matches[row])
                self.webAddresses.remove(at: matches[row])
                matches.remove(at: row)
                matches = matches.map { $0 >= row ? $0 - 1 : $0}
            } else {
                attractionNames.remove(at: row)
                attractionImages.remove(at: row)
                webAddresses.remove(at: row)
            }
            // 화면상에서 셀을 지우는 로직
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // 목록 순서 바꾸기
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // 이동할 아이템 위치를 기록
        let itemRow = fromIndexPath.row
        // 이동할 아이템을 삭제
        attractionNames.remove(at: itemRow)
        attractionImages.remove(at: itemRow)
        webAddresses.remove(at: itemRow)
        // 삭제된 아이템을 이동할 위치로 삽입
        
        attractionNames.insert(attractionNames[itemRow], at: to.row)
        attractionImages.insert(attractionNames[itemRow], at: to.row)
        webAddresses.insert(attractionNames[itemRow], at: to.row)
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAttractionDetail" {
            let detailView = segue.destination as! AttractionDetailViewController
            let row = self.tableView.indexPathForSelectedRow!.row
            detailView.webSite = searching ? webAddresses[matches[row]] : webAddresses[row]
        }
    }
    
}

// 결과 업데이트 대리자로 지정
// 검색 창에 입력된 텍스트가 포함된 검색 컨트롤러 개체에 대한 참조를 전달
extension AttractionTableViewController: UISearchBarDelegate, UISearchResultsUpdating {
        
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            matches.removeAll() // matches 배열의 항목을 전부삭제
            for index in 0..<attractionNames.count {
                if attractionNames[index].contains(searchText) {
                    matches.append(index)
                }
            }
            searching = true
        }
        else {
            searching = false
        }
        tableView.reloadData()
    }
}
