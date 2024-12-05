Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../input.txt" -Raw

# Why so hard to split on empty line?????
$parts = $lines -split "\r?\n\r?\n"

$orderRules = $parts[0] -split "`r?`n"
$lines = $parts[1] -split "`r?`n"

function New-SmallOrderDictionary {
    param (
        $OrderRules
    )
    
    $dict = @{}

    foreach($rule in $OrderRules){

        $bigger = $rule.split("|")[0]
        $smaller = $rule.split("|")[1]

        $dict[$smaller] += @($bigger)

    }

    return $dict

}

function Evaluate-Order {
    param (
        $Sequence,
        $OrderDictionary
    )
    
    $sequenceArray = $sequence.split(",")

    for ($i = 0; $i -lt $sequenceArray.Count; $i++){
        
        $currentNumber = $sequenceArray[$i]

        $biggerNumbers = $orderDictionary[$currentNumber]
        $subsequentArray = $sequenceArray[($i+1)..($sequenceArray.Count)]

        foreach($number in $subsequentArray){

            if($number -in $biggerNumbers){return $false}

        }

    }

    return $true

}

$orderDict = New-SmallOrderDictionary -OrderRules $orderRules

$processedSequences = foreach($line in $lines){

    $lineArray = $line.Split(",")

    [PSCustomObject]@{
        Sequence = $line
        MiddleNumber = $lineArray[(($lineArray.Count -1)/2)]
        CorrectOrder = Evaluate-Order -sequence $line -orderDictionary $orderDict
    }

} 

$processedSequences
"Sum: " + (($processedSequences | where {$_.CorrectOrder -eq $True}).MiddleNumber | Measure-Object -Sum).Sum