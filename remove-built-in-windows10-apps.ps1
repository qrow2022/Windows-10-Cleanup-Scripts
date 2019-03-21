


<#
Scripts to remove built-in unwanted Windows 10 Apps

Syntax:

Get-AppxPackage -Name *Partialname* | RemoveAppxPackage

Optional Switch -AllUsers

#>

#Removes get office app
Get-AppxPackage *officehub* | Remove-AppxPackage

#Removes Skype App
Get-AppxPackage *skypeapp* | Remove-AppxPackage

#Removes Maps
Get-AppxPackage *maps* | Remove-AppxPackage

#Removes Solitaire Collection
get-appxpackage *solitaire* | remove-appxpackage

#Removes Microsoft Wallet
get-appxpackage *wallet* | remove-appxpackage

#Removes Microsoft WIFI (Paid WIFI)
get-appxpackage *connectivitystore* | remove-appxpackage

#Removes Money, Sports, News, and Weather
get-appxpackage *bing* | remove-appxpackage

#Removes Onenote app
get-appxpackage *onenote* | remove-appxpackage

#Removes Paid WIFI and Cellular
get-appxpackage *oneconnect* | remove-appxpackage

#Removes Windows Sway
get-appxpackage *sway* | remove-appxpackage

#Removes Candy Crush
Get-AppxPackage *king.com.CandyCrushSaga* | Remove-AppxPackage

#Remove XBOX
#get-appxpackage *xbox* | remove-appxpackage

#Remove Twitter
Get-AppxPackage *twitter* | Remove-AppxPackage

#Remove Ebay
Get-AppxPackage *ebay* | Remove-AppxPackage

#Remove Amazon
Get-AppxPackage *amazon* | Remove-AppxPackage

Get-AppxPackage *help*

Get-AppxPackage *feedback*

Get-AppxPackage *zune*

Get-AppxPackage *messaging*

Get-AppxPackage *3d*

Get-AppxPackage *notes*

Get-AppxPackage *recorder*

Get-AppxPackage *tips*

Get-AppxPackage *paint*

Get-AppxPackage 

Write-Host {Removal of apps complete}




#Enterprise Removal options:

<#

Remove 3D Builder
get-appxpackage *3dbuilder* | remove-appxpackage

Remove Mail and Calender
get-appxpackage *communicationsapps* | remove-appxpackage

Remove Feedback Hub
get-appxpackage *feedback* | remove-appxpackage

Remove Camera
get-appxpackage *camera* | remove-appxpackage

Remove Phone
get-appxpackage *commsphone* | remove-appxpackage

Remove Phone Companion
get-appxpackage *windowsphone* | remove-appxpackage

Remove XBOX
get-appxpackage *xbox* | remove-appxpackage

Remove Twitter
Get-AppxPackage *twitter* | Remove-AppxPackage


#>
