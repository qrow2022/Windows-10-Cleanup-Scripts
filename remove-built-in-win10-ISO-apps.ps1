
#Source for following admin check: http://www.powertheshell.com/testadmin/


function Test-Admin
{
  $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
  $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  $prp.IsInRole($adm)  
}



if ((Test-Admin) -eq $false)
{
  Write-Warning "You need Administrator privileges to run this."
 
  # Abort the script
  # this will work only if you are actually running a script
  # if you did not save your script, the ISE editor runs it as a series
  # of individual commands, so break will not break then.
  break
}
ELSE
{
    Write-Host "Hooray, you're using Admin Creds. Starting the Magic."
    
    Write-Host "Mounting the image."
    mount-windowsimage -imagepath F:\temp2\install.wim -Index 2 -path F:\mount

    Write-Host "Done Mounting, Removing builtin apps."
    Write-Host "Removing Xbox."
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.Xbox.TCUI_1.8.24001.0_neutral_~_8wekyb3d8bbwe
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.XboxApp_31.32.16002.0_neutral_~_8wekyb3d8bbwe
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.XboxGameOverlay_1.20.25002.0_neutral_~_8wekyb3d8bbwe
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.XboxIdentityProvider_2017.605.1240.0_neutral_~_8wekyb3d8bbwe
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_neutral_~_8wekyb3d8bbwe

    Write-Host "Removing Office Related Apps."
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.MicrosoftOfficeHub_2017.715.118.0_neutral_~_8wekyb3d8bbwe
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.Office.OneNote_2015.8366.57611.0_neutral_~_8wekyb3d8bbwe

    Write-Host "Removing Skype."
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.SkypeApp_11.18.596.0_neutral_~_kzf8qxf38zg5c

    Write-Host "Removing Windows Wallet."
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.Wallet_1.0.16328.0_neutral_~_8wekyb3d8bbwe

    Write-Host "Removing FeedbackHub."
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.WindowsFeedbackHub_1.1705.2121.0_neutral_~_8wekyb3d8bbwe

    Write-Host "Removing Maps."
    Remove-AppxProvisionedPackage -Path F:\mount -PackageName Microsoft.WindowsMaps_2017.814.2249.0_neutral_~_8wekyb3d8bbwe


    Write-Host "Done Removing apps, Dismounting image."
    Dismount-WindowsImage -Path F:\mount -Save

}

Write-Host "Done."

<#
Create new iso from updated wim file

https://www.thomasmaurer.ch/2013/03/add-drivers-to-windows-server-2012-iso-image/
#oscdimg -n -m -bc:\temp\ISO\boot\etfsboot.com C:\temp\ISO C:\temp\mynew.iso 

https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/oscdimg-command-line-options
#>

<# 

Convert esd file to wim file
https://www.intel.com/content/www/us/en/support/articles/000023992/memory-and-storage/intel-optane-memory.html

#>