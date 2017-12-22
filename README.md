# Scripts to connect and test an GPRS service on MacOS or Linux

## GPRS connect script
The scripts connects a Mac (or Linux) to the GPRS network. It allows testing of traffic towards the GPRS connection.
The PPP daemon will instanciate the ppp0 interface when connected.

## Usage

Make the scripts executable.

    $ chmod +x connect.sh env.sh 

First configure the serial device and the serial speed in the env.sh file.
The connected devices are listed in /dev/tty* and /dev/cu*.

Connect using the an empty APN:

    $ sudo ./connect.sh

Connect using APN as specified in the 1st parameter:

    $ sudo ./connect.sh <apnname>

Connect using APN as specified with username and password:

    $ sudo ./connect.sh <apnname> <username> <password>

##### Note: To disconnect, kill the pppd process in another terminal window.

## Testing the GPRS connection

To test, use explitly the ppp0 interface or specify the assigned IP as source address.
##### Example of testing a DNS connection:

    $ dig -b <src> @8.8.8.8 example.com

##### Example of testing ICMP towards the Google DNS:

    $ ping -S <src> 8.8.8.8
    $ ping -I ppp0 8.8.8.8

##### Example of testing an HTTP connection:

    $ curl -v --interface ppp0 "http://www.example.com/"

The \<src\> is the PPP assigned IP address, which will be shown in the console when running the connect.sh script.

## Notes
(Linux only) To limit the traffic, the IP traffic can be filtered in the options file with the paramater pass-filter.
The pass-filter specifies a packet filter to be applied to data packets being sent or received to determine which packets should be allowed to pass.
See man pppd.
