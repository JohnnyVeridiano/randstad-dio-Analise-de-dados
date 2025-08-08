#pegar o diretório atual

$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

#Arquivo saída com todos sql
$outputFile = Join-Path -Path $scriptDirectory - ChildPath
"migration.sql"

#verifica se arquiivo já existe se existir deleta
if (Test-Path $outputFile){
    Remove-Item $outputFile
}

#Pega conteúdo dos arquivos
$sqlFiles = Get-ChildItem -Path $scriptDirectory -Filter *.sql -File | Sort-Object Name

#concatena Arquivos
foreach($file in $sqlFiles){
    Get-Content $file.FullName | Out-File -Append -FilePath $outputFile
    "GO" | Out-File --Append -FilePath $outputFile
}

    Write-Host "Todos arquivos foram combinados em $outputFile" 