$con = Get-Content .\input\05.txt
$arrRows = @(0..127)
$arrCol = @(0..7)
function SeatNumber {
    param (
        [int]$rowNr,
        [int]$colNr
    )
    return ($rowNr * 8 + $colNr)
}
$seatNrs = @()
foreach ($line in $con) {
    $rowNr = $arrRows
    $colNr = $arrCol
    $lineRow = $line.substring(0,7)
    $lineCol = $line.Substring(6)
    foreach ($i in $lineRow.GetEnumerator()) {
        if ($i -eq "F") {
            # Lower Half
            $rowNr = @($rowNr[0]..$rowNr[(($rowNr.Length / 2) - 1)])
            continue
        }
        if ($i -eq "B") {
            # Upper Half
            $rowNr = @($rowNr[($rowNr.Length / 2)]..$rowNr[($rowNr.Length - 1)])
            continue
        }
    }
    foreach ($i in $lineCol.GetEnumerator()) {
        if ($i -eq "L") {
            # Lower Half
            $colNr = @($colNr[0]..$colNr[(($colNr.Length / 2) - 1)])
            continue
        }
        if ($i -eq "R") {
            # Upper Half
            $colNr = @($colNr[($colNr.Length / 2)]..$colNr[($colNr.Length - 1)])
            continue
        }
    }
    $seatNrs += (SeatNumber -rowNr $rowNr[0] -colNr $colNr[0])
}
### Part 2
$seatNrs = $seatNrs | Sort-Object
$AllSeats = @($seatNrs[0]..$seatNrs[($seatNrs.Length - 1)])
Compare-Object -DifferenceObject $seatNrs -ReferenceObject $AllSeats