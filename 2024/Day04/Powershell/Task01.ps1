Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../input.txt"

$xmasCount = 0

for($i = 0; $i -lt $lines.Count; $i++){

    for ($j = 0; $j -lt $lines[$i].Length; $j++) {

        ###Horizontal check
        if($j -lt ($lines[$i].Length - 3)) {
            $hfCheck = ("{0}{1}{2}{3}" -f $lines[$i][$j], $lines[$i][$j+1], $lines[$i][$j+2], $lines[$i][$j+3])
            if($hfCheck -eq "XMAS"){$xmasCount++}
        }
        
        if($j -gt 2) {
            $hbCheck = ("{0}{1}{2}{3}" -f $lines[$i][$j], $lines[$i][$j-1], $lines[$i][$j-2], $lines[$i][$j-3])
            if($hbCheck -eq "XMAS"){$xmasCount++}
        }

        ###Vertical check
        if($i -lt ($lines.Count - 3)) {
            $vdCheck = ("{0}{1}{2}{3}" -f $lines[$i][$j], $lines[$i+1][$j], $lines[$i+2][$j], $lines[$i+3][$j])
            if($vdCheck -eq "XMAS"){$xmasCount++}
        }

        if($i -gt 2) {
            $vuCheck = ("{0}{1}{2}{3}" -f $lines[$i][$j], $lines[$i-1][$j], $lines[$i-2][$j], $lines[$i-3][$j])
            if($vuCheck -eq "XMAS"){$xmasCount++}
        }

        ###Diagonal check
        if(($i -lt $lines.Count - 3) -and ($j -lt $lines[$i].Length - 3)) {
            $dfdCheck = ("{0}{1}{2}{3}" -f $lines[$i][$j], $lines[$i+1][$j+1], $lines[$i+2][$j+2], $lines[$i+3][$j+3])
            if($dfdCheck -eq "XMAS"){$xmasCount++}
        }

        if(($i -gt 2) -and ($j -lt $lines[$i].Length - 3)) {
            $dfuCheck = ("{0}{1}{2}{3}" -f $lines[$i][$j], $lines[$i-1][$j+1], $lines[$i-2][$j+2], $lines[$i-3][$j+3])
            if($dfuCheck -eq "XMAS"){$xmasCount++}
        }
        
        if(($i -lt $lines.Count - 3) -and ($j -gt 2)) {
            $dbdCheck = ("{3}{2}{1}{0}" -f $lines[$i+3][$j-3], $lines[$i+2][$j-2], $lines[$i+1][$j-1], $lines[$i][$j])
            if($dbdCheck -eq "XMAS"){$xmasCount++}
        }

        if(($i -gt 2) -and ($j -gt 2)) {
            $dbuCheck = ("{3}{2}{1}{0}" -f $lines[$i-3][$j-3], $lines[$i-2][$j-2], $lines[$i-1][$j-1], $lines[$i][$j])
            if($dbuCheck -eq "XMAS"){$xmasCount++}
        }

        $lines[$i]
        $xmasCount

    }

}

