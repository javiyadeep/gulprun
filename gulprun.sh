#!/bin/bash

# Always run from the script's directory
cd "$(dirname "$0")"

# Function to prompt with a default
prompt_with_default() {
  read -p "$1 [$2]: " input
  echo "${input:-$2}"
}

# Step 1 - Check if gulpfile.js exists
if [ -f "gulpfile.js" ]; then
  echo "-- gulpfile.js already exists in this folder. --"
  echo "-- Skipping creation... --"
else
  # Prompt for SCSS and CSS paths
  scssPath=$(prompt_with_default "Enter the SCSS folder path" "scss/")
  cssPath=$(prompt_with_default "Enter the CSS folder path" "css/")

  # Create gulpfile.js
  cat <<EOF > gulpfile.js
const gulp = require("gulp"),
  minifyCSS = require("gulp-clean-css"),
  rename = require("gulp-rename"),
  sass = require("gulp-sass")(require("sass")),
  flatten = require("gulp-flatten");

// Alag base paths for scss and css
const scssBase = "${scssPath}";
const cssBase = "${cssPath}";
const sassFiles = [scssBase + "/.scss", "" + scssBase + "/_.scss"];
const cssDest = cssBase;

// Compile and directly minify SCSS -> .min.css
function compileAndMinify() {
  return gulp
    .src(sassFiles)
    .pipe(sass().on("error", sass.logError))
    .pipe(minifyCSS())
    .pipe(rename({ suffix: ".min" }))
    .pipe(flatten())
    .pipe(gulp.dest(cssDest));
}

// Watch task
function watch() {
  gulp.watch(scssBase + "/*.scss", compileAndMinify);
}

gulp.task("default", watch);
exports.build = compileAndMinify;
exports.watch = watch;
EOF

  echo "gulpfile.js created successfully!"
  echo "SCSS path: $scssPath"
  echo "CSS path: $cssPath"
fi

# Step 2 - Create or overwrite package.json
if [ -f "package.json" ]; then
  read -p "package.json already exists. Do you want to replace it? (y/n): " choice
  if [[ "$choice" != [Yy] ]]; then
    echo "-- Skipped creating package.json. --"
  else
    create_package="yes"
  fi
else
  create_package="yes"
fi

if [ "$create_package" == "yes" ]; then
  cat <<EOF > package.json
{
  "name": "hello",
  "main": "index.js",
  "scripts": {
    "gulp": "gulp"
  },
  "devDependencies": {
    "gulp": "^5.0.0",
    "gulp-clean-css": "^4.3.0",
    "gulp-flatten": "^0.4.0",
    "gulp-rename": "^2.0.0",
    "gulp-sass": "^6.0.1",
    "sass": "^1.89.0"
  }
}
EOF
  echo "package.json created successfully."
fi

# Step 3 - npm install
if [ -d "node_modules" ]; then
  echo "-- node_modules already exists. Skipping npm install... --"
else
  read -p "Do you want to run 'npm install'? (y/n): " yn
  if [[ "$yn" == [Yy] ]]; then
    echo "Running npm install..."
    npm install
    echo "Installation complete!"
  else
    echo "-- Skipped npm install. --"
  fi
fi

# Step 4 - Run gulp
read -p "Do you want to run gulp? (y/n): " runGulp
if [[ "$runGulp" == [Yy] ]]; then
  echo "Running gulp..."
  gulp
else
  echo "-- Exiting without running gulp. --"
fi