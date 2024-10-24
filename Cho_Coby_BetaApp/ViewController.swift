//
//  ViewController.swift
//  Beta App
//
//  Created by user264337 on 10/23/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var heartOne: UIButton!
    @IBOutlet weak var heartTwo: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    
    let eventOne = Event(imageName: "wings", title: "Air Show", location: "Discovery Green", time: "Varying times", date: "10/14/2024", description: "Top golf based on Disney movies", rating: 5)
    
    let eventTwo = Event(imageName: "png", title: "Texas Renaissance", location: "21778 FM 1774", time: "Varying times", date: "10/12/2024", description: "Live entertainment, food and drink", rating: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heartOne.setImage(UIImage(systemName: "heart"), for: .normal)
        heartTwo.setImage(UIImage(systemName: "heart"), for: .normal)
        
        imageView.image = UIImage(named: "Wings")
        
        // Enable user interaction on the imageView
        imageView.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer to make it behave like a button
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        imageViewTwo.image = UIImage(named: "png")  // Set the image to "png"
        imageViewTwo.isUserInteractionEnabled = true
        let tapGestureRecognizerTwo = UITapGestureRecognizer(target: self, action: #selector(imageTwoTapped))
        imageViewTwo.addGestureRecognizer(tapGestureRecognizerTwo)    }
    
    @IBAction func heartOneTapped(_ sender: Any) {
        let currentImage = heartOne.currentImage
        
        if currentImage == UIImage(systemName: "heart") {
            heartOne.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartOne.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func heartTwoTapped(_ sender: Any) {
        let currentImage = heartTwo.currentImage
        
        if currentImage == UIImage(systemName: "heart") {
            heartTwo.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartTwo.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @objc func imageTapped() {
        performSegue(withIdentifier: "showEventDetails", sender: eventOne)
    }
    
    @objc func imageTwoTapped() {
        print("Second image (png) tapped")
        // Perform action for the second image tap
        performSegue(withIdentifier: "showEventDetailsForImageTwo", sender: eventTwo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventDetailsForImageOne" || segue.identifier == "showEventDetailsForImageTwo" {
              if let destinationVC = segue.destination as? EventDetailsViewController, let selectedEvent = sender as? Event {
                  destinationVC.event = selectedEvent
              }
        }
    }
}
