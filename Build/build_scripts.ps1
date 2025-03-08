param(
    [string]$ScriptsDir,
    [string]$NpmBuildOutDir
)

$npmBuildOutDirExists = Test-Path -Path $NpmBuildOutDir
$npmBuildOutDirIsEmpty = if ($npmBuildOutDirExists) { 
    (Get-ChildItem -Path $NpmBuildOutDir -Recurse).Count -eq 0 
} else { 
    $true 
}

if ($npmBuildOutDirIsEmpty) {
    Write-Host 'NpmBuildOutDir is empty. Running npm install...'
    cd $ScriptsDir
    npm install
    npm run build
} else {
    $dateA = (Get-ChildItem -LiteralPath $ScriptsDir -File -Recurse | 
        Where-Object { $_.FullName -notlike '*\node_modules\*' -and $_.Name -ne 'typings.ts' } | 
        Sort-Object LastWriteTime -Descending | 
        Select-Object -First 1
    ).LastWriteTime

    $dateB = (Get-ChildItem -LiteralPath $NpmBuildOutDir -File -Recurse | 
        Sort-Object LastWriteTime -Descending | 
        Select-Object -First 1
    ).LastWriteTime

    if ($dateA -gt $dateB) {
        Write-Host 'Scripts are newer than dist. Building scripts...'
        Write-Host $dateA
        Write-Host $dateB
        cd $ScriptsDir
        npm run build
    }
}
