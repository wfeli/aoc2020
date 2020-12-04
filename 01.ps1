[int[]]$con = Get-Content .\input\01.txt
$origList = $con | Sort-Object
function New-Sum {
    param (
        [int[]]$list,
        [int]$compare,
        [int]$iL,
        [int]$iR
    )
    while ($iL -le $iR) {
        $m = [math]::Round( ($iL + $iR) / 2)
        $sum = $list[$m] + $compare
        if ($sum -eq 2020) {
            return ($list[$m] * $compare)
        }
        if ($sum -lt 2020) {
            $iL = $m + 1
        }
        else {
            $iR = $m - 1
        }
    }
    return $null
    
}

$lenOrig = $origList.count - 1
foreach ($line in $origList) {
    $s = New-Sum -compare $line -list $origList -iR $lenOrig -iL 0
    if ($s) {
        Write-Host $s
        break
    }
}

####### p2, meh
foreach ($nr in $origList) {
    foreach ($nr2 in $origList) {
        if ($nr2 -eq $nr) {
            continue
        }
        if (($nr + $nr2) -gt 2020) {
            break
        }
        foreach ($nr3 in $origList) {
            if ($nr3 -eq $nr2) {
                continue
            }
            $sum = $nr3 + $nr2 + $nr
            if ($sum -gt 2020) {
                break
            }
            if ($sum -lt 2020) {
                continue
            }
            if ($sum -eq 2020) {
                Write-Host ($nr * $nr2 * $nr3)
                exit
            }
        }
    }
}