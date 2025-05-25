# SCSS to CSS Automation using Gulp

This project provides a simple setup to automate the compilation of SCSS files into CSS using Gulp. It includes scripts for both Windows (`gulprun.bat`) and macOS (`gulprun.sh`) to streamline the process.

## Prerequisites

Ensure you have the following installed on your system:

- **Node.js**: Download and install from [https://nodejs.org/en/download](https://nodejs.org/en/download).
- **Gulp**: Install Gulp CLI globally as described in the [Gulp Quick Start Guide](https://gulpjs.com/docs/en/getting-started/quick-start/).

### Verify Installation

After installing Node.js, open a terminal (Command Prompt for Windows or Terminal for macOS) and run the following commands to check the versions:

```bash
node -v
npm -v
npx -v
```

If these commands return version numbers, your setup is correct. If not, reinstall Node.js and try again.

## Setup Instructions

### 🪟 For Windows Users

1. **Add the Script**:
   - Copy the `gulprun.bat` file to the root folder of your project.

2. **Run the Script**:
   - Double-click the `gulprun.bat` file to execute it.

3. **Set SCSS and CSS Paths**:
   - The script will prompt you to specify the paths for your SCSS and CSS folders.
   - Enter the desired paths (e.g., `src/scss/` for SCSS and `dist/css/` for CSS).
   - If you press Enter without specifying paths, the default paths (`scss/` for SCSS and `css/` for CSS) will be used.

4. **Install Node Modules**:
   - The script will ask if you want to install the required `node_modules`. Confirm to proceed with the installation.

5. **Run Gulp**:
   - The script will prompt you to run Gulp to compile your SCSS files into CSS.
   - Once confirmed, Gulp will process the SCSS files in the specified (or default) SCSS folder and output the compiled CSS files to the specified (or default) CSS folder.

### 🍏 For macOS Users

1. **Add the Script**:
   - Copy the `gulprun.sh` file to the root folder of your project.

2. **Make the Script Executable**:
   - Open the Terminal and navigate to your project folder. For example:
     ```bash
     cd /Users/xyz/Desktop/xyz-project
     ```
   - Run the following command to make the script executable:
     ```bash
     chmod +x gulprun.sh
     ```
   - Close the Terminal.

3. **Run the Script**:
   - Double-click the `gulprun.sh` file to execute it.

4. **Set SCSS and CSS Paths**:
   - The script will prompt you to specify the paths for your SCSS and CSS folders.
   - Enter the desired paths (e.g., `src/scss/` for SCSS and `dist/css/` for CSS).
   - If you press Enter without specifying paths, the default paths (`scss/` for SCSS and `css/` for CSS) will be used.

5. **Install Node Modules**:
   - The script will ask if you want to install the required `node_modules`. Confirm to proceed with the installation.

6. **Run Gulp**:
   - The script will prompt you to run Gulp to compile your SCSS files into CSS.
   - Once confirmed, Gulp will process the SCSS files in the specified (or default) SCSS folder and output the compiled CSS files to the specified (or default) CSS folder.

## Troubleshooting

If you encounter any issues during setup or execution, please contact [patelaleis@gmail.com](mailto:patelaleis@gmail.com) for assistance.