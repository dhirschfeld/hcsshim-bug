# escape=`

FROM mcr.microsoft.com/windowsservercore-insider:10.0.17744.1001

SHELL ["powershell", "-Command", "$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue';"]

RUN $filename = 'Miniconda3-4.5.4-Windows-x86_64.exe'; `
    $url = \"https://repo.anaconda.com/miniconda/$filename\"; `
    Invoke-WebRequest $url -OutFile $filename -UseBasicParsing; `
    Start-Process $filename -ArgumentList '/S','/InstallationType=AllUsers','/AddToPath=1','/RegisterPython=1','/D=C:\Miniconda3'  -NoNewWindow -Wait; `
    Remove-Item -Force $filename;

CMD ["cmd.exe"]
