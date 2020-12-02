$passwords = Get-Content .\input\02.txt
#$passwords = Get-Content .\input\02_test.txt
$valid = 0
foreach ($line in $passwords) {
    $split = $line.split(':')
    $maxmin = $split[0].Split('-')
    $letter = $maxmin[1][$maxmin[1].length-1]
    [int]$maxmin[1] = $maxmin[1] -replace "\D"
    $charcount = ($split[1].ToCharArray() | Where-Object {$_ -eq $letter} | Measure-Object).Count
    if ($charcount -gt $maxmin[1] -or $charcount -lt [int]($maxmin[0])) {
        continue
    }
    else {
        $valid++
    }
}

## part 2
$valid2 = 0
foreach ($line in $passwords) {
    $split = $line.split(':')
    $maxmin = $split[0].Split('-')
    $letter = $maxmin[1][$maxmin[1].length-1]
    [int]$maxmin[1] = $maxmin[1] -replace "\D"
    $pw = $split[1].trim()
    if (($letter -eq $pw[($maxmin[0]-1)]) -xor ($letter -eq $pw[($maxmin[1]-1)])) {
        Write-Host $line
        $valid2++
    }
}
Write-Host $valid2