Set-Location -Path $PSScriptRoot 
#$lines = Get-Content "../input.txt"
$lines = Get-Content "../edgecase.txt"

function New-SafetyReport {
    param (
        $line
    )

    $lineSplit = $line.Split(" ")

    $numbers = New-Object System.Collections.Generic.List[PSObject]

    for ($i = 0; $i -lt $lineSplit.Count; $i++) {

        if($i -eq 0){

            $direction = "start"
            $gt3 = $false
            $lt1 = $false

        }
        else{

            $previous = $lineSplit[$i -1]
            $current = $lineSplit[$i]

            $difference = $previous - $current
            $absDifference = [math]::Abs($difference)

            if($absDifference -gt 3) {$gt3 = $true}
            else{$gt3 = $false}
            
            if($absDifference -lt 1) {$lt1 = $true}
            else{$lt1 = $false}

            if($difference -gt 0) {$direction = "decreasing"}
            elseif($difference -lt 0) {$direction = "increasing"}
            else{$direction = "static"}

        }

        $obj = [PSCustomObject]@{

            ID          = $i
            Number      = $lineSplit[$i]
            Direction   = $direction
            GT3         = $gt3
            LT1         = $lt1

        }

        $numbers.add($obj) | Out-Null

    }

    return $numbers

}

function New-SafetyCalculation {
    param (
        $line,
        $strike = 0,
        $errorCount = 0
    )
    
    $SafetyReport = New-SafetyReport -line $line

    $incCount = ($SafetyReport.Direction | where {$_ -eq "increasing"}).Count
    $decCount = ($SafetyReport.Direction | where {$_ -eq "decreasing"}).Count

    if($incCount -gt $decCount){$dominantGroup = "increasing"}
    elseif($decCount -gt $incCount){$dominantGroup = "decreasing"}
    else{$dominantGroup = "EvenSteven"}

    for ($i = 0; $i -lt $SafetyReport.Count; $i++) {

        if(($SafetyReport[$i]).GT3){$errorCount++}
        elseif(($SafetyReport[$i]).LT1){$errorCount++}
        elseif(($SafetyReport[$i]).Direction -ne "start"){

            if(($SafetyReport[$i]).Direction -ne $dominantGroup){$errorCount++}

        }

        if($errorCount -gt 0){

            if($strike -eq 0){

                ###Last entry logic
                
                if($i -eq $SafetyReport.Count -1){

                    $newLine = ($SafetyReport | where {$_.ID -ne ($SafetyReport[$i]).ID}).Number -join " "
                    return New-SafetyCalculation -line $newLine -strike 1

                }

                <#
                elseif(($SafetyReport[$i]).Direction -ne $dominantGroup){

                    $newLine = ($SafetyReport | where {$_.ID -ne ($SafetyReport[$i]).ID}).Number -join " "
                    return New-SafetyCalculation -line $newLine -strike 1

                }
                #>
                
                else{

                    $newLine = ($SafetyReport | where {$_.ID -ne ($SafetyReport[($i -1)]).ID}).Number -join " "
                    return New-SafetyCalculation -line $newLine -strike 1

                }

            }

        }

    }

    if($errorCount -gt 0){
        
        return $False
    
    }
    else{return $True}

}

$result = foreach($line in $lines){

    [PSCustomObject]@{
        Line = $line
        Safe = New-SafetyCalculation -line $line
    }

}

$result

$SafeReports = ($result | where {$_.Safe -eq $true}).Count
$SafeReports