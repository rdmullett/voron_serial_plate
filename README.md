# voron_serial_plate
This is a serial plate creator for Voron machines. This is used as part of the backend by the voron_nameplate_bot on the /r/voroncorexy subreddit in order to automatically provide serial plates for all users that get a serial number for their printer. Details on that project can be found here:

[voron nameplate bot](https://github.com/rdmullett/voron_nameplate_bot)

![VoronSerialPlate](https://raw.githubusercontent.com/rdmullett/voron_serial_plate/main/Voron_Serial_Plate.jpg)

The project currently provides nameplates which fit on 2020 extrusion for all printers except for the V0, which has a plate that should fit 1515 extrusion.

The customizer allows you to choose if you want a logo, and the text should allow you to input your own Serial number.

Since customizer is broken on thingiverse (seems it's been broken for months and thingiverse won't fix it) you can use the following method to run customizer on your own computer:

	1. Download Openscad on your computer. - http://www.openscad.org/downloads.html
	2. Install the proper Voron font from here - https://fonts.google.com/specimen/Play?preview.text_type=custom .
		1. On Linux you can just move the .ttf file under /usr/share/fonts
		2. On Windows you can install it by just extracting the zip, and then opening the file. You should then see an install button
		3. On Mac I believe the process is quite similar to Windows.
	3. Download all project files. Make sure that the .scad file extracts into the same directory as the .stl files or it will not find the .stl files. I tested this, and confirmed that they do, but just make sure.
		1. Clone this this repository through git
		2. Download and extract zip from git
		3. Download all files from thingiverse
	4. Open the .scad file in Openscad. 
    	5. Use the customizer on the right hand side. You will see a "Parameters" dropdown, in which you can change 3 parameters
 	6. Render by pressing F6. You should see a preview. If a preview never loads, something is wrong.
	7. Export as STL with the little "STL" button on the toolbar on the left
	8. Gaze in awe at my SCAD code because this is my first project using it.

Credit for the V0 remix goes to oldfartt from thingiverse: https://www.thingiverse.com/thing:4947518
