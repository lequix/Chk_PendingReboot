Chk Pending Reboot
--------------------

0#Overview:
This script checks if target hosts has pending reboot.

##Requirement:
- This requires a target host list (CSV)
- Each host specified on the list should permit remote access via PowerShell
- Each host specified on the list should be under AD. (No user authentication.)

##Usage
1) Set the following variables accordingly
   - $host_file (Default: host_list.csv)
     CSV file that specifies target hosts.
     First row should be "HostName".
		 Target host name(s) starts from the second row.
   - $output_csv (Default: result_PendingReboot_YYYYMMDD-hhmmss.csv
     CSV file to output the result.
2) Place a csv file (= $host_file) under the same directry of this script.
3) Run this script.
4) You'll get the output file under the same directry of this script.`

##Software Dependency
None

##License
MIT

##Author
Hiro Yamanoha
