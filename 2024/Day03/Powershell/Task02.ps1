Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../input.txt"
$lines = $lines -join ""

###Enabled at start
$lines = "do()" + $lines

$segPattern = 'do\(\)(?<segment>.*?)(?:don''t\(\)|$)'
$segMatches = ($lines | Select-String -Pattern $segPattern -AllMatches).Matches | % {$_.Groups['segment'].Value}

$mulPattern = 'mul\((?<first>\d+),(?<second>\d+)\)'

$sum = foreach($segment in $segMatches){

    $mulMatches = ($segment | Select-String -Pattern $mulPattern -AllMatches).Matches

    $muled = foreach($mul in $mulMatches){

        $first = [int]$mul.Groups['first'].Value
        $second = [int]$mul.Groups['second'].Value

        $first * $second

    }

    ($muled | Measure-Object -Sum).Sum

}

($sum | Measure-Object -Sum).Sum