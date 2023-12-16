# A little script that I made to automate the installation process of the rtl-sdr for a headless linux server.

- My script compiles and installs all the needed software to use the Realtek RTL2832 based DVB dongles as a SDR receiver.   

- It creates a systemd service file for the automatic startup and run at boot.

- My script works on both x86/x64bit and ARM based systems as it compiles from source.

# To use the Installation Script.

1. Just clone my repository on a fresh installation of Ubuntu server . 
2. Make the file auto_install_rtl-sdr.sh executable with ```sudo chmod +x auto_install_rtl-sdr.sh ```
3. Run the script ```sudo ./auto_install_rtl-sdr.sh```
4. Follow the prompts and answer a few questions
5. Reboot
6. Done 

# Help improve the script

If you would like to help me improve my scripts. Feel free to contact me zr6lsd@gmail.com

# Conclusion

Have fun with it! But keep in mind that I have not tested them on every other Linux distribution available and I cannot offer support to you if they don't work on yours. I would love to hear your comments and I will happily look at any suggestions for new features or code fixes but I do not have the time or inclination to run and test your modified versions, act as a beta tester or even offer useful advice if your changes are not working. I am NOT an expert; I am simply sharing tools that I use everyday.

# Donations

However, if you find any of my work or videos on my channel enjoyable or helpful, then any small donations would be greatly appreciated, and would help towards me creating more content. If you would like to help with a donation, you can do so via.

Litecoin LTC: LMGEaMySbztMVftx6WJextU1WEQAEEnrR9


DVB-T dongles based on the Realtek RTL2832U can be used as a cheap SDR, since the chip allows transferring the raw I/Q samples to the host, which is officially used for DAB/DAB+/FM demodulation. The possibility of this has been discovered by Eric Fry

Turns your Realtek RTL2832 based DVB dongle into a SDR receiver
======================================================================

For more information see:
https://osmocom.org/projects/rtl-sdr/wiki



