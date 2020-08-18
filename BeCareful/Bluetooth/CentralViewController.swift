//
//  CentralViewController.swift
//  BeCareful
//
//  Created by Jose Alberto on 22/03/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//  swiftlint:disable force_cast
//
//  examples CBPeripheralDelegate
//  https://drive.google.com/drive/folders/1JaKAL_u0G3MaJ3Io2HImx5FoFdsk5Ujf?usp=sharing
//  https://drive.google.com/drive/folders/1JaKAL_u0G3MaJ3Io2HImx5FoFdsk5Ujf?usp=sharing

import UIKit
import CoreBluetooth

class CentralViewController: UIViewController {

    // MARK: Properties
    private let reuseIdentifier = "ItemBluetoothTableViewCell"
    private var discoveredPeripheral: CBPeripheral?

    // And somewhere to store the incoming data
    private let data = NSMutableData()

    //central manager
    var centralManager: CBCentralManager?

    //peripheral manager
    var peripheral: CBPeripheral?

    //array to store the peripherals
    var peripheralArray:[(peripheral: CBPeripheral, RSSI: Float)] = []

    // MARK: Outlets
    @IBOutlet private weak var scanBluetooth: UIImageView!
    @IBOutlet var tableView: UITableView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //loads the centralmanager delegate in here
            self.centralManager = CBCentralManager(delegate: self, queue: nil)
            //
            self.startScan()
        }
        let selectCellNib = UINib(nibName: "ItemBluetoothTableViewCell", bundle: nil)
        tableView.register(selectCellNib, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Actions

    // start scanning
    func startScan() {
        print("Start Scan")
        // Search all for services
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }

    // stop the scanning and re-enable the scan button so you can do it again
    @objc func stopScanning() {
        centralManager?.stopScan()
        print("Scan Stopped")
    }

    // cancel any preexisting connection - this still needs to be done
    func disconnectPeripheral() {
        centralManager?.cancelPeripheralConnection(peripheral!)
    }

    // Call this when things either go wrong, or you're done with the connection.
    // This cancels any subscriptions if there are any, or straight disconnects if not.
    // (didUpdateNotificationStateForCharacteristic will cancel the connection if a subscription is involved)
    func cleanup() {
        // Don't do anything if we're not connected
        // self.discoveredPeripheral.isConnected is deprecated
        guard discoveredPeripheral?.state == .connected else { return }

        // See if we are subscribed to a characteristic on the peripheral
        guard let services = discoveredPeripheral?.services else {
            disconnectPeripheral()
            return
        }

        for service in services {
            guard let characteristics = service.characteristics else { continue }

            for characteristic in characteristics {
                if characteristic.uuid.isEqual(transferCharacteristicUUID) && characteristic.isNotifying {
                    discoveredPeripheral?.setNotifyValue(false, for: characteristic)
                    // And we're done.
                    return
                }
            }
        }
    }

    @IBAction func startScanAction(_ sender: Any) {
        scanBluetooth.image = UIImage.gif(name: "ScaneBluetooth")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //loads the centralmanager delegate in here
            self.centralManager = CBCentralManager(delegate: self, queue: nil)
            //
            self.startScan()
        }
    }
}

// MARK: - CBCentralManagerDelegate -- Connection to bluetooth
extension CentralViewController: CBCentralManagerDelegate {

    // required centralmanager component. Text for what power state currently is
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var consoleMsg = ""
        switch central.state {
        case.poweredOff:
            consoleMsg = "BLE is Powered Off"
            showAlert(title: "Bluetooth", message: "Active Bluetooth para usar esta aplicación.")

        case.poweredOn:
            consoleMsg = "BLE is Powered On"
            startScan()

        case.resetting:
            consoleMsg = "BLE is resetting"

        case.unknown:
            consoleMsg = "BLE is in an unknown state"

        case.unsupported:
            consoleMsg = "This device is not supported by BLE"

        case.unauthorized:
            consoleMsg = "BLE is not authorised"
        @unknown default:
            print("")
        }
        print("\(consoleMsg)")
    }

    //once scanned this will say what has been discovered - add to peripheralArray
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {

        if discoveredPeripheral != peripheral {
            //centralManager?.connect(peripheral, options: nil)
            for existing in peripheralArray where existing.peripheral.identifier == peripheral.identifier {
                return
            }

            // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
            discoveredPeripheral = peripheral

            let theRSSI = RSSI.floatValue
            peripheralArray.append((peripheral: peripheral, RSSI: theRSSI))
            peripheralArray.sort { $0.RSSI < $1.RSSI }
            // And connect
            print("List -- peripheral \(peripheral)")
            tableView.reloadData()
        }
    }

    // Once the disconnection happens, we need to clean up our local copy of the peripheral
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Peripheral Disconnected")
        discoveredPeripheral = nil

        // We're disconnected, so start scanning again
        startScan()
    }

    // if it failed to connect to a peripheral will tell us (although not why)
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("failed to connect to peripheral")
        stopScanning()
    }
}

// MARK: - Table View Methods
extension CentralViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheralArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ItemBluetoothTableViewCell
        let cbperipheral = peripheralArray[indexPath.row].peripheral
        cell.configView(peripheral: cbperipheral)
        return cell
    }
}
