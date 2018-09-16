
$isolation = 'process'

$images = 'miniconda','repro-base','repro'
ForEach ($image in $images) {
    Write-Host "################################################################################"
    Write-Host "# Building image '$image'"
    Write-Host "################################################################################"
    docker build --force-rm --no-cache --isolation=$isolation -t $image .\$image 2>&1 | Tee-Object "$image.log"
    if ($LastExitCode -ne 0) {
        Write-Host '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
        Write-Host "# Building image '$image' failed with exit code $LastExitCode"
        Write-Host '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
        Exit $LastExitCode
    }
    Write-Host "`n`n"
}

# docker rmi -f $(docker images -f "dangling=true" -q)

