//
//  AdsDetailViewController.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import Foundation
import RxSwift
import Then
import RxCocoa

class AdsDetailViewController: UIViewController {
    private let bag = DisposeBag()
    fileprivate var viewModel: AdsDetailViewModel!
    fileprivate var navigator: MainNavigator!
    
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    static func createWith(navigator: MainNavigator, storyboard: UIStoryboard, viewModel: AdsDetailViewModel) -> AdsDetailViewController {
        return storyboard.instantiateViewController(ofType: AdsDetailViewController.self).then { vc in
            vc.navigator = navigator
            vc.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        bindUI()
//        scrollView.delegate = self
        
    }
    
    func bindUI() {
        self.photo.setImage(with: URL(string: viewModel.getThumbnailUrl()))
        self.detailImage.setImage(with: URL(string: viewModel.getImageUrl()))
        self.name.text = viewModel.getName()
        self.message.text = viewModel.getPrice()
    }
    
    
   
}

//extension AdsDetailViewController: UIScrollViewDelegate {
//    func scrollViewDidZoom(scrollView: UIScrollView) {
//        if scrollView.zoomScale > 1 {
//
//            if let image = detailImage.image {
//
//                let ratioW = detailImage.frame.width / image.size.width
//                let ratioH = detailImage.frame.height / image.size.height
//
//                let ratio = ratioW < ratioH ? ratioW:ratioH
//
//                let newWidth = image.size.width*ratio
//                let newHeight = image.size.height*ratio
//
//                let left = 0.5 * (newWidth * scrollView.zoomScale > detailImage.frame.width ? (newWidth - detailImage.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
//                let top = 0.5 * (newHeight * scrollView.zoomScale > detailImage.frame.height ? (newHeight - detailImage.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
//
//                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
//            }
//        } else {
//            scrollView.contentInset = .zero
//        }
//    }
//}
