
FROM miniconda-core-1809

SHELL ["powershell", "-Command", "$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue';"]

COPY quantdev.yml C:/

RUN Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem -Name LongPathsEnabled -Value 1; \
    Start-Process conda -ArgumentList 'config','--set','channel_priority','false' -NoNewWindow -Wait; \
    Start-Process conda -ArgumentList 'config','--append','channels','conda-forge' -NoNewWindow -Wait; \
    Start-Process conda -ArgumentList 'update','conda','-v','--yes' -NoNewWindow -Wait; \
    Start-Process conda -ArgumentList 'env','update','-v','--file','C:/quantdev.yml' -NoNewWindow -Wait; \
    Start-Process conda -ArgumentList 'clean','-tisy' -NoNewWindow -Wait; \
    Start-Process nbdime -ArgumentList 'config-git','--enable','--global' -NoNewWindow -Wait; \
    Remove-Item -Force C:/quantdev.yml;

SHELL ["cmd", "/S", "/C"]
