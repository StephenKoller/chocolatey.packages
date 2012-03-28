try {
  $sysDrive = $env:SystemDrive
  $gitBinPath = "$sysDrive\Program Files (x86)\Git\bin"
  
  $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $installerDir = Join-Path $scriptDir 'installer'
  
  Install-ChocolateyZipPackage 'util-linux-ng-libintl3' 'http://downloads.sourceforge.net/gnuwin32/util-linux-ng-2.14.1-dep.zip' "$installerDir"

  $libintl3Dll = Join-Path $installerDir 'bin\libintl3.dll'
  
  Copy-Item "$libintl3Dll" "$gitBinPath"
  
  write-host 'libintl3.dll has been added to git install directory'
  Write-ChocolateySuccess 'util-linux-ng-libintl3'
} catch {
  Write-ChocolateyFailure 'util-linux-ng-libintl3' $($_.Exception.Message)
  throw 
}
