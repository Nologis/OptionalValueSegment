//
//  ViewController.swift
//  DisabledSegment
//
//  Created by vgutierrezNologis on 30/8/18.
//  Copyright © 2018 vgutierrezNologis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var disabledSwitch: OptionalValueSegment?

    @IBOutlet weak var nibSwitch: OptionalValueSegment!

    override func viewDidLoad() {
        super.viewDidLoad()

        disabledSwitch = OptionalValueSegment(
            frame: CGRect(x: (view.bounds.width - 300)/2,
                          y: 60,
                          width: 300,
                          height: 40
            ),
            options: [
                ("Zero", 0.0),
                ("Pi", Double.pi),
                ("Kilo", 1024.0)
            ],
            appearance: OptionalValueSegmentAppearance(
                selectedColor: .orange,
                defaultColor: .groupTableViewBackground,
                backgroundColor: .white,
                font: UIFont.boldSystemFont(ofSize: 17),
                defaultTextColor: .black,
                selectedTextColor: .white,
                borderWidth: 2,
                cornerRadius: 12
            )
        )
        view.addSubview(disabledSwitch!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enabledTUI(_ sender: Any) {
        disabledSwitch?.reset()
        nibSwitch?.reset()
    }

    @IBAction func valueTUI(_ sender: Any) {
        let alertController = UIAlertController(
            title: "DisabledSegment",
            message: """
            \(String(describing: disabledSwitch?.selectedValue ?? "Top switch is disabled"))
            \(String(describing: nibSwitch?.selectedValue ?? "Bottom switch is disabled"))
            """,
            preferredStyle: UIAlertControllerStyle.alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }
}

