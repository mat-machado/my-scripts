# Docker Scripts

**Here we have several Scripts for Docker, made in PowerShell. (Windows 10 and Windows 11)**

### Docker Installation

The Script will install Docker Desktop in its latest version, and will use WSL for that.
:tw-26a0: To install Docker, you must first check if your Windows is up to date, via Windows Update.

1. Right-click on the `Install-WSL.ps1` file and click on the option Run with Powershell
2. After the script finishes, restart the computer
3. Repeat step number 1
4. Right-click on the `Install-Docker.ps1` file and click on the option Run with Powershell
5. Restart the computer

### Remove data from Docker

There are two scripts for removing data from within Docker.

##### Soft-Reset-Docker.ps1

:tw-26d4: Be sure you want to run this, can not be restored!
For all containers, remove them, delete networks and volumes. It just doesn't delete the images.

##### Reset-Docker.ps1

:tw-26d4: Be sure you want to run this, can not be restored!
Absolutely removes everything from Docker, including the images.
