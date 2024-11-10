# Define the path to the config file
$configFilePath = ".\config.ini"

# Function to parse the INI file
function Parse-IniFile {
    param (
        [string]$filePath
    )

    $iniContent = Get-Content -Path $filePath -ErrorAction Stop
    $config = @{}
    $section = $null

    foreach ($line in $iniContent) {
        # Remove any whitespace from the start and end of the line
        $line = $line.Trim()

        # Ignore empty lines or comments
        if ($line -match '^\s*;') { continue }
        if ($line -eq '') { continue }

        # Check for section header, e.g., [DEV]
        if ($line -match '^\[(.+?)\]') {
            $section = $matches[1]
            $config[$section] = @{}
        }
        # Check for key-value pairs within a section, e.g., pamfqdn=https://someaddress.com
        elseif ($line -match '^\s*(.+?)\s*=\s*(.+?)\s*$' -and $section) {
            $key, $value = $matches[1], $matches[2]
            $config[$section][$key] = $value
        }
    }

    return $config
}

# Parse the INI file
try {
    $config = Parse-IniFile -filePath $configFilePath
    Write-Output "Configuration loaded successfully."
} catch {
    Write-Output "Failed to load configuration: $_"
    exit 1
}

# Access configuration values
$environment = "DEV"  # Example: specify the environment
Write-Output "PAM FQDN for $environment: $($config[$environment]['pamfqdn'])"
Write-Output "Username for $environment: $($config[$environment]['username'])"
Write-Output "Password for $environment: $($config[$environment]['password'])"
