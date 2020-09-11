#https://devblogs.microsoft.com/scripting/use-powershell-to-discover-multi-monitor-information/

Class PcConfig {
    $ComputerName
    $GraphicCard
    $VideoController
    $Ram
    $MotherBoard

    Pcconfig(){
        $This.ComputerName = $Env:COMPUTERNAME
        $This.GraphicCard = Get-CimInstance -Class "win32_videocontroller" -namespace "root\CIMV2" | select Name,@{n="RAM(GB)";e={$_.AdapterRAM/1GB}},VideoProcessor,MaxRefreshRate,minRefreshRate,status,DriverDate,DriverVersion,VideoModeDescription,CurrentBitsPerPixel,CurrentRefreshRate,CurrentHorizontalResolution,CurrentVerticalResolution
        $this.MotherBoard = get-ciminstance -class Win32_BaseBoard | select Manufacturer,Product,Version
        $This.Ram = get-ciminstance -class "win32_physicalmemory" | select Manufacturer,partnumber,@{n="Capacity(GB)";e={$_.Capacity/1GB}},speed,BankLabel,devicelocator
        #$NumberofRamSlots = (Get-CimInstance -Class "win32_PhysicalMemoryArray" -namespace "root\CIMV2" ).MemoryDevices
    }

    ToString(){


    }
}

[PcConfig]::New()

$ComputerName = $Env:COMPUTERNAME

function Get-Temperature {
    $Temperatures = (Get-ciminstance -class MSAcpi_ThermalZoneTemperature -Namespace "root/wmi")
    Foreach($Temp in $Temperatures){
        ($Temp.CurrentTemperature - 2732) / 10
    }
     $Current - 2732 / 10
}

Get-Temperature


$Monitor = Get-CimInstance -Class "Win32_Desktopmonitor" -Namespace "root\CIMV2"
#(Get-CimInstance -Namespace "root\wmi" -ClassName "WmiMonitorBasicDisplayParams").SupportedDisplayFeatures
$CM = 


#See prop SupportedDisplayFeatures 
