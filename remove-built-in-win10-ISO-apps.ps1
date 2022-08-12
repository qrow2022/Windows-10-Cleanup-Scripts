
<#
Create new iso from updated wim file

https://www.thomasmaurer.ch/2013/03/add-drivers-to-windows-server-2012-iso-image/
#oscdimg -n -m -bc:\temp\ISO\boot\etfsboot.com C:\temp\ISO C:\temp\mynew.iso 

https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/oscdimg-command-line-options

Convert esd file to wim file
https://www.intel.com/content/www/us/en/support/articles/000023992/memory-and-storage/intel-optane-memory.html

#>


#Requires -RunAsAdministrator


Add-Type -AssemblyName System.Windows.Forms


Function Set-WimFile {

    $fileSelector = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
        InitialDirectory = [System.Environment]::GetFolderPath('Desktop')
        Filter = 'WIM (*.wim, *.esd)|*.wim;*.esd' 
    }

    $null = $fileSelector.ShowDialog()

    $wimFile = $fileSelector.FileName

    return $wimFile
}

Function Set-Directory {

    $folderSelector = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderSelector.SelectedPath = "C:\WIM_Temp"
    $folderSelector.ShowNewFolderButton = $true
    $folderSelector.Description = "Select a directory."

    $null = $folderSelector.ShowDialog()

    $tempDirectory = $folderSelector.SelectedPath

    return $tempDirectory

}

Function Set-DesiredImageIndex($index, $wim, $destination, $newImageName) {


    Export-WindowsImage -SourceImagePath $wim -SourceIndex $index -DestinationImagePath $destination -DestinationName $newImageName -CompressionType max -CheckIntegrity

}

Function Remove-BuiltInApps($selectedVersion, $tempDir) {

    # Windows 10 21H2 versions
    $appsToRemoveWin10_21H2 = @("Microsoft.BingWeather_4.25.20211.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Getstarted_8.2.22942.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Microsoft3DViewer_6.1908.2042.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftOfficeHub_18.1903.1152.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftSolitaireCollection_4.4.8204.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MixedReality.Portal_2000.19081.1301.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Office.OneNote_16001.12026.20112.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.People_2019.305.632.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.SkypeApp_14.53.77.0_neutral_~_kzf8qxf38zg5c",
    "Microsoft.Wallet_2.4.18324.0_neutral_~_8wekyb3d8bbwe",
    "microsoft.windowscommunicationsapps_16005.11629.20316.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsFeedbackHub_2019.1111.2029.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsMaps_2019.716.2316.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Xbox.TCUI_1.23.28002.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxApp_48.49.31001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxGameOverlay_1.46.11001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxGamingOverlay_2.34.28001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxIdentityProvider_12.50.6001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.YourPhone_2019.430.2026.0_neutral_~_8wekyb3d8bbwe")
    
    
    $appsToRemoveWin11_21H2 = @("Microsoft.BingNews_4.7.28001.0_neutral_~_8wekyb3d8bbwe", 
    "Microsoft.BingWeather_4.25.20211.0_neutral_~_8wekyb3d8bbwe", 
    "Microsoft.WindowsMaps_2022.2205.9.0_neutral_~_8wekyb3d8bbwe", 
    "Microsoft.GamingApp_2207.1001.6.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Getstarted_10.2.41172.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Microsoft3DViewer_6.1908.2042.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftSolitaireCollection_4.6.3102.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftOfficeHub_18.2205.1091.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MixedReality.Portal_2000.19081.1301.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Office.OneNote_16001.12026.20112.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.People_2021.2105.4.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.SkypeApp_14.53.77.0_neutral_~_kzf8qxf38zg5c",
    "Microsoft.Wallet_2.4.18324.0_neutral_~_8wekyb3d8bbwe",
    "microsoft.windowscommunicationsapps_16005.12827.20400.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsFeedbackHub_2021.427.1821.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Xbox.TCUI_1.24.10001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxApp_48.49.31001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxGameOverlay_1.54.4001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxGamingOverlay_5.822.6271.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxIdentityProvider_12.90.14001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxSpeechToTextOverlay_1.21.13002.0_neutral_~_8wekyb3d8bbwe")


    Switch($selectedVersion) {

        10 {

            foreach ($currentApp in $appsToRemoveWin10_21H2) {
                
                Write-Host "Removing app: $currentApp"

                Remove-AppxProvisionedPackage -Path $tempDir -PackageName $currentApp

            }


        }
        11 {

            ForEach ($currentApp in $appsToRemoveWin11_21H2) {

                Write-Host "Removing app: $currentApp"

                Remove-AppxProvisionedPackage -Path $tempDir -PackageName $currentApp

            }

        }
        Default {

            Write-Host "You picked a version of windows that I don't know about yet. Please start over."
            Write-Host "Exiting....."

            Exit
        }



    }
}


Write-Host "Which version of Windows are you editing? 10 or 11? : " -NoNewline -ForegroundColor Yellow

$winVersion = Read-Host


Write-Host "Select the .wim/.esd file to edit. Opening file selector dialog."
Start-Sleep 3

            
$wimFile = Set-WimFile

#DISM show available images inside of wim

Write-Host "Which image index do you wish to edit? Displaying index now:"
Start-Sleep 3
            
Get-WindowsImage -ImagePath $wimFile

$imageIndex = Read-Host "Select index number: "


Write-Host "Please select the temporary directory to mount the image in and process the changes"
Write-Host "Launching the folder picker...."
Start-Sleep 3

$tempDirectory = Set-Directory

Write-Host "Please select the destination directory to save the new wim file to:"
Write-Host "Launching the folder picker....."
Start-Sleep 3

$destinationDirectory = Set-Directory

$destinationFile = $destinationDirectory + "\$imageIndex.wim"

Write-Host "Give your new image a custom name. EX: 'Win10 Pro - No Apps'"
$customName = Read-Host "Custom image name: "

Write-Host ""
Write-Host ""


Write-Host "You chose the following settings:"
Write-Host "Windows version = $winVersion"
Write-Host "WIM file = $wimFile"
Write-Host "Index # = $imageIndex"
Write-Host "Temp working directory = $tempDirectory"
Write-Host "Destination directory/file = $destinationFile"
Write-Host "Custom image name = $customName"
Write-Host ""

$confirmSettings = Read-Host "Please confirm your settings. ( y/n ): "

IF ($confirmSettings -eq "y" -or "yes") {

    # extract index from wim or esd file
    Write-Host "Extracting desired image index to destination for future editing"
    Set-DesiredImageIndex $imageIndex $wimFile $destinationFile $customName
                
    # Mount image in temp folder
    Write-Host "Mounting index for editing."
    Mount-WindowsImage -ImagePath $destinationFile -Index 1 -Path $tempDirectory
    
    #remove apps
    Write-Host "Removing built-in apps."

    Remove-BuiltInApps $winVersion $tempDirectory
                
                
    #dismount image
    Write-Host "Dismounting the wim file."
    Dismount-WindowsImage -Path $tempDirectory -Save

    Rename-Item -Path $destinationFile -NewName "install.wim"


    Write-Host "Finished with edits."
                


}ELSE {

    Write-Host "I don't know what you responded with. Please start over. Exiting...."

    Exit
}

