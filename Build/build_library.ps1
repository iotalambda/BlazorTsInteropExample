param(
    [string]$projectDirWithTrailing
)

$librarySourceDir = $projectDirWithTrailing + 'Adapters/blazortsinteropexample'
$npmBuildOutDir = $projectDirWithTrailing + 'wwwroot/js'

$npmBuildOutDirExists = Test-Path -Path $npmBuildOutDir
$npmBuildOutDirIsEmpty = if ($npmBuildOutDirExists) { 
    (Get-ChildItem -Path $npmBuildOutDir -Recurse).Count -eq 0 
} else { 
    $true 
}

if ($npmBuildOutDirIsEmpty) {
    Write-Host 'NpmBuildOutDir is empty. Running npm install...'
    cd $librarySourceDir
    npm install
    Write-Host 'Building the library...'
    npm run build
} else {
    $dateA = (Get-ChildItem -LiteralPath $librarySourceDir -File -Recurse | 
        Where-Object { $_.FullName -notlike '*\node_modules\*' -and $_.Name -ne 'typings.ts' } | 
        Sort-Object LastWriteTime -Descending | 
        Select-Object -First 1
    ).LastWriteTime

    $dateB = (Get-ChildItem -LiteralPath $npmBuildOutDir -File -Recurse | 
        Sort-Object LastWriteTime -Descending | 
        Select-Object -First 1
    ).LastWriteTime

    if ($dateA -gt $dateB) {
        Write-Host 'Library source files are newer than dist. Building the library...'
        Write-Host $dateA
        Write-Host $dateB
        cd $librarySourceDir
        npm run build
    }
}
