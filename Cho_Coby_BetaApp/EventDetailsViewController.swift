//
//  EventDetailsViewController.swift
//  Beta App
//
//  Created by user264337 on 10/24/24.
//

import UIKit

class EventDetailsViewController: UIViewController {

    // Declare the event property to hold the event data
    var event: Event?

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventRatingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Update the UI with the event details if the event is set
        if let event = event {
            eventImageView.image = UIImage(named: event.imageName)
            eventLocationLabel.text = "Location: \(event.location)"
            eventTimeLabel.text = "Time: \(event.time)"
            eventDateLabel.text = "Date: \(event.date)"
            eventDescriptionLabel.text = "Description: \(event.description)"
            eventRatingLabel.text = "Rating: \(event.rating)/5"
        }
    }
}
