# beacon

Simple command line utility to simulate an iBeacon.

## Installing

Make sure Xcode is installed first.

### [Mint](https://github.com/yonaskolb/mint)

mint install sroebert/beacon

## Usage

```
mint run beacon
```

Options:

- __--uuid__: The UUID to use for the beacon (optional, default value is a random UUID).
- __--major__: The major value to use for the beacon (optional, default value is `123`).
- __--minor__: The minor value to use for the beacon (optional, default value is `456`).
- __--measured-power__: The calibrated measured power value to use for the beacon (optional, default value is `-59`).
