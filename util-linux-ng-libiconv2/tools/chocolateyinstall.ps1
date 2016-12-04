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

  Install-ChocolateyZipPackage 'util-linux-ng-libiconv2' 'http://downloads.sourceforge.net/gnuwin32/util-linux-ng-2.14.1-dep.zip' "$installerDir"

  $libiconv2Dll = Join-Path $installerDir 'bin\libiconv2.dll'

  Copy-Item "$libiconv2Dll" "$gitBinPath"

  write-host 'libiconv2.dll has been added to git install directory'
} catch {
  throw $_.Exception
}
