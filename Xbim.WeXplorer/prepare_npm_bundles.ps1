function copyDefinitionFilesToFolder {
    Param($targetDir)
    
	Get-ChildItem $PSScriptRoot -Filter "*.d.ts" `
		-Recurse | `
		? { $_.FullName -inotmatch "node_modules" }  | `
		? { $_.FullName -inotmatch "npm_bundle_output" } | `
		? { $_.FullName -inotmatch "examples" } | `
		ForEach-Object { 
			$targetFile = $targetDir + $_.FullName.SubString($PSScriptRoot.Length); 
			[void](New-Item -ItemType File -Path $targetFile -Force)
			Copy-Item $_.FullName -destination $targetFile 
		} 
}

# Preparing bundle files for xbim-viewer
Copy-Item $PSScriptRoot\..\README.md $PSScriptRoot\npm_bundle_output\xbim-viewer\README.md
Copy-Item $PSScriptRoot\Build\xbim-viewer.js $PSScriptRoot\npm_bundle_output\xbim-viewer\xbim-viewer.js
Copy-Item $PSScriptRoot\Build\xbim-viewer.min.js $PSScriptRoot\npm_bundle_output\xbim-viewer\xbim-viewer.min.js
Copy-Item $PSScriptRoot\Build\xbim-geometry-loader.js $PSScriptRoot\npm_bundle_output\xbim-viewer\xbim-geometry-loader.js
Copy-Item $PSScriptRoot\Build\xbim-geometry-loader.min.js $PSScriptRoot\npm_bundle_output\xbim-viewer\xbim-geometry-loader.min.js

# Preparing bundle files for xbim-browser
Copy-Item $PSScriptRoot\..\README.md $PSScriptRoot\npm_bundle_output\xbim-browser\README.md
Copy-Item $PSScriptRoot\Build\xbim-browser.js $PSScriptRoot\npm_bundle_output\xbim-browser\xbim-browser.js
Copy-Item $PSScriptRoot\Build\xbim-browser.min.js $PSScriptRoot\npm_bundle_output\xbim-browser\xbim-browser.min.js
Copy-Item $PSScriptRoot\Build\xbim-browser.css $PSScriptRoot\npm_bundle_output\xbim-browser\xbim-browser.css
Remove-Item -Recurse -Force $PSScriptRoot\npm_bundle_output\xbim-browser\Libs\jquery-ui-styles\
Copy-Item $PSScriptRoot\Libs\jquery-ui-styles\ -Recurse -Destination $PSScriptRoot\npm_bundle_output\xbim-browser\Libs\jquery-ui-styles\ -Container

copyDefinitionFilesToFolder "$PSScriptRoot\npm_bundle_output\xbim-viewer\"
copyDefinitionFilesToFolder "$PSScriptRoot\npm_bundle_output\xbim-browser\"
