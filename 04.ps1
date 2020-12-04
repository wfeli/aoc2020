<#
    byr (Birth Year)
    iyr (Issue Year)
    eyr (Expiration Year)
    hgt (Height)
    hcl (Hair Color)
    ecl (Eye Color)
    pid (Passport ID)
    cid (Country ID) --> valid for part 1
#>
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
## part 2: validation
<#
    byr (Birth Year) - four digits; at least 1920 and at most 2002.
    iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    hgt (Height) - a number followed by either cm or in:
        If cm, the number must be at least 150 and at most 193.
        If in, the number must be at least 59 and at most 76.
    hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    pid (Passport ID) - a nine-digit number, including leading zeroes.
    cid (Country ID) - ignored, missing or not.
#>
$resp2 = @()
$res | Where-Object { ([int]($_.byr) -ge 1920) -and ([int]($_.byr) -le 2002) } | `
    Where-Object { ([int]($_.iyr) -ge 2010) -and ([int]($_.iyr) -le 2020) } | `
    Where-Object { ([int]($_.eyr) -ge 2020) -and ([int]($_.eyr) -le 2030) } | `
    Where-Object { @("amb", "blu", "brn", "gry", "grn", "hzl", "oth") -contains $_.ecl } | `
    Where-Object { ($_.pid -match "[0-9]{9}") -and ($_.pid.length -eq 9) } | `
    Where-Object { ($_.hcl -match "#[a-f0-9]{6}") -and ($_.hcl.length -eq 7) } | `
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