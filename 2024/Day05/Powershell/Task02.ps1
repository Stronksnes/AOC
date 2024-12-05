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
        $OriginalSequence,
        $Sequence,
        $OrderDictionary,
        $correctOrder = $true
    )
    
    if(-not($OriginalSequence)){$OriginalSequence = $Sequence}
    
    $sequenceArray = $sequence.split(",")
    $currentCorrectOrder = $true

    for ($i = 0; $i -lt $sequenceArray.Count; $i++){
        
        $currentNumber = $sequenceArray[$i]

        $biggerNumbers = $orderDictionary[$currentNumber]
        $subsequentArray = $sequenceArray[($i+1)..($sequenceArray.Count -1 )]

        foreach($number in $subsequentArray){

            if($number -in $biggerNumbers){

                $correctOrder = $false
                $currentCorrectOrder = $false
                
                $newSequenceArray = $sequenceArray.Clone()
                $newSequenceArray[$i] = $number
                $newSequenceArray[$sequenceArray.IndexOf($number)] = $currentNumber
                $newSequence = $newSequenceArray -join ","

                break

            }

        }

        if ($currentCorrectOrder -eq $false) { return Evaluate-Order -OriginalSequence $OriginalSequence -Sequence $newSequence -OrderDictionary $OrderDictionary -CorrectOrder $correctOrder }

    }

    return [PSCustomObject]@{
        Sequence = $OriginalSequence
        CorrectedSequence = $Sequence
        MiddleNumber = $sequenceArray[($sequenceArray.Count -1) / 2]
        CorrectOrder = $correctOrder
    }

}

$orderDict = New-SmallOrderDictionary -OrderRules $orderRules

$processedSequences = foreach($line in $lines){

    Evaluate-Order -Sequence $line -OrderDictionary $orderDict

} 

$processedSequences
""
"Sum: " + (($processedSequences | where {$_.CorrectOrder -eq $false}).MiddleNumber | Measure-Object -Sum).Sum
