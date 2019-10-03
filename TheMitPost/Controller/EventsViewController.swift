//
//  EventsTableViewController.swift
//  TheMitPost
//
//  Created by Harshavardhan K on 10/07/19.
//  Copyright © 2019 Harshavardhan K. All rights reserved.
//

import UIKit

import Lottie
import NVActivityIndicatorView
import SwiftyJSON
import Alamofire

class EventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    let EVENTS_API = "https://app.themitpost.com/events"
    
    var events = [Events]()
    var eventShown = [Bool]()
    
    let refreshControl = UIRefreshControl()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: VIEW WILL DID LOAD
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mode()
        
        startActivityIndicator()

        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.addSubview(refreshControl)
        
        retrieveEvents { (success) in
            
            if !success {
                
                let emptyImageView = UIImageView(image: UIImage(named: "post-empty"))
                emptyImageView.frame = CGRect(origin: self.view.bounds.origin, size: CGSize(width: 300, height: 237))
                
                self.view.addSubview(emptyImageView)
            }
            
        }
        
        refreshControl.addTarget(self, action: #selector(refreshEvents), for: .valueChanged)
        
    }
    
    //MARK: ACTIVITY INDICATOR
    var activityIndicator: NVActivityIndicatorView!
    func startActivityIndicator() {
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2, y: self.view.frame.height / 2, width: 45, height: 45), type: .cubeTransition, color: .lightGray, padding: 0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    //MARK: EMPTY LOTTIE VIEW
    
    func createEmptyView() {
        
        let emptyImageView = AnimationView(name: "empty-box")
        emptyImageView.frame = CGRect(origin: self.view.center, size: CGSize(width: 300, height: 237))
        emptyImageView.center = self.view.center
        
        self.view.addSubview(emptyImageView)
        emptyImageView.play()
        
        let label = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height / 2 + 200, width: 200, height: 30))
        label.text = "Pull to refresh"
        self.view.addSubview(label)
    }
    
    //MARK:- DARK MODE CHECK
    
    func mode() {
        
        if #available(iOS 13.0, *) {
            
            if traitCollection.userInterfaceStyle == .dark {
                
                print("dark mode detected")
                self.navigationController?.navigationBar.barTintColor = .background
                self.tabBarController?.tabBar.barTintColor = .background

                self.view.backgroundColor = UIColor.background
                eventsCollectionView.backgroundColor = UIColor.background
                
            } else {
                
                print("light mode detected")
                self.navigationController?.navigationBar.barTintColor = .white
                self.tabBarController?.tabBar.barTintColor = .white
                
                self.view.backgroundColor = .white
                eventsCollectionView.backgroundColor = .white
                
            }
            
        } else {
            self.navigationController?.navigationBar.barTintColor = .white
            self.tabBarController?.tabBar.barTintColor = .white
            
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
       mode()
    }
    

    // MARK: - TABLE VIEW COUNT

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    //MARK: TABLE VIEW RETURN CELL
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventViewCell
        
        cell.event = events[indexPath.row]
        
        return cell
        
    }
    
//    @objc func eventImagePressed(_ sender: Any) {
//        print("Event image tapped like an ass")
//        if #available(iOS 13.0, *) {
//            let imagePresentVC = storyboard?.instantiateViewController(identifier: "imagePresent") as! ImagePresentViewController
//        } else {
//            // Fallback on earlier versions
//        }
//        imagePresentVC.image_url =
//        present(imagePresentVC, animated: true, completion: nil)
//        //self.performSegue(withIdentifier: "detailEvent", sender: sender)
//    }
    
    //MARK: TABLE VIEW ANIMATION
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if eventShown[indexPath.row] == false {
            
            let transform = CATransform3DTranslate(CATransform3DIdentity, -5, 80, 0)
            cell.layer.transform = transform
            cell.alpha = 0.4
            
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
                
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
                
            }) { (true) in
                print("Animation complete")
                
            }
            
            eventShown[indexPath.row] = true
            
        }
    }
    
    //MARK: TABLE VIEW CELL RESIZES / PADDING / ETC
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.bounds.width - (EventViewCell.cellPadding), height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: EventViewCell.cellPadding + 20, left: EventViewCell.cellPadding + 20, bottom: EventViewCell.cellPadding + 20, right: EventViewCell.cellPadding + 20)
    }

    
    //MARK:- API CALL
    func retrieveEvents(completion: @escaping (Bool) -> ()) {
        
        Alamofire.request(EVENTS_API, method: .get).responseJSON {
            response_ in
            
            self.events = [Events]()
            
            guard let resultValue = response_.result.value else {
                completion(false)
                return
            }
            
            let response = JSON(resultValue)
            
            if(response["status"].stringValue != "OK") {
                //TODO:- UPDATE BACKGROUND IMAGE TO CONVEY THERE WAS AN ERROR GETTING EVENTS
                print("Cannot get EVENTS")
                self.refreshControl.endRefreshing()
                completion(false)
                
            } else {
                
                let data = response["data"].arrayValue
                
                for event in data {
                    self.events.append(Events(data: event))
                }
            }
            
            completion(true)
            
            self.eventShown = [Bool](repeatElement(false, count: self.events.count + 1))
            
            self.refreshControl.endRefreshing()
            
            self.stopActivityIndicator()
            
            self.eventsCollectionView.reloadData()
        }
        
    }
    
    //MARK: REFRESH
    
    @objc func refreshEvents() {
        
        retrieveEvents { (success) in
            
            if !success {
                
            }
            
        }
        
        print("Finished refreshing..")
    }
    
    //MARK: DETAIL IMAGE SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailEvent" {
            
            if let destinationViewController = segue.destination as? ImagePresentViewController {
                
                let path = self.eventsCollectionView.indexPath(for: sender as! EventViewCell)
                
                destinationViewController.image_url = events[(path?.row)!].imageURL
            }
        }
    }

}
