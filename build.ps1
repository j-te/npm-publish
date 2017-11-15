$VisualStudioVersion = "15.0" # 15 == Visual Studio 2017
$MsBuildPath = $(Get-ItemProperty "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\SxS\VS7").$VisualStudioVersion + "MSBuild\15.0\Bin\MSBuild.exe"

& "$PSScriptRoot\nuget.exe" restore

# Generating build output directory if it doesnt exist
New-Item -ItemType Directory -Force -Path "$PSScriptRoot\Xbim.WeXplorer\Build" | Out-Null

cd "$PSScriptRoot\Utilities\ShaderPacker"
& $MsBuildPath
cd "$PSScriptRoot\Utilities\TypingsBundler"
& $MsBuildPath
cd "$PSScriptRoot\Xbim.WeXplorer"
& npm install
& $MsBuildPath /p:Configuration=Release
./prepare_npm_bundles.ps1

cd "$PSScriptRoot"
