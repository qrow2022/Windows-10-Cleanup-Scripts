

Write-Host ""


#Setting Variables for later use.
$RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"
$Name = "FirstRunSucceeded"
#Variable set by checking what the current value for the registry entry is set to.
$OriginalValue = (Get-ItemPropertyValue -Path $RegistryPath -name "$Name")


Write-Host "Checking if $RegistryPath Exists."


#Checking if registry path exists before attempting to modify.
if((Test-Path $RegistryPath)){
Write-Host "Found Path."


Write-Host "Checking Value of $Name."

    #Checking the value of the Registry entry, if 0, then change to 1.
    if((Get-ItemProperty -Path $RegistryPath -name "$Name").$Name -eq 0) {
        Write-Host "$Name is Set to $OriginalValue."
        Write-Host "Setting Value to 1."
        Set-ItemProperty -Path $RegistryPath -name "$Name" -Value '1'
        Exit
        }

    #If 1 already, tell the user and exit.
    ELSEif((Get-ItemProperty -Path $RegistryPath -name "$Name").$Name -eq 1) {
        Write-Host "Value Already Set to 1, Exiting."
        Exit
        }

    #If the value is neither 1 nor 0, tell the user what it is.
    ELSE{
        Write-Host "The Value is set to something Else."
        Write-Host "Value = $OriginalValue."
        Write-Host ""
        #Ask the user if they would like to change the value to 1.
        Write-Host "Would you like to change the value to 1?" -ForegroundColor Yellow
            #Read input from the console.
            $ReadHost = Read-Host " ( y / n ) "
            #Check console input.
            Switch ($ReadHost)
                {
                   Y { #User said Yes, change value to 1.
                       Write-Host "Changing due to Y."
                       Set-ItemProperty -Path $RegistryPath -name "$Name" -Value '1'
                       $NewValue = (Get-ItemPropertyValue -Path $RegistryPath -name "$Name")
                       Write-Host "Value now = $NewValue."
                       Exit
                      }
                   N { #User said No, don't change value, exit.
                       Write-Host "Not changing due to N."
                       Write-Host "Leaving Value = $OriginalValue."
                       Exit
                      }
                   Yes { #User said Yes, change value to 1.
                        Write-Host "Changing due to Yes."
                        Set-ItemProperty -Path $RegistryPath -name "$Name" -Value '1'
                        $NewValue = (Get-ItemPropertyValue -Path $RegistryPath -name "$Name")
                        Write-Host "Value now = $NewValue."
                        Exit
                        }
                   No { #User said No, don't change value, exit.
                        Write-Host "Not changing due to No."
                        Write-Host "Leaving Value = $OriginalValue."
                        Exit
                        }
                   Default { #User either typed something unknown, or just hit enter, do nothing and exit.
                            Write-Host "Default / Unknown input, not changing."
                            Write-Host "Leaving Value = $OriginalValue."
                            Exit
                            }
                }
        }

} 
#If Registry path doesn't exist, tell the user.
ELSE{
        Write-Host "The Registry Path doesn't exist, this probably isn't a Windows 10 OS." 
        Exit
        }

Write-Host ""