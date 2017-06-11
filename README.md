# raspi-connect
Scripts and a webserver to connect a raspberry pi to an existing network

# Usage
To set up, simply run `sudo ./install.sh`. This will install the required packages and place all the configs in the required positions.

To enable, run `sudo ./raspi-connect.sh enable`. This will put the pi into broadcasting mode.

To disable, run `sudo ./raspi-connect.sh disable`. The pi will go back to connecting to the configured wifi network.

# Known Issues
Sometimes, the pi will not re-connect to wifi after the `disable` command is run. Usually, this can be fixed by re-enabling the broadcast mode and then disabling it again. If not, reboot and it should be fine then.

# Planned additions
* Prompt to configure settings such as SSID, password, auth type, IP, etc.
* Simple webserver that can take input and generate a wpa_supplicant file
