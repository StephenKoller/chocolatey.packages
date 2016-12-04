try {
  $sysDrive = $env:SystemDrive
  if (Test-Path "$sysDrive\Program Files (x86)\Git\bin") {
      $gitBinPath = "$sysDrive\Program Files (x86)\Git\bin"
  } elseif (Test-Path "$sysDrive\Program Files\Git\bin") { 
      $gitBinPath = "$sysDrive\Program Files\Git\bin"
  } else {
    write-host 'could not find git install directory'
    throw
  }
  
  $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $installerDir = Join-Path $scriptDir 'installer'
  
  Install-ChocolateyZipPackage 'util-linux-ng-bin' 'http://downloads.sourceforge.net/gnuwin32/util-linux-ng-2.14.1-bin.zip' "$installerDir"

  $getoptExe = Join-Path $installerDir 'bin\getopt.exe'
  
  Copy-Item "$getoptExe" "$gitBinPath"
  
  write-host 'util-linux-ng-bin has been added to git install directory'
} catch {
  throw $_.Exception
}
