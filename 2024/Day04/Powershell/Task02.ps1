Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../input.txt"

$word = "MAS"
$xmasCount = 0
$storedCoor = @()

for($i = 0; $i -lt $lines.Count; $i++){

    for ($j = 0; $j -lt $lines[$i].Length; $j++) {

        ###Boundry check
        if( -not(
            $i -ge 1 -and `
            $i -le ($lines.Count -2) -and `
            $j -ge 1 -and `
            $j -le ($lines[$i].Length -2)
            )
        ){continue}

        if($lines[$i][$j] -eq "A"){

            $fdCheck = ("{0}{1}{2}" -f $lines[$i-1][$j-1], $lines[$i][$j], $lines[$i+1][$j+1])
            $fuCheck = ("{0}{1}{2}" -f $lines[$i+1][$j-1], $lines[$i][$j], $lines[$i-1][$j+1])
            $bdCheck = ("{0}{1}{2}" -f $lines[$i-1][$j+1], $lines[$i][$j], $lines[$i+1][$j-1])
            $buCheck = ("{0}{1}{2}" -f $lines[$i+1][$j+1], $lines[$i][$j], $lines[$i-1][$j-1])

            $currentMas = 0
            if($fdCheck -eq $word){$currentMas++}
            if($fuCheck -eq $word){$currentMas++}
            if($bdCheck -eq $word){$currentMas++}
            if($buCheck -eq $word){$currentMas++}

            if($currentMas -ge 2){
                
                $xmasCount++
                $storedCoor += ,@($i, $j)

            }

        }

    }

}

# Visual representation of the 3x3 boxes with spaces
for($i = 0; $i -lt $lines.Count; $i++) {
    
    for ($j = 0; $j -lt $lines[$i].Length; $j++) {
        
        $highlight = $false
        $isA = $false

        foreach ($coor in $storedCoor) {

            if ($i -ge ($coor[0] - 1) -and $i -le ($coor[0] + 1) -and $j -ge ($coor[1] - 1) -and $j -le ($coor[1] + 1)) {

                $highlight = $true
                
                if ($i -eq $coor[0] -and $j -eq $coor[1]) {$isA = $true}
                break

            }

        }

        if ($highlight) {

            if ($isA) {Write-Host -NoNewline ($lines[$i][$j] + " ") -ForegroundColor Blue -BackgroundColor Yellow} 
            else {Write-Host -NoNewline ($lines[$i][$j] + " ") -ForegroundColor Red -BackgroundColor Yellow}

        } 
        else {Write-Host -NoNewline ($lines[$i][$j] + " ")}
    }

    Write-Host ""

}