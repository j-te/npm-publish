rem Generate fresh documentation and build packages
npm run build
rem Copy new built files to the sample project to make sure it's running the with the latest source
xcopy /y Build\xbim-viewer.js Resources\doctemplate\static\scripts\
xcopy /y Build\xbim-browser.js Resources\doctemplate\static\scripts\
