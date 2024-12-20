# Break Glass Policy for PAM CyberArk System

## 1. Overview

This policy defines the break glass procedures to be followed in scenarios where:

- The PAM CyberArk system is completely unavailable.
- One of the critical dependencies is unavailable.

The policy ensures that privileged access management and related functions remain operable during incidents.

## 2. System Overview and Dependencies

The PAM CyberArk system includes:

- **Frontend and Database**: Hosted in the cloud.
- **On-Premises Components**: Supporting infrastructure integrated with dependencies.

### Dependencies:

- **Azure Entra ID (SAML)**: Authentication and Single Sign-On.
- **Network**: Internal and external communication pathways.
- **VMware**: Hosting critical infrastructure for PAM components.
- **Office Domain**: Authentication and identity-related workflows.
- **Protected Domains**: Target systems and services managed by PAM.

---

## 3. Break Glass Table: Scenarios and Pre-Break Glass Actions

### Table 1: Scenarios and Actions

| **Scenario**                                  | **Pre-Break Glass Actions**                                                                               |
| --------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| **Complete PAM Unavailability**               | 1. Document emergency accounts outside PAM.<br>2. Ensure updated offline credential storage.                  |
| **Azure Entra ID Unavailability**             | 1. Maintain local admin accounts for critical systems.<br>2. Preconfigure alternate authentication.           |
| **Network Unavailability**                    | 1. Verify local admin account access.<br>2. Maintain network redundancy and failover policies.                |
| **VMware Platform Unavailability**            | 1. Maintain backups of PAM components.<br>2. Configure alternate hosting options.                             |
| **Office or Protected Domain Unavailability** | 1. Maintain admin account details in secure offline storage.<br>2. Define manual workflows for domain access. |

---

## 4. Break Glass Detailed Procedures

### Table 2: Break Glass Procedures

#### 4.1 Complete PAM Unavailability

| **Step** | **Procedure**                                                                                         |
| -------- | ----------------------------------------------------------------------------------------------------- |
| 1        | Authenticate using emergency admin accounts stored offline.                                           |
| 2        | Access critical systems directly using manually documented credentials.                               |
| 3        | Engage vendor support for CyberArk to troubleshoot and restore functionality.                         |
| 4        | Revalidate privileged credentials updated during the incident within PAM once the system is restored. |

#### 4.2 Azure Entra ID Unavailability

| **Step** | **Procedure**                                                                         |
| -------- | ------------------------------------------------------------------------------------- |
| 1        | Use preconfigured local admin accounts to access critical systems.                    |
| 2        | Switch to alternate authentication mechanisms for cloud resources (if configured).    |
| 3        | Notify impacted users and implement manual workflows for authentication.              |
| 4        | Restore Azure Entra ID connectivity and reenable SAML authentication post-resolution. |

#### 4.3 Network Unavailability

| **Step** | **Procedure**                                                                     |
| -------- | --------------------------------------------------------------------------------- |
| 1        | Use out-of-band network management tools to diagnose and resolve network issues.  |
| 2        | Authenticate directly into on-premises PAM components using local admin accounts. |
| 3        | Reestablish connectivity and verify PAM operational status.                       |

#### 4.4 VMware Platform Unavailability

| **Step** | **Procedure**                                                               |
| -------- | --------------------------------------------------------------------------- |
| 1        | Switch to backup or alternate hosting environment for PAM components.       |
| 2        | Reconfigure network and service settings to point to the alternate hosting. |
| 3        | Verify the functionality of restored services and components.               |

#### 4.5 Office Domain or Protected Domain Unavailability

| **Step** | **Procedure**                                                                            |
| -------- | ---------------------------------------------------------------------------------------- |
| 1        | Use emergency admin accounts for direct system access to impacted domains.               |
| 2        | Implement manual workflows for identity verification and critical operations.            |
| 3        | Engage domain recovery procedures, working with relevant teams to restore functionality. |

---

## 5. Key Considerations

1. **Emergency Account Management**: Emergency accounts must be periodically tested for validity.
2. **Offline Credential Storage**: Credentials should be securely stored offline and updated following changes in privileged accounts.
3. **Audit and Review**: Post-incident, all actions taken during break glass must be audited and reviewed for compliance.
4. **Documentation and Communication**: Incident response and resolution steps must be documented and communicated to stakeholders.

---

## 6. Periodic Testing

Break glass procedures should be tested at least annually or after significant system updates to ensure readiness and effectiveness.

---

## 7. Policy Approval

This policy must be reviewed and approved by the IT Security team and stakeholders responsible for PAM operations.
"""
