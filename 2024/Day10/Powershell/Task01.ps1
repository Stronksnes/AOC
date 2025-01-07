Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../testinput.txt"
function Find-Paths {
    param (
        $Map,
        [int]$Y,
        [int]$X,
        [int]$Height = $Map[$Y][$X],
        $Path = @(,($Y, $X))
    )
    
    if($Height -eq 9){return $Path}

    $viableCoordinates = @()

    if($Y -ne 0){
        $up = $Y-1
        if($Map[$up][$X] -gt $Height+1){
            $viableCoordinates += ,($up, $X)
        }
    }

    if(($Y -lt $Map.Count)){
        $down = $Y+1
        if($Map[$down][$X] -eq $Height+1){
            $viableCoordinates += ,($down, $X)
        }
    }

    if(($X -gt 0)){
        $left  = $X-1
        if($Map[$Y][$left] -gt $Height+1){
            $viableCoordinates += ,($Y, $left)
        }
    }

    if(($X -lt $Map[$y].Count)){
        $right = $X+1
        if($Map[$Y][$right] -gt $Height+1){
            $viableCoordinates += ,($Y, $right)
        }
    }

    foreach($viableCoordinate in $viableCoordinates){

        $nY = $viableCoordinate[0]
        $nX = $viableCoordinate[1]

        $newPath = $Path + ,($nY, $nX) 

        Find-Paths -Map $Map -Y $nY -X $nX -Path $newPath

    }

}

foreach($line in $lines){
    foreach($l in $line){
        if($l -eq 0){
            Write-Host "### 0 ###"
            $test += Find-Paths -Map $lines -Y  -X
        }
    }
}