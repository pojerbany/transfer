# ImportExcel module is required
import-module -Name "C:\Users\donkablo\Downloads\importexcel.7.0.1\importexcel"
# File paths
$jsonFilePath = "C:\Users\donkablo\Documents\workspace\coding\powershell\importexcel\creative_users.json"

$date = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")

$csvFilePath = "C:\Users\donkablo\Documents\workspace\coding\powershell\importexcel\users_$date.csv"
$excelFilePath = "C:\Users\donkablo\Documents\workspace\coding\powershell\importexcel\users_$date.xlsx"

# Read the JSON file
$json = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json

# options
# - safes
# - users

$struct = "users"

if ($struct -eq "safes") {
    $flattened = $json.value | ForEach-Object {
        [PSCustomObject]@{
            SafeUrlId                = $_.safeUrlId
            SafeName                 = $_.safeName
            SafeNumber               = $_.safeNumber
            CreatorId                = $_.creator.id
            CreatorName              = $_.creator.name
            Location                 = $_.location
            NumberOfDaysRetention    = $_.numberOfDaysRetention
            CreationTime             = (Get-Date -Date (Get-Date "1970-01-01 00:00:00Z").AddSeconds($_.creationTime)).ToLocalTime()
            LastModificationTime     = (Get-Date -Date (Get-Date "1970-01-01 00:00:00Z").AddSeconds($_.lastModificationTime)).ToLocalTime()
            IsExpiredMember          = $_.isExpiredMember
        }
    }
}

if ($struct -eq "users") {
   # Assuming $json contains the JSON data already loaded
    $flattened = $json.value | ForEach-Object {
        $daysSinceLogin = (Get-Date) - (Get-Date -Date (Get-Date "1970-01-01 00:00:00Z").AddSeconds($_.lastSuccessfulLoginDate)).ToLocalTime()
        [PSCustomObject]@{
            EnableUser               = $_.enableUser
            ChangePassOnNextLogon    = $_.changePassOnNextLogon
            ExpiryDate               = (Get-Date -Date (Get-Date "1970-01-01 00:00:00Z").AddSeconds($_.expiryDate)).ToLocalTime()
            Suspended                = $_.suspended
            LastSuccessfulLoginDate  = (Get-Date -Date (Get-Date "1970-01-01 00:00:00Z").AddSeconds($_.lastSuccessfulLoginDate)).ToLocalTime()
            PasswordNeverExpires     = $_.passwordNeverExpires
            DistinguishedName        = $_.distinguishedName
            Description              = $_.description
            WorkStreet               = $_.businessAddress.workStreet
            WorkCity                 = $_.businessAddress.workCity
            WorkState                = $_.businessAddress.workState
            WorkZip                  = $_.businessAddress.workZip
            WorkCountry              = $_.businessAddress.workCountry
            HomePage                 = $_.internet.homePage
            HomeEmail                = $_.internet.homeEmail
            BusinessEmail            = $_.internet.businessEmail
            OtherEmail               = $_.internet.otherEmail
            HomeNumber               = $_.phones.homeNumber
            BusinessNumber           = $_.phones.businessNumber
            CellularNumber           = $_.phones.cellularNumber
            FaxNumber                = $_.phones.faxNumber
            PagerNumber              = $_.phones.pagerNumber
            Title                    = $_.personalDetails.title
            Organization             = $_.personalDetails.organization
            Department               = $_.personalDetails.department
            Profession               = $_.personalDetails.profession
            FirstName                = $_.personalDetails.firstName
            MiddleName               = $_.personalDetails.middleName
            LastName                 = $_.personalDetails.lastName
            Groups                   = ($_.groupsMembership | ForEach-Object { $_.groupName }) -join ", "
            AuthenticationMethod     = ($_.authenticationMethod -join ", ")
            UnAuthorizedInterfaces   = ($_.unAuthorizedInterfaces -join ", ")
            Id                       = $_.id
            Username                 = $_.username
            Source                   = $_.source
            UserType                 = $_.userType
            ComponentUser            = $_.componentUser
            VaultAuthorization       = ($_.vaultAuthorization -join ", ")
            Location                 = $_.location
            _DaysBucket               = if ($daysSinceLogin.Days -le 30) { "0-30 Days" } `
                                    elseif ($daysSinceLogin.Days -le 60) { "31-60 Days" } `
                                    elseif ($daysSinceLogin.Days -le 90) { "61-90 Days" } `
                                    else { "91+ Days" }
        }
    }
    # Output the flattened objects
    #$flattened | Format-Table -AutoSize
}

# Output the flattened object
$flattened | Export-Csv -Path "$csvFilePath " -NoTypeInformation

$pt = [ordered]@{
    pt1 = @{
        SourceWorkSheet   = 'Users';
        PivotTableName    = '30/60/90';
        PivotRows         = "_DaysBucket";
        PivotData         = @{"Username" = "count"};
        IncludePivotChart = $true;
        ChartType         = 'BarClustered3D';
    };
    pt2 = @{
        SourceWorkSheet   = 'Users';
        PivotTableName    = '30/60/90';
        PivotRows         = "_DaysBucket";
        PivotData         = @{"Username" = "count"};
        IncludePivotChart = $true;
        ChartType         = 'PieExploded3D';
    }
}

$flattened | Export-Excel -Path $excelFilePath -WorksheetName 'Users' -TableName "Users" -TableStyle Medium1 -FreezeTopRow -Show -AutoSize 

#Get-ExcelWorkbookInfo -Path $excelFilePath
$workbook = Open-ExcelPackage -Path $excelFilePath -KillExcel

$worksheetName = "Report Navigation"
Add-Worksheet -ExcelPackage $workbook -WorksheetName $worksheetName -MoveToStart 
Set-ExcelRange -Worksheet $workbook.'Report Navigation' -Range "A1" -Value "Users sheet"

$worksheet = $workbook.Workbook.Worksheets['Report Navigation']


# Add a big title
$worksheet.Cells["A1"].Value = "Document Title: PAM Reporting"
$worksheet.Cells["A1"].Style.Font.Size = 24                 # Set font size
$worksheet.Cells["A1"].Style.Font.Bold = $true              # Bold the text
$worksheet.Cells["A1"].Style.HorizontalAlignment = "Center" # Center align
$worksheet.Cells["A1:D1"].Merge = $true                     # Merge cells for title

# Add document metrics below the title
$worksheet.Cells["A2"].Value = "Document Metrics:"
$worksheet.Cells["A2"].Style.Font.Size = 14
$worksheet.Cells["A2"].Style.Font.Bold = $true

# Add metrics
$worksheet.Cells["A3"].Value = "Creation Date"
$worksheet.Cells["B3"].Value = (Get-Date).ToString("yyyy-MM-dd")
$worksheet.Cells["A4"].Value = "Author"
$worksheet.Cells["B4"].Value = "XX"
$worksheet.Cells["A5"].Value = "Version"
$worksheet.Cells["B5"].Value = "1.0"

Set-ExcelRange -Worksheet $workbook.'Report Navigation' -Range "G2" -Value "Link to Users"

$worksheet.Cells["H2"].Hyperlink = "#Users!A1"
$worksheet.Cells["H2"].value = "Click to go users tab"

$worksheet.Cells["H2"].Style.Font.Color.SetColor([System.Drawing.Color]::Blue)  # Set font color to blue
$worksheet.Cells["H2"].Style.Font.UnderLine = $true                             # Underline the text
$worksheet.Cells["H2"].Style.Font.Size = 12                                     # Set font size to 12
$worksheet.Cells["H2"].Style.Font.Bold = $true                                  # Make the text bold

Add-PivotTable -ExcelPackage $workbook `
               -SourceWorkSheet $workbook.Users `
               -PivotTableName "Inactive users 30/60/90" `
               -Address $workbook.'Report Navigation'.Cells["I2"] `
               -PivotRows "_DaysBucket" `
               -PivotData @{"Username" = "count"} `
               -Activate 
             
$worksheet.Cells.AutoFitColumns()
Close-ExcelPackage $workbook 

