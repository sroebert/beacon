import Foundation
import ArgumentParser

struct RunCommand: ParsableCommand {

    // MARK: - Error

    private enum CommandError: Error, CustomStringConvertible {
        case invalidUUID

        var description: String {
            switch self {
            case .invalidUUID:
                return "The provided UUID is invalid."
            }
        }
    }

    // MARK: - Properties

    static var configuration: CommandConfiguration {
        return CommandConfiguration(
            commandName: "beacon",
            abstract: "Advertise an iBeacon.",
            version: "0.1.0"
        )
    }

    @Option(help: "The uuid of the beacon. (default: random UUID)", transform: {
        guard let uuid = UUID(uuidString: $0) else {
            throw CommandError.invalidUUID
        }
        return uuid
    })
    var uuid: UUID?

    @Option(help: "The major value of the beacon.")
    var major: UInt16 = 123

    @Option(help: "The minor value of the beacon.")
    var minor: UInt16 = 456

    @Option(help: "The measured power value of the beacon.")
    var measuredPower: Int8?

    // MARK: - ParsableCommand

    mutating func run() throws {
        BeaconManager.shared.startAdvertising(
            uuid: uuid ?? UUID(),
            major: major,
            minor: minor,
            measuredPower: measuredPower
        )
        RunLoop.main.run()
    }
}
