$lines = Get-Content ..\input.txt

function Get-Distance{

    param (
        $Start,
        $End
    )

    [PSCustomObject]@{

        'Start'     = $Start
        'End'       = $End
        'Distance'  = [math]::Abs($Start - $End)

    }

}

function Process-Lines {
    
    param (
        $lines
    )

    begin{

        $array1 = @()
        $array2 = @()

    }

    process{

        foreach($line in $lines){

            $lineSplit = $line.split(" ") | where {$_ -ne ""}
            $array1 += [int]$lineSplit[0]
            $array2 += [int]$lineSplit[1]

        }

        $sortedArray1 = $array1 | Sort-Object
        $sortedArray2 = $array2 | Sort-Object

        $processedLines = for ($i = 0; $i -lt $array1.Count; $i++) {

            Get-Distance -Start $sortedArray1[$i] -End $sortedArray2[$i]

        }

    }

    end{$processedLines}

}

$processedInput = Process-Lines -lines $lines

$sum = ($processedInput.Distance | Measure-Object -Sum).Sum
$sum