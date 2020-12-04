$con = Get-Content .\input\03.txt
#$con = Get-Content .\input\03test.txt
$right = 0
$treecount = 0
foreach ($row in $con) {
    if ($row.ToCharArray()[$right] -eq "#") {
        $treecount++
    }
    if (($right + 3) -gt 30) {
        $right = ($right + 3) - 31
        continue
    }
    $right = $right + 3
}
Write-Host $treecount

## Part 2

function Get-TobogganPath {
    param (
        $D,
        $R,
        $array
    )
    $treecount = 0
    $right = 0
    for ($i = 0; $i -lt $array.Count; $i++) {
        if (($i % $d) -ne 0) {
            continue
        }
        if ($array[$i].ToCharArray()[$right] -eq "#") {
            $treecount++
        }
        if (($right + $r) -gt 30) {
            $right = ($right + $r) - 31
        }
        else {
            $right = $right + $r
        }
    }
    return $treecount
}
(Get-TobogganPath -array $con -D 1 -R 1) * (Get-TobogganPath -array $con -D 1 -R 3) * (Get-TobogganPath -array $con -D 1 -R 5) * (Get-TobogganPath -array $con -D 1 -R 7) * (Get-TobogganPath -array $con -D 2 -R 1)