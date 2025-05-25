@echo off
setlocal

:: Check if gulpfile.js already exists
if exist gulpfile.js (
    echo -- gulpfile.js already exists in this folder. --
    echo -- Skipping creation... --
    @REM pause
    goto step2
)

:: Prompt for SCSS path
set /p scssPath=Enter the SCSS folder path (default: scss/): 
if "%scssPath%"=="" set scssPath=scss/

:: Prompt for CSS path
set /p cssPath=Enter the CSS folder path (default: css/): 
if "%cssPath%"=="" set cssPath=css/

:: Create gulpfile.js in the same directory
echo const gulp = require("gulp"),> gulpfile.js
echo   minifyCSS = require("gulp-clean-css"),>> gulpfile.js
echo   rename = require("gulp-rename"),>> gulpfile.js
echo   sass = require("gulp-sass")(require("sass")),>> gulpfile.js
echo   flatten = require("gulp-flatten");>> gulpfile.js
echo.>> gulpfile.js
echo // Alag base paths for scss and css>> gulpfile.js
echo const scssBase = "%scssPath%";>> gulpfile.js
echo const cssBase = "%cssPath%";>> gulpfile.js
echo const sassFiles = [scssBase + "**/*.scss", "" + scssBase + "**/_*.scss"];>> gulpfile.js
echo const cssDest = cssBase;>> gulpfile.js
echo.>> gulpfile.js
echo // Compile and directly minify SCSS -> .min.css>> gulpfile.js
echo function compileAndMinify() {>> gulpfile.js
echo   return gulp>> gulpfile.js
echo     .src(sassFiles)>> gulpfile.js
echo     .pipe(sass().on("error", sass.logError))>> gulpfile.js
echo     .pipe(minifyCSS())>> gulpfile.js
echo     .pipe(rename({ suffix: ".min" }))>> gulpfile.js
echo     .pipe(flatten())>> gulpfile.js
echo     .pipe(gulp.dest(cssDest));>> gulpfile.js
echo }>> gulpfile.js
echo.>> gulpfile.js
echo // Watch task>> gulpfile.js
echo function watch() {>> gulpfile.js
echo   gulp.watch(scssBase + "**/*.scss", compileAndMinify);>> gulpfile.js
echo }>> gulpfile.js
echo.>> gulpfile.js
echo gulp.task("default", watch);>> gulpfile.js
echo exports.build = compileAndMinify;>> gulpfile.js
echo exports.watch = watch;>> gulpfile.js

echo.
echo gulpfile.js created successfully!
echo.
echo SCSS path: "%scssPath%"
echo CSS path: "%cssPath%"
echo.
pause

:step2
set "filepath=%~dp0package.json"

REM Check if package.json exists
if exist "%filepath%" (
    echo.
    echo.
    choice /M "package.json already exists. Do you want to replace it?"
    if errorlevel 2 (
        echo.
        echo -- Skipped creating package.json. --
        echo.
        pause
        goto step3
    )
)

REM Create the package.json with the specified content
(
echo {
echo   "name": "hello",
echo   "main": "index.js",
echo   "scripts": {
echo     "gulp": "gulp"
echo   },
echo   "devDependencies": {
echo     "gulp": "^5.0.0",
echo     "gulp-clean-css": "^4.3.0",
echo     "gulp-flatten": "^0.4.0",
echo     "gulp-rename": "^2.0.0",
echo     "gulp-sass": "^6.0.1",
echo     "sass": "^1.89.0"
echo   }
echo }
) > "%filepath%"

echo.
echo.
echo package.json created at %filepath%
@echo off
title NPM and Gulp Setup

:: Step 3 - npm install
:step3
IF EXIST "node_modules" (
    echo.
    echo.
    echo -- node_modules folder already exists. Skipping npm install... --
    goto step4
)
echo.
echo.
set /p userInput=Do you want to run 'npm install'? (Y/N): 
set "userInput=%userInput:~0,1%"
IF /I "%userInput%"=="Y" (
    echo Running npm install...
    call npm install
    echo.
    echo Installation Success!
) ELSE (
    echo -- Skipped npm install. --
    pause
)

:: Step 4 - Run Gulp
:step4
set gulpChoice=

:GULP_PROMPT
echo.
echo.
<nul set /p=Do you want to run gulp? (Y/N): & set /p gulpChoice=

if /i "%gulpChoice%"=="Y" (
    echo Running gulp in same terminal...
    call gulp
    echo Done.
    pause
) else if /i "%gulpChoice%"=="N" (
    echo.
    echo -- Exiting without running gulp. --
    echo.
    pause
    goto end
) else (
    echo Invalid input. Please enter Y or N.
    goto GULP_PROMPT
)

:end
