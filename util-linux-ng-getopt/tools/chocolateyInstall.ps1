try {
  $sysDrive = $env:SystemDrive
  $gitBinPath = "$sysDrive\Program Files (x86)\Git\bin"
  
  $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $installerDir = Join-Path $scriptDir 'installer'
  
  Install-ChocolateyZipPackage 'util-linux-ng-bin' 'http://downloads.sourceforge.net/gnuwin32/util-linux-ng-2.14.1-bin.zip' "$installerDir"

  $getoptExe = Join-Path $installerDir 'bin\getopt.exe'
  
  Copy-Item "$getoptExe" "$gitBinPath"
  
  write-host 'util-linux-ng-bin has been added to git install directory'
  Write-ChocolateySuccess 'util-linux-ng-bin'
} catch {
  Write-ChocolateyFailure 'util-linux-ng-bin' $($_.Exception.Message)
  throw 
}



  