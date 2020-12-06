$con = Get-Content .\input\06.txt
$arrObjs = @()
$replyHT = @{}
$memCount = 0
foreach ($line in $con) {
    if ($line -eq "") {
        $replyHT['memCount'] = $memCount
        $arrObjs += $replyHT
        $replyHT = @{}
        $memCount = 0
        continue
    }
    else {
        $memCount++
        $line.GetEnumerator() | foreach-object {$replyHT["$_"] = $replyHT["$_"] + 1 } 
    }
}

$replyHT['memCount'] = $memCount
$arrObjs += $replyHT
($arrObjs.Keys | Where-Object {$_ -ne "memCount"}).Count
### Part 2
$countSum = 0
foreach ($HT in $arrObjs) {
    $c = $HT['memCount']
    $countSum += ($HT.Keys | Where-Object {$_ -ne "memCount" -and $HT[$_] -eq $c}).count
}
$countSum