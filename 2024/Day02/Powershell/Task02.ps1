Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../input.txt"

function Calculate-Safety {
    param (
        $line,
        $errorCount = 0,
        $strike = 0
    )

    $lineSplit = $line.Split(" ")
    
    $init = $lineSplit[0] - $lineSplit[1]

    if($init -gt 0){$initDirection = "decreasing"}
    elseif($init -lt 0){$initDirection = "increasing"}
    else{$errorCount++}

    for ($i = 1; $i -lt $lineSplit.Count; $i++) {
        
        $current = $lineSplit[$i]
        $previous = $lineSplit[$i-1]

        $compare = $current - $previous

        switch ($compare) {

            {$_ -gt 0}  {$entryDirection = "increasing"}
            {$_ -lt 0}  {$entryDirection = "decreasing"}
            default     {$errorCount++}
        }

        if($entryDirection -ne $initDirection){$errorCount++}
        
        switch (($previous..$current).Count -1) {

            {$_ -gt 3}  {$errorCount++}
            {$_ -lt 1}  {$errorCount++}

        }
        
        if(($errorCount -eq 1) -and ($strike -eq 0)){
            
            ###Edge cases
            if($i -eq 1){$newLine = ($lineSplit[1..($lineSplit.Count -1)]) -join " "}
            elseif($i -eq ($lineSplit.Count -1)){$newLine = ($lineSplit[0..($lineSplit.Count -2)]) -join " "}
            else{

                $startSlice = 0..($i-1)
                $endSlice = ($i+1)..($lineSplit.Count -1)
                $newLine = $lineSplit[$startSlice + $endSlice] -join " "

            }

            return Calculate-Safety -line $newLine -errorCount 1 -strike 1
            
        }

        if($errorCount -gt 1){return $false}
        
    }

    return $true

}

$safetyReports = foreach($line in $lines){

    [PSCustomObject]@{
        
        Report  = $line
        Safe    = Calculate-Safety -line $line

    }

}

$safetyReports
($safetyReports | where {$_.Safe -eq $true}).Count