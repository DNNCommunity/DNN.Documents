name: Automated Build

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]
  workflow_dispatch:

jobs:
  build:
    runs-on: windows-latest
    name: Build And Store
    env:
      solution-path: './Source/DotNetNuke.Documents.sln'
    steps:
    - uses: actions/checkout@v4
      with:
        fetch-depth: 0
    
    - name: Install GitVersion
      uses: gittools/actions/gitversion/setup@v4.2.0
      with:
        versionSpec: '6.4.0'

    - name: Determine Version
      id: gitversion
      uses: gittools/actions/gitversion/execute@v4.2.0

    # https://github.com/valadas/set-dnn-manifest-versions
    - name: Update Versions on DNN Modules
      uses: valadas/set-dnn-manifest-versions@v1
      with:
        version: ${{ steps.gitversion.outputs.majorMinorPatch }}
        includeSolutionInfo: true

    - name: Add msbuild to PATH
      uses: microsoft/setup-msbuild@v1.1.3
    
    - name: Restore NuGet Packages
      run: nuget restore "${{ env.solution-path }}"
    
    - name: Build the solution
      run: msbuild "${{ env.solution-path }}" /p:Configuration=Release;
      
    - name: Collect Installers
      if: github.event_name != 'pull_request'
      run: |
        md installers
        Get-ChildItem -Include *install.zip -Recurse | Copy-Item -Destination "installers\"
      shell: powershell
      working-directory: .\
  
    - name: Store Install Package
      if: github.event_name != 'pull_request'
      uses: actions/upload-artifact@v3
      with:
        name: installers
        path: './installers/**_install.zip'
        retention-days: 5 # only need long enough to test/validate