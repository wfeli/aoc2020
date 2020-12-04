$con = Get-Content .\input\04.txt
$split = $con.Split("")
$arrObjs = @()
$obj = New-Object -TypeName psobject
foreach ($line in $split) {
    $lspl = $null
    $lspl = $line.split(":")
    if ($lspl[0] -eq "") {
        $arrObjs += $obj
        $obj = $null
        $obj = New-Object -TypeName psobject
        continue
    }
    $obj | Add-Member -MemberType NoteProperty -Name $lspl[0] -Value $lspl[1].trim()
}
$arrObjs += $obj

$res = $arrObjs | Where-Object { ($_.byr -ne $null) -and ($_.iyr -ne $null) -and ($_.eyr -ne $null) -and ($_.hgt -ne $null) -and ($_.hcl -ne $null) -and ($_.ecl -ne $null) -and ($_.pid -ne $null) }
$res.Count
## part 2
$resp2 = @()
$res | Where-Object { ([int]($_.byr) -ge 1920) -and ([int]($_.byr) -le 2002) } | `
    Where-Object { ([int]($_.iyr) -ge 2010) -and ([int]($_.iyr) -le 2020) } | `
    Where-Object { ([int]($_.eyr) -ge 2020) -and ([int]($_.eyr) -le 2030) } | `
    Where-Object { @("amb", "blu", "brn", "gry", "grn", "hzl", "oth") -contains $_.ecl } | `
    Where-Object { $_.pid -match '^[0-9]{9}$' } | `
    Where-Object { $_.hcl -match '^#[0-9a-f]{6}$' } | `
    Where-Object { if ($_.hgt -like "*cm" ) {
        [int]$n = $_.hgt.substring(0, $_.hgt.length - 2)
        if (($n -le 193) -and ($n -ge 150)) {
            $resp2 += $_
        }
    }
    else {
        [int]$n = $_.hgt.substring(0, $_.hgt.length - 2)
        if (($n -le 76) -and ($n -ge 59)) {
            $resp2 += $_
        }
    } }

$resp2.Count