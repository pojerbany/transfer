# Example input objects
$objects = @(
    @{
        id = 1
        name = "John"
        platformAccountProperties = @{
            property1 = "Value1"
            property2 = "Value2"
        }
    },
    @{
        id = 2
        name = "Jane"
        platformAccountProperties = @{
            property2 = "ValueX"
            property3 = "ValueY"
        }
    }
)

# Collect all unique keys
$allKeys = @{}
foreach ($obj in $objects) {
    # Add top-level keys
    foreach ($key in $obj.Keys) {
        if (-not $allKeys.ContainsKey($key)) {
            $allKeys[$key] = $true
        }

        # Add nested keys dynamically
        if ($key -eq "platformAccountProperties" -and $obj[$key] -is [hashtable]) {
            foreach ($nestedKey in $obj[$key].Keys) {
                $flattenedKey = "platformAccountProperties.$nestedKey"
                if (-not $allKeys.ContainsKey($flattenedKey)) {
                    $allKeys[$flattenedKey] = $true
                }
            }
        }
    }
}

# Generate ordered header list
$headers = $allKeys.Keys

# Function to flatten an object
function Flatten-Object {
    param (
        [hashtable]$obj,
        [array]$headers
    )

    $flatObject = @{}
    foreach ($header in $headers) {
        if ($header -like "platformAccountProperties.*") {
            # Extract the nested key
            $nestedKey = $header -replace "platformAccountProperties\.", ""
            $flatObject[$header] = $obj["platformAccountProperties"][$nestedKey]
        } else {
            $flatObject[$header] = $obj[$header]
        }
    }
    return $flatObject
}

# Flatten all objects
$flattenedObjects = @()
foreach ($obj in $objects) {
    $flattenedObjects += Flatten-Object -obj $obj -headers $headers
}


# Convert to CSV and export
$flattenedObjects | Export-Csv -Path "output.csv" -NoTypeInformation

