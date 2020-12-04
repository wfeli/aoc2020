$con = Get-Content .\input\03.txt
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
        if (($right + $r) -gt ($array[$i].length -1)) {
            $right = ($right + $r) - $array[$i].length
        }
        else {
            $right = $right + $r
        }
    }
    return $treecount
}
Get-TobogganPath -array $con -D 1 -R 3
## Part 2
(Get-TobogganPath -array $con -D 1 -R 1) * (Get-TobogganPath -array $con -D 1 -R 3) * (Get-TobogganPath -array $con -D 1 -R 5) * (Get-TobogganPath -array $con -D 1 -R 7) * (Get-TobogganPath -array $con -D 2 -R 1)