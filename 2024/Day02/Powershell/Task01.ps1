Set-Location -Path $PSScriptRoot 
$lines = Get-Content "../input.txt"

function Calculate-Safety {
    param (
        $line
    )

    $lineSplit = $line.Split(" ")
    
    $init = $lineSplit[0] - $lineSplit[1]

    if($init -gt 0){$initDirection = "decreasing"}
    elseif($init -lt 0){$initDirection = "increasing"}
    else{return $False}

    for ($i = 1; $i -lt $lineSplit.Count; $i++) {
        
        $current = $lineSplit[$i]
        $previous = $lineSplit[$i-1]

        $compare = $current - $previous

        switch ($compare) {

            {$_ -gt 0}  {$entryDirection = "increasing"}
            {$_ -lt 0}  {$entryDirection = "decreasing"}
            default     {return $False}
        }

        if($entryDirection -ne $initDirection){return $False}
        
        switch (($previous..$current).Count -1) {

            {$_ -gt 3}  {return $False}
            {$_ -lt 1}  {return $False}

        }
        
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