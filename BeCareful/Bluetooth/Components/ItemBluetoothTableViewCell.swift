//
//  ItemBluetoothTableViewCell.swift
//  BeCareful
//
//  Created by Jose Alberto on 22/03/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//

import UIKit
import CoreBluetooth

class ItemBluetoothTableViewCell: UITableViewCell {

    @IBOutlet private weak var deviceName: UILabel!

    func configView(peripheral: CBPeripheral?) {
        guard let peripheral = peripheral else { return }
        deviceName.text = peripheral.name
    }
}
