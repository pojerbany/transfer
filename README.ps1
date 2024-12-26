# Function to recursively flatten an object
function Flatten-Object {
    param (
        [hashtable]$obj,
        [string]$prefix = "" # Prefix for nested keys
    )
    $flatObject = @{}

    foreach ($key in $obj.Keys) {
        $fullKey = if ($prefix) { "$prefix.$key" } else { $key }

        if ($obj[$key] -is [hashtable]) {
            # Recurse into nested hashtable
            $nestedObject = Flatten-Object -obj $obj[$key] -prefix $fullKey
            foreach ($nestedKey in $nestedObject.Keys) {
                $flatObject[$nestedKey] = $nestedObject[$nestedKey]
            }
        } else {
            # Add the key-value pair to the flat object
            $flatObject[$fullKey] = $obj[$key]
        }
    }
    return $flatObject
}

# Example nested objects
$objects = @(
    @{
        id = 1
        name = "John"
        details = @{
            age = 30
            address = @{
                street = "123 Main St"
                city = "New York"
            }
        }
    },
    @{
        id = 2
        name = "Jane"
        details = @{
            age = 25
            address = @{
                street = "456 Elm St"
                state = "CA"
            }
        }
    }
)

# Collect all unique flattened keys
$allKeys = @{}
foreach ($obj in $objects) {
    $flattened = Flatten-Object -obj $obj
    foreach ($key in $flattened.Keys) {
        if (-not $allKeys.ContainsKey($key)) {
            $allKeys[$key] = $true
        }
    }
}

# Create a sorted list of headers
$headers = $allKeys.Keys | Sort-Object


# Flatten all objects and populate rows
$flattenedObjects = @()
foreach ($obj in $objects) {
    $flattened = Flatten-Object -obj $obj

    # Create a row with all headers, filling missing keys with null
    $row = @{}
    foreach ($header in $headers) {
        $row[$header] = if ($flattened.ContainsKey($header)) { $flattened[$header] } else { $null }
    }
    $flattenedObjects += [PSCustomObject]$row
}


# Export to CSV
$flattenedObjects | Export-Csv -Path "output.csv" -NoTypeInformation
