## List all users

{
  "Users": [
   {
    "id": 2,
    "username": "Administrator",
    "source": "CyberArk",
    "userType": "Built-InAdmins",
    "componentUser": false,
    "groupsMembership": [
     {
      "groupID": 16,
      "groupName": "PVWAMonitor",
      "groupType": "Vault"
     },
     {
      "groupID": 17,
      "groupName": "PVWAUsers",
      "groupType": "Vault"
     },
     {
      "groupID": 11,
      "groupName": "Vault Admins",
      "groupType": "Vault"
     }
    ],
    "vaultAuthorization": [
     "AddUpdateUsers",
     "AddSafes",
     "AddNetworkAreas",
     "ManageDirectoryMapping",
     "ManageServerFileCategories",
     "AuditUsers",
     "BackupAllSafes",
     "RestoreAllSafes",
     "ResetUsersPasswords",
     "ActivateUsers"
    ],
    "location": "\\",
    "personalDetails": {
     "firstName": "Jen",
     "middleName": "R",
     "lastName": "Grey"
    }
   }
  ],
  "Total": 1
}

## Get users details
	
{
  "enableUser": true,
  "changePassOnNextLogon": false,
  "expiryDate": 1577836800,
  "suspended": false,
  "lastSuccessfulLoginDate": 1561282853,
  "unAuthorizedInterfaces": [
    "GUI"
  ],
  "authenticationMethod": [
    "AuthTypePass"
  ],
  "passwordNeverExpires": true,
  "distinguishedName": "JohnDoeRoe",
  "description": "John Doe Roe",
  "businessAddress": {
    "workStreet": "Kuritania street",
    "workCity": "Curitania",
    "workState": "Suritania",
    "workZip": "90211",
    "workCountry": "Ruritania"
  },
  "internet": {
    "homePage": "example.com",
    "homeEmail": "John@example.net",
    "businessEmail": "John@example.com",
    "otherEmail": "John@example.org"
  },
  "phones": {
    "homeNumber": "555-0100",
    "businessNumber": "555-0101",
    "cellularNumber": "0491 570 156",
    "faxNumber": "555-0102",
    "pagerNumber": "555-0103"
  },
  "personalDetails": {
    "street": "Main street",
    "city": "Curitania",
    "state": "Suritania",
    "zip": "90210",
    "country": "Ruritania",
    "title": "Mr. John",
    "organization": "Acme",
    "department": "newco",
    "profession": "Doing Job",
    "firstName": "John",
    "middleName": "Doe",
    "lastName": "Roe"
  },
  "groupsMembership": [
    {
      "groupID": 16,
      "groupName": "PVWAMonitor",
      "groupType": "Vault"
    },
    {
      "groupID": 17,
      "groupName": "PVWAUsers",
      "groupType": "Vault"
    },
    {
      "groupID": 11,
      "groupName": "Vault Admins",
      "groupType": "Vault"
    }
  ],
  "id": 24,
  "username": "JohnDR",
  "source": "CyberArk",
  "userType": "EPVUser",
  "componentUser": false,
  "vaultAuthorization": [
    "AuditUsers"
  ],
  "location": "\\"
}

# get all safes IDs

{
  "value": [
    {
      "safeUrlId": "VaultInternal",
      "safeName": "VaultInternal",
      "safeNumber": 2,
      "description": "",
      "location": "\\",
      "creator": {
        "id": "2",
        "name": "Administrator"
      },
      "olacEnabled": false,
      "managingCPM": "",
      "numberOfVersionsRetention": null,
      "numberOfDaysRetention": 30,
      "autoPurgeEnabled": false,
      "creationTime": 1608827926,
      "lastModificationTime": 1610319618268452,
      "isExpiredMember": false
    }
  ],
  "count": 24,
  "nextLink": "api/safes?offset=25&limit=25&useCache=False"
}

# get safe member permission
{
  "value": [
    {
      "safeUrlId": "BZ_I_87",
      "safeName": "BZ_I_87",
      "safeNumber": 37,
      "memberId": 0,
      "memberName": "Master",
      "memberType": "User",
      "membershipExpirationDate": null,
      "isExpiredMembershipEnable": false,
      "isPredefinedUser": true,
      "permissions": {
        "useAccounts": true,
        "retrieveAccounts": true,
        "listAccounts": true,
        "addAccounts": true,
        "updateAccountContent": true,
        "updateAccountProperties": true,
        "initiateCPMAccountManagementOperations": true,
        "specifyNextAccountContent": true,
        "renameAccounts": true,
        "deleteAccounts": true,
        "unlockAccounts": true,
        "manageSafe": true,
        "manageSafeMembers": true,
        "backupSafe": true,
        "viewAuditLog": true,
        "viewSafeMembers": true,
        "accessWithoutConfirmation": true,
        "createFolders": true,
        "deleteFolders": true,
        "moveAccountsAndFolders": true,
        "requestsAuthorizationLevel1": false,
        "requestsAuthorizationLevel2": false
      }
    }
  ],
  "count": 1
}


#Get platforms

{
  "Platforms": [
    {
      "general": {
        "id": "WinDomain",
        "name": "Windows Domain Account",
        "systemType": "Windows",
        "active": true,
        "description": "",
        "platformBaseID": "WinDomain",
        "platformType": "regular"
      },
      "properties": {
        "required": [
          {
            "name": "Address",
            "displayName": "Address"
          },
          {
            "name": "Username",
            "displayName": "Username"
          }
        ],
        "optional": [
          {
            "name": "LogonDomain",
            "displayName": "Logon To"
          },
          {
            "name": "UserDN",
            "displayName": "User DN"
          },
          {
            "name": "Port",
            "displayName": "Port"
          }
        ]
      },
      "linkedAccounts": [
        {
          "name": "LogonAccount",
          "displayName": "Logon Account"
        },
        {
          "name": "ReconcileAccount",
          "displayName": "Reconcile Account"
        }
      ],
      "credentialsManagement": {
        "allowedSafes": ".*",
        "allowManualChange": true,
        "performPeriodicChange": false,
        "requirePasswordChangeEveryXDays": 90,
        "allowManualVerification": true,
        "performPeriodicVerification": false,
        "requirePasswordVerificationEveryXDays": 7,
        "allowManualReconciliation": true,
        "automaticReconcileWhenUnsynched": false
      },
      "sessionManagement": {
        "requirePrivilegedSessionMonitoringAndIsolation": false,
        "recordAndSaveSessionActivity": true,
        "PSMServerID": "PSMServer_239d800"
      },
      "privilegedAccessWorkflows": {
        "requireDualControlPasswordAccessApproval": false,
        "enforceCheckinCheckoutExclusiveAccess": false,
        "enforceOnetimePasswordAccess": false
      }
    }
  ],
  "Total": 1
}

# Get platform details

{
	"PlatformID":<Platform ID>,
	"Properties":<list of key\value>,
	"Active":<is active>
}


# Get accounts

{
  "id": "string",
  "name": "string",
  "address": "string",
  "userName": "string",
  "platformId": "string",
  "safeName": "string",
  "secretType": "key",
  "platformAccountProperties": {},
  "secretManagement": {
    "automaticManagementEnabled": true,
    "manualManagementReason": "string",
    "status": "inProcess",
    "lastModifiedTime": 0,
    "lastReconciledTime": 0,
    "lastVerifiedTime": 0
  },
  "remoteMachinesAccess": {
    "remoteMachines": "string",
    "accessRestrictedToRemoteMachines": true
  },
  "createdTime": 0,
  "categoryModificationTime": 111111111111111110000
}

# get accounts details

{
  "CategoryModificationTime": 1588049324,
  "id": "string",
  "name": "string",
  "address": "string",
  "userName": "string",
  "platformId": "string",
  "safeName": "string",
  "secretType": "key",
  "platformAccountProperties": {},
  "secretManagement": {
    "automaticManagementEnabled": true,
    "manualManagementReason": "string",
    "status": "inProcess",
    "lastModifiedTime": 0,
    "lastReconciledTime": 0,
    "lastVerifiedTime": 0
  },
  "remoteMachinesAccess": {
    "remoteMachines": "string",
    "accessRestrictedToRemoteMachines": true
  },
  "createdTime": 0
}




