

<#
$myVM = "AD2"
$myNetwork = "wifi"
$myVHDpath = 'C:\Virtual Machines\AD2.vhdx'
$myParentpath = "C:\Virtual Machines\Bases\Base Windows Server 2012 R2 Dat x64 GUI - English.vhdx"

$VmName
$VirtualSwitch
$VHDPath 
$parentPath
$generation 
$staticMemory
$ProcessorCount

#>


function New-VirtualMachine{

 Param
    (

[parameter(Mandatory=$true)]
$VmName,

$VirtualSwitch,
[parameter(Mandatory=$true)]
$VHDPath,

[parameter(Mandatory=$true)] 
$ParentPath,

[parameter(Mandatory=$true)]
[ValidateSet(1,2)]
[int]
$Generation, 

$StaticMemory,

[int]$ProcessorCount = 1
    
)


$VHDX = New-VHD -Path $VHDpath -ParentPath $ParentPath -Differencing 
$VmName = New-VM -Name $VmName -MemoryStartupBytes 1GB -Generation $generation -VHDPath $VHDPath
$VmName | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName $virtualSwitch
$VmName | Set-VM -ProcessorCount $ProcessorCount 
}
New-VirtualMachine -VmName AD2 -VirtualSwitch wifi -VHDPath "C:\Virtual Machines\AD2.vhdx" -ParentPath "C:\Virtual Machines\Bases\Base Windows Server 2012 R2 Dat x64 GUI - English.vhdx" -Generation 2 
