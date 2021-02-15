import Foundation
import CoreBluetooth

class BeaconManager: NSObject, CBPeripheralManagerDelegate {

    // MARK: - Singleton

    static let shared = BeaconManager()

    // MARK: - Private Vars

    private var peripheralManager: CBPeripheralManager!

    private var uuid: UUID?
    private var data: [String: Any]?

    // MARK: - Lifecycle

    private override init() {
        super.init()

        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    // MARK: - Advertise

    func startAdvertising(
        uuid: UUID,
        major: UInt16,
        minor: UInt16,
        measuredPower: Int8?
    ) {
        let data = advertisingData(
            uuid: uuid,
            major: major,
            minor: minor,
            measuredPower: measuredPower
        )

        self.uuid = uuid
        self.data = data

        if peripheralManager.state == .poweredOn {
            startAdvertising(uuid: uuid, data: data)
        }
    }
    
    private func advertisingData(
        uuid: UUID,
        major: UInt16,
        minor: UInt16,
        measuredPower: Int8?
    ) -> [String: Any] {
        
        let measuredPower = measuredPower ?? -59
        let (u1, u2, u3, u4, u5, u6, u7, u8,
             u9, u10, u11, u12, u13, u14, u15, u16) = uuid.uuid
        
        var data = Data(capacity: 21)
        data.append(u1)
        data.append(u2)
        data.append(u3)
        data.append(u4)
        data.append(u5)
        data.append(u6)
        data.append(u7)
        data.append(u8)
        data.append(u9)
        data.append(u10)
        data.append(u11)
        data.append(u12)
        data.append(u13)
        data.append(u14)
        data.append(u15)
        data.append(u16)
        
        data.append(UInt8(major >> 8))
        data.append(UInt8(major & 255))
        
        data.append(UInt8(minor >> 8))
        data.append(UInt8(minor & 255))
        
        data.append(UInt8(bitPattern: measuredPower))
        
        return ["kCBAdvDataAppleBeaconKey": data as NSData]
    }

    private func startAdvertising(uuid: UUID, data: [String: Any]) {
        peripheralManager.startAdvertising(data)
        print("Started advertising \(uuid.uuidString)")
    }

    func stopAdvertising() {
        peripheralManager.stopAdvertising()
        print("Stopped advertising")
    }

    // MARK: - CBPeripheralManagerDelegate

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            guard let uuid = uuid, let data = data else {
                return
            }
            startAdvertising(uuid: uuid, data: data)

        default:
            peripheral.stopAdvertising()
        }
    }
}
