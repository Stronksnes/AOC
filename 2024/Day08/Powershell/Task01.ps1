Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../testinput.txt"

function Find-Coordinates {
    param (
        $data
    )
    
    $dict = @{}

    for ($i = 0; $i -lt $data.Count; $i++) {
        
        for ($j = 0; $j -lt $data[$i].length; $j++) {

            $entry = $data[$i][$j]
            $dict[$entry] += ,@($i, $j)

        }
        
    }

    return $dict

}

$test = Find-Coordinates -data $lines

$key = "A"
$test[$key]
