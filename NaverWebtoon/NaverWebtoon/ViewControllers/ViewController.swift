//
//  ViewController.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/28.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var cvMain: UICollectionView!
    
    let cellName = "WebtoonCollectionViewCell"
    var todayWebtoonData : [TodayWebtoonModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTodayWebtoon()
        registerXib()
        
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: cellName, bundle: nil)
        cvMain.register(nibName, forCellWithReuseIdentifier: cellName)
    }
    
    func requestTodayWebtoon() {
        Repository().requestTodayWebtoon {[weak self] result in
            guard let `self` = self else {return}
            switch result {
            case .success(let data):
                Log.d(data)
                todayWebtoonData = data
                cvMain.reloadData()
                //                self.versionCheck(versionInfo: data)
            case .failure(let error):
                Log.e(error)
            }
        }
    }
    
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayWebtoonData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as?
                WebtoonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.ivWebtoon.load(url: URL(string: todayWebtoonData?[indexPath.row].thumb ?? "")!)
        cell.lblTitle.text = todayWebtoonData?[indexPath.row].title ?? ""
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.frame.width / 2) - 0.5
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "AboutWebtoon", bundle: nil)
        if let myViewController: AboutWebtoonViewController = storyboard.instantiateViewController(withIdentifier: "AboutWebtoonViewController") as? AboutWebtoonViewController {
            // 뷰 컨트롤러를 구성 합니다.
            myViewController.id = Int(todayWebtoonData?[indexPath.row].id ?? "")!
            // 뷰 컨트롤러를 나타냅니다.
            self.present(myViewController, animated: true, completion: nil)
        }
        
    }
    
}
