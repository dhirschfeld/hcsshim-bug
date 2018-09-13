# escape=`

FROM repro-base as oracle
SHELL ["powershell", "-Command", "$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue';"]
COPY instantclient-basiclite-windows.x64-11.2.0.4.0.zip C:/
COPY instantclient-odbc-windows.x64-11.2.0.4.0.zip C:/
RUN Expand-Archive -Path "C:/instantclient-basiclite-windows.x64-11.2.0.4.0.zip" -DestinationPath "C:/oracle" -Force;
RUN Expand-Archive -Path "C:/instantclient-odbc-windows.x64-11.2.0.4.0.zip" -DestinationPath "C:/oracle" -Force;


FROM repro-base
COPY --from=oracle "C:/oracle" "C:/oracle"
COPY r-essentials.txt C:/
COPY msodbcsql_17.1.0.1_x64.msi C:/
COPY vcredist_x64.exe C:/
SHELL ["powershell", "-Command", "$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue';"]
WORKDIR C:/
RUN Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; `
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.208 -Force; `
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; `
    Install-Module -Scope AllUsers posh-git; `
    Add-Content $Profile.AllUsersAllHosts 'Import-Module Posh-Git'; `
    # Install Oracle drivers
    Write-Host "Installing Oracle drivers..."; `
    setx /M PATH $($Env:PATH + ';' + 'C:\oracle\instantclient_11_2'); `
    Start-Process 'C:\vcredist_x64.exe' -ArgumentList '/Q' -NoNewWindow -Wait; `
    Remove-Item -Force 'C:\vcredist_x64.exe'; `
    Set-Location  C:\oracle\instantclient_11_2; `
    Start-Process '.\odbc_install.exe' -NoNewWindow -Wait; `
    # Install MSODBC
    Write-Host "Installing MSODBC driver..."; `
    Set-Location  C:\; `
    Start-Process msiexec -ArgumentList '/quiet','/passive','/norestart','/qn','/i msodbcsql_17.1.0.1_x64.msi','ALLUSERS=1','IACCEPTMSODBCSQLLICENSETERMS=YES' -NoNewWindow -Wait; `
    Remove-Item -Force 'C:\msodbcsql_17.1.0.1_x64.msi'; `
    Write-Host "Updating conda environment..."; `
    Add-Content C:/Miniconda3/conda-meta/pinned 'networkx <2.0'; `
    Add-Content C:/Miniconda3/conda-meta/pinned 'sqlalchemy >=1.2.7'; `
    Start-Process conda -ArgumentList 'update','-v','-c','conda-canary','conda' -NoNewWindow -Wait; `
    Start-Process conda -ArgumentList 'update','-v','--all','--yes'  -NoNewWindow -Wait; `
    Start-Process conda -ArgumentList 'install','-v','defaults::git','--yes' -NoNewWindow -Wait; `
    Start-Process conda -ArgumentList 'install','-v','-c','damianavila82 ','rise', '--yes' -NoNewWindow -Wait; `
    Start-Process conda -ArgumentList 'install','-v','-c','pscondaenvs ','pscondaenvs', '--yes' -NoNewWindow -Wait; `
    Write-Host "Installing R packages..."; `
    Start-Process conda -ArgumentList 'install','-v','--override-channels','-c','defaults','--file','C:/r-essentials.txt','--yes'-NoNewWindow -Wait; `
    Start-Process conda -ArgumentList 'clean','-tisy', -NoNewWindow -Wait; `
    Remove-Item -Force C:/r-essentials.txt; `
    # Configure tools
    Start-Process git -ArgumentList 'config','--global','url.\"https://github.com/\".insteadOf','git://github.com/' -NoNewWindow -Wait; `
    Start-Process git -ArgumentList 'config','--global','url.\"https://github.com/\".insteadOf','git@github.com:' -NoNewWindow -Wait; `
    Start-Process git -ArgumentList 'config','--global','http.sslbackend','schannel' -NoNewWindow -Wait; `
    Start-Process git -ArgumentList 'config','--global','credential.modalPrompt','false' -NoNewWindow -Wait; `
    Start-Process git -ArgumentList 'config','--global','credential.helper','manager' -NoNewWindow -Wait; `
    [Environment]::SetEnvironmentVariable('GCM_PRESERVE_CREDS', 'TRUE', [EnvironmentVariableTarget]::Machine); `
    [Environment]::SetEnvironmentVariable('GCM_INTERACTIVE', 'auto', [EnvironmentVariableTarget]::Machine); `
    # Import matplotlib the first time to build the font cache.
    $env:MPLBACKEND='Agg'; `
    Start-Process python -ArgumentList '-c','\"import matplotlib.pyplot\"' -NoNewWindow -Wait;


SHELL ["cmd", "/S", "/C"]

