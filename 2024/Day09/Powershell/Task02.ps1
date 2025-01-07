Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../testinput.txt"

function Format-FileBlocks {
    param (
        $lines
    )
    
    $array = ($lines -split "") | where {$_}

    $formattedLine = @()

    $id = 0
    $type = "file"

    foreach($number in $array){

        switch ($type) {

            file {

                for ($i = 0; $i -lt [int][string]$number; $i++) { $formattedLine += $id.ToString() }

                $type = "space"
                $id++

            }
            space {

                for ($i = 0; $i -lt [int][string]$number; $i++) { $formattedLine += "." }

                $type = "file"

            }

        }

        Write-Host ("{0} / {1}" -f $id, $array.Count)

    }

    return $formattedLine

}

function Move-FileBlocks {
    param (
        $array
    )

    for ($j = ($array.Count - 1); $j -ge $i; $j--) {

        $fileblock = $null

        if($array[$j] -eq "."){

            $zSpaceCounter = 0
            $zSpaceIndexes = $null

            for ($z = $j; $z -ge $j; $z--) {

                if($array[$z] -ne "."){

                    $zSpaceCounter++
                    $zSpaceIndexes += [string]$z

                }

            }

            $fileblock = $array | where {$_ -eq $array[$j]}
            $fileblockLength = $fileblock.Count
            $fit = $false

            for ($i = 0; $i -lt $array.Count; $i++) {
            
                if($fit -eq $true){



                    break

                }

                if($array[$i] -eq "."){

                    $xSpaceCounter = 0
                    $xSpaceIndexes = $null
                    for ($x = $i; $x -lt $array.Count; $x++) {
                     
                        if($array[$x] -eq "."){

                            $xSpaceCounter++
                            $xSpaceIndexes += [string]$x

                            if($xSpaceCounter -eq $fileblockLength){$fit = $true; break}

                        }

                    }

                }

            }

        }

    }

}
function Calculate-Checksum {
    param (
        $array
    )

    $Checksum = 0

    for ($i = 0; $i -lt $array.Count; $i++) {
        
        if($array[$i] -ne "."){

           $Checksum += [int]$array[$i] * $i

           Write-Host ("Current checksum: {0}, added {1} * {2}" -f $Checksum, [int]$array[$i], $i)

        }

    }

    return $Checksum
    
}

$formatted = Format-FileBlocks -lines $lines
$moved = Move-FileBlocks -array $formatted
$checksum = Calculate-Checksum -array $moved

$lines; $formatted; $moved; $checksum