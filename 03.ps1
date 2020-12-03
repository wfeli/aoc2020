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
    $i = 0
    $right = 0
    foreach ($row in $array) {
        if (($i % $d) -ne 0) {
            Write-Host $i
            $i++
 
            continue
        }
        if ($row.ToCharArray()[$right] -eq "#") {
            $treecount++
        }
        if (($right + $r) -gt 30) {
            $right = ($right + $r) - 31
            continue
        }
        $right = $right + $r
        $i++
    }
    return $treecount
}
$path1 = Get-TobogganPath -array $con -D 1 -R 1
$path2 = Get-TobogganPath -array $con -D 1 -R 3
$path3 = Get-TobogganPath -array $con -D 1 -R 5
$path4 = Get-TobogganPath -array $con -D 1 -R 7
$path5 = Get-TobogganPath -array $con -D 2 -R 1
$path1 * $path2 * $path3 * $path4 * $path5 
