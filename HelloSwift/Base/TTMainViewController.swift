//
//  ViewController.swift
//  HelloSwift
//
//  Created by gtc on 2021/4/27.
//

import UIKit

struct CellSectionData {
    var title: String?
    var classList: [CellData]! = []
}

struct CellData {
    var title: String?
    var vcClassString: String! = ""
}

class TTMainViewController: TCBaseViewController {
    var datalist: [CellSectionData]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        title = "目录"
        datalist = Array()
        configData()
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func configData() {
        
        let cell2 = CellData(title: "aa", vcClassString: "YFYufaIndexController")
        let cell21 = CellData(title: "bb", vcClassString: "")
        
        let cell3 = CellData(title: "rx基础用法", vcClassString: "RxStudyIndexController")
        let cell31 = CellData(title: "rx高级", vcClassString: "RxSeniorUsingController")
        let cell32 = CellData(title: "Promise", vcClassString: "PromiseViewController")

        let treeCell = CellData(title: "Tree", vcClassString: "LCTreeController")
        let listCell = CellData(title: "List", vcClassString: "LCLinkListController")
        let stringCell = CellData(title: "String", vcClassString: "LCStringController")
        let arrayCell = CellData(title: "Array", vcClassString: "LCArrayController")
        let sortCell = CellData(title: "Sort", vcClassString: "LCSortController")
        let other = CellData(title: "Other", vcClassString: "LCOthersViewController")
        

        let psVC = CellData(title: "PublishersAndSubscribers", vcClassString: "PublishersAndSubscribersController")
        let subjectVC = CellData(title: "Subject", vcClassString: "SubjectViewController")
        let operatorVC = CellData(title: "Operators", vcClassString: "OperatorsViewController")
        let combiningVC = CellData(title: "CombiningOperators", vcClassString: "CombiningOperatorsViewController")
        
        let layout =  CellData(title: "stackScroll", vcClassString: "LLStackScrollViewController")
        
        datalist.append(CellSectionData(title: "yufa", classList: [cell2, cell21]))
        datalist.append(CellSectionData(title: "Layout", classList: [layout]))
        datalist.append(CellSectionData(title: "RxSwift", classList: [cell3, cell31, cell32]))
        datalist.append(CellSectionData(title: "Combine", classList: [psVC, subjectVC, operatorVC, combiningVC]))
        datalist.append(CellSectionData(title: "Algorithm", classList: [treeCell, listCell, stringCell, arrayCell, sortCell, other]))
        
        let threadIndex = CellData(title: "ThreadHome", vcClassString: "ThreadIndexController")
        datalist.append(CellSectionData(title: "Thread", classList: [threadIndex]))
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.white
        table.showsHorizontalScrollIndicator = false
        return table
    }()
}

extension TTMainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = datalist[section]
        return data.classList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell");
        }
        cell?.backgroundColor = UIColor.clear
        let sectionData = datalist[indexPath.section]
        let cellData = sectionData.classList[indexPath.row]
        cell?.textLabel?.text = cellData.title
        cell?.textLabel?.textColor = UIColor.black
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let data = datalist[section]
        return data.title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionData = datalist[indexPath.section]
        let cellData:CellData = sectionData.classList![indexPath.row]
        
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        guard let namespace = nameSpace else {
            print("push fail")
            return;
        }
        
        let vcClass: AnyObject.Type = NSClassFromString(namespace + "." + cellData.vcClassString)!
        guard let typeClass = vcClass as? UIViewController.Type else {
            print("init failure")
            return
        }
        
        let vcInstance = typeClass.init()
        self.navigationController?.pushViewController(vcInstance, animated: true)
    }
    
}

