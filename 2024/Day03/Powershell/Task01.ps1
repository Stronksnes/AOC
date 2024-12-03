Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../input.txt"
<<<<<<< HEAD
$lines = $lines -join ""

$mulPattern = 'mul\((?<first>\d+),(?<second>\d+)\)'

$mulMatches = ($lines | Select-String -Pattern $mulPattern -AllMatches).Matches

$muled = foreach($mul in $mulMatches){

    $first = [int]$mul.Groups['first'].Value
    $second = [int]$mul.Groups['second'].Value

    $first * $second

}

($muled | Measure-Object -Sum).Sum
=======
>>>>>>> d72063cf84dc339d99cf19c317c913b793a061bf
