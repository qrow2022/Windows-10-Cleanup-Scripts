# Windows 10 Cleanup Powershell Commands

This repo contains several scripts that can be used to remove the inbox default Windows 10 junk *\*Cough Features Cough*\* Universal apps.


Holographic-reg-edit.ps1 will change the registry for the system, allowing the hidden holographic app to become visible and then removable. The holographic app is hidden on systems that do not have the necessary specs for the holographic system to run, such as a dedicated graphics card.

Remove-built-in-windows10-apps.ps1 will remove apps from all profiles in a currently running system.

Remove-built-in-win10-ISO-apps.ps1 will remove the apps from a mounted ISO file to prevent their installation from the start.

Win10-disable-services.ps1 will shutdown certain Windows 10 services that I find to be either useless, not necessary for my workflow, or to possibly be privacy issues.



## To Do
- Update Scripts (Haven't been updated since possibly 1809)
- Combine some of the scripts into one large script with options on which to run
- Create different app removal levels, such as
  - Basic
  - Strict
  - Custom
