Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../input.txt"
$lines = $lines -join ""

###Enabled at start
$lines = "do()" + $lines

$segPattern = '^do\(\)(?:<segment>.*)don''t\(\)$'
$segMatches = ($lines | Select-String -Pattern $segPattern -AllMatches) 



$mulPattern = 'mul\((?<first>\d+),(?<second>\d+)\)'
$mulMatches = ($lines | Select-String -Pattern $mulPattern -AllMatches).Matches

$muled = foreach($mul in $mulMatches){

    $first = [int]$mul.Groups['first'].Value
    $second = [int]$mul.Groups['second'].Value

    $first * $second

}

($muled | Measure-Object -Sum).Sum