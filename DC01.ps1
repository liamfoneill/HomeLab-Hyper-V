$vms = @("DC01","DC02", "AADCONNECT01", "WEB01", "WEB02", "WEB03", "SQL01", "DEVOPS01")
$switchName = "Building Azure"
$netAdapterName = "Asus 10G"
$isoPath = "\\192.168.1.20\isos\en_windows_server_2019_updated_dec_2020_x64_dvd_36e0f791.iso"

New-VMSwitch `
-Name $switchName `
-NetAdapterName $netAdapterName `
-Notes "This is an external switch only to be used by computers in the buildingazure.co.uk domain."

foreach($vm in $vms){
New-VM `
-Name $vm `
-Generation 2 `
-MemoryStartupBytes "4096MB" `
-NewVHDPath "C:\Hyper-V\Virtual hard disks\$vm.vhdx" `
-NewVHDSizeBytes "40GB" `
-SwitchName $switchName

Set-VM `
-Name $vm `
-ProcessorCount 2

Add-VMDvdDrive `
-VMName $vm `
-Path $isoPath

Enable-VMIntegrationService `
-VMName $vm `
-Name "Guest Service Interface"

$HardDiskDrive = Get-VMHardDiskDrive -VMName $vm
$DVDDrive = Get-VMDvdDrive -VMName $vm

Set-VMFirmware `
$vm `
-BootOrder $DVDDrive, $HardDiskDrive 
}
