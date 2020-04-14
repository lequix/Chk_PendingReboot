#Check Pending Reboot on Windows Servers
#Version: 1.0.0

#Disable Error Output
$ErrorActionPreference = "silentlycontinue"

#Host List (CSV) to import 
$host_file =  $PSScriptRoot + "\host_list.csv"

#Output file (CSV) for results: Result_PendingReboot_YYYYMMDD-hhmmss.csv
$output_csv =  $PSScriptRoot + "\Result_PendingReboot_" + (get-date).ToString('yyyyMMdd-hhmmss') + ".csv"

#Registry
$registry_path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update'
$registry_name = "RebootRequired"

#Set Headers to Output file (CSV)
echo "HostName, PendingReboot" | Out-File -Append $output_csv -Encoding UTF8

#Import host names (or IP addresses) from a Host List (=$host_file: CSV)
Import-Csv $host_file | ForEach-Object {
    try {
        #get a HostName from the Host List (CSV) 
        $target_host = $_.HostName
        #Login and execute a command through PowerShell remotely.
        #If this script cannot access the target host, it goes to catch section
        $result = invoke-command -ComputerName $target_host -ScriptBlock {
            #Check if the specified Registry exists.
            #If it exists, it returns "True" (If not, it returns true)
            if (Get-ItemProperty -Path $args[0] -Name $args[1] -ErrorAction ignore)
                        {return "True" } else { return "False" } 
        } -ArgumentList $registry_path, $registry_name -ErrorAction Stop
        
        echo ($target_host + ":" + $result) 
        $target_host + "," + $result | Out-File -Append $output_csv -Encoding UTF8
    }
    #In case this script cannot access the target host, the following catch section is executed.
    catch {
        #Output "Connection Error" to the output file (CSV) as a result of connection error.
        echo ($target_host + ":" + "Connection Error")
        $output_error = "Error"
        $target_host + "," + $output_error | Out-File -Append $output_csv -Encoding UTF8
    }
}