Set-Location -Path $PSScriptRoot
$lines = Get-Content "../input.txt"

function Find-SimilarityScore {
    
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

        $groupedArray2 = $array2 | Group-Object

        $processedLines = foreach($entry in $array1){

            $dupeCount = ($groupedArray2 | where {$_.Name -eq $entry}).Count

            [PSCustomObject]@{

                'Number'            = $entry
                'TimesFound'        = $dupeCount
                'SimilarityScore'   = $entry * $dupeCount
        
            }

        }

        return $processedLines
    
    }

}

$foundScores = Find-SimilarityScore -lines $lines

$sum = ($foundScores.SimilarityScore | Measure-Object -Sum).Sum
$sum