<# 

Services to disable

 AllJoyn Router Service: 
    AJRouter
 
 Download Maps Manager:
    MapsBroker
    
 HomeGroup Services:
    HomeGroupListener
    HomeGroupProvider
    
 Remote Registry:
    RemoteRegistry
 
 Windows Media Player Sharing Service:
    WMPNetworkSvc

 Xbox Services:
    XboxGipSvc
    XblAuthManager
    XblGameSave
    XboxNetApiSvc

 Diagnostic Tracking:
    DiagTrack

#>


function Test-Admin
{
  $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
  $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  $prp.IsInRole($adm)  
}



if ((Test-Admin) -eq $false)
{
  Write-host "You need Administrator privileges to run this." -ForegroundColor Red
 
  # Abort the script
  # this will work only if you are actually running a script
  # if you did not save your script, the ISE editor runs it as a series
  # of individual commands, so break will not break then.
  break
}
ELSE
{
    # Write-Host "When you got to this point, you know the script has Admin privileges." -ForegroundColor Green

    Write-Host -ForegroundColor Yellow "Disabling Services"

    Set-Service -Status Stopped -StartupType Disabled -Name AJRouter
    Set-Service -Status Stopped -StartupType Disabled -Name MapsBroker
    Set-Service -Status Stopped -StartupType Disabled -Name HomeGroupListener
    Set-Service -Status Stopped -StartupType Disabled -Name HomeGroupProvider
    Set-Service -Status Stopped -StartupType Disabled -Name RemoteRegistry
    Set-Service -Status Stopped -StartupType Disabled -Name WMPNetworkSvc
    Set-Service -Status Stopped -StartupType Disabled -Name XboxGipSvc
    Set-Service -Status Stopped -StartupType Disabled -Name XblAuthManager
    Set-Service -Status Stopped -StartupType Disabled -Name XblGameSave
    Set-Service -Status Stopped -StartupType Disabled -Name XboxNetApiSvc
    Set-Service -Status Stopped -StartupType Disabled -Name DiagTrack

    Write-Host -ForegroundColor Green "Services Disabled"

}