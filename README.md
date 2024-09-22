# PrivateInternetAccess-WiFi-disable-on-boot

This script automates the process of connecting to a VPN (specifically Private Internet Access) before enabling WiFi on Windows startup. It ensures that your internet connection is always protected by your VPN.

## Features

- Disables WiFi on startup
- Launches Private Internet Access VPN
- Waits for the VPN to connect (detected by a specific color at a screen coordinate)
- Enables WiFi once the VPN is connected
- Provides visual feedback during the process
- Automatically exits after completion

## Prerequisites

- Windows operating system
- Private Internet Access VPN installed
- PowerShell (comes pre-installed on modern Windows systems)

## Installation

1. Clone this repository or download the `vpn_wifi_manager.bat` file.
2. Place the `vpn_wifi_manager.bat` file in a permanent location on your computer.

## Configuration

Before using the script, you need to configure it for your system:

1. Open `vpn_wifi_manager.bat` in a text editor.
2. Locate the following line and adjust the path if necessary:
   ```batch
   start "" "C:\Program Files\Private Internet Access\piactl.exe" connect
   ```
3. Find these lines in the PowerShell command and adjust the coordinates and color if needed:
   ```powershell
   $x = 1671; $y = 1057; $targetColor = [System.Drawing.Color]::FromArgb(230,180,0);
   ```
   These should match the position and color of the PIA connection indicator on your screen.

## Usage

### Manual Execution

You can run the script manually by double-clicking the `vpn_wifi_manager.bat` file.

### Automatic Execution on Startup

To have the script run automatically when you start your computer:

1. Press `Win + R`, type `shell:startup`, and press Enter.
2. This opens the Startup folder.
3. Create a shortcut to `vpn_wifi_manager.bat` in this folder.

Alternatively, you can use Task Scheduler for more advanced startup options:

1. Open Task Scheduler (search for it in the Start menu).
2. Click "Create Basic Task" in the right panel.
3. Name it "VPN WiFi Manager" and click Next.
4. Choose "When the computer starts" and click Next.
5. Select "Start a program" and click Next.
6. Browse and select your `vpn_wifi_manager.bat` file, then click Next.
7. Review the settings and click Finish.

## Troubleshooting

- If the script isn't detecting the VPN connection, try adjusting the screen coordinates and color in the script.
- Ensure that the path to the PIA executable is correct.
- If WiFi isn't being disabled or enabled, make sure you're running the script with administrator privileges.

## Contributing

Contributions to improve the script are welcome. Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Disclaimer

This script is provided as-is, without any warranties. Always ensure your VPN is connected before performing sensitive online activities.
