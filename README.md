# xCredSSP

This module contains DSC resources for the management and
configuration of Credential Security Support Provider (CredSSP).

<!-- Update with the correct definition number - replace 9999 with the definition number for the pipeline /-->
[![Build Status](https://dev.azure.com/dsccommunity/xCredSSP/_apis/build/status/dsccommunity.xCredSSP?branchName=main)](https://dev.azure.com/dsccommunity/xCredSSP/_build/latest?definitionId=9999&branchName=main)
![Azure DevOps coverage (branch)](https://img.shields.io/azure-devops/coverage/dsccommunity/xCredSSP/9999/main)
[![codecov](https://codecov.io/gh/dsccommunity/xCredSSP/branch/main/graph/badge.svg)](https://codecov.io/gh/dsccommunity/xCredSSP)
[![Azure DevOps tests](https://img.shields.io/azure-devops/tests/dsccommunity/xCredSSP/9999/main)](https://dsccommunity.visualstudio.com/xCredSSP/_test/analytics?definitionId=9999&contextType=build)
[![PowerShell Gallery (with prereleases)](https://img.shields.io/powershellgallery/vpre/xCredSSP?label=xCredSSP%20Preview)](https://www.powershellgallery.com/packages/xCredSSP/)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/xCredSSP?label=xCredSSP)](https://www.powershellgallery.com/packages/xCredSSP/)

## Code of Conduct

This project has adopted this [Code of Conduct](CODE_OF_CONDUCT.md).

## Releases

For each merge to the branch `master` a preview release will be
deployed to [PowerShell Gallery](https://www.powershellgallery.com/).
Periodically a release version tag will be pushed which will deploy a
full release to [PowerShell Gallery](https://www.powershellgallery.com/).

## Contributing

Please check out common DSC Community [contributing guidelines](https://dsccommunity.org/guidelines/contributing).

## Change log

A full list of changes in each version can be found in the [change log](CHANGELOG.md).

## Documentation

The documentation can be found in the [xCredSSP Wiki](https://github.com/dsccommunity/xCredSSP/wiki).
The DSC resources schema files is used to automatically update the
documentation on each PR merge.

## Requirements

This module requires the latest version of PowerShell (v4.0, which ships in
Windows 8.1 or Windows Server 2012R2). To easily use PowerShell 4.0 on older
operating systems, [install WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855).
Please read the installation instructions that are present on both the download
page and the release notes for WMF 4.0.

### Examples

You can review the [Examples](/source/Examples) directory in the xCredSSP module
for some general use scenarios for all of the resources that are in the module.

The resource examples are also available in the [xCredSSP Wiki](https://github.com/dsccommunity/xCredSSP/wiki).

## Resources

### xCredSSP

This resource enables or disables Credential Security Support Provider (CredSSP)
authentication on a client or on a server computer, and which server or servers
the client credentials can be delegated to.

#### Parameters

- **Ensure:** Specifies whether the domain trust is present or absent
- **Role**: REQUIRED parameter representing the CredSSP role, and is either
  "Server" or "Client"
- **DelegateComputers**: Array of servers to be delegated to, REQUIRED when
  Role is set to "Client".
- **SuppressReboot**: Specifies whether a necessary reboot has to be suppressed
  or not.

## Examples

### xCredSSP

Enable CredSSP for both server and client roles, and delegate to Server1 and Server2.

```powershell
Configuration EnableCredSSP
{
    Import-DscResource -Module xCredSSP
    Node localhost
    {
        xCredSSP Server
        {
            Ensure = "Present"
            Role = "Server"
        }
        xCredSSP Client
        {
            Ensure = "Present"
            Role = "Client"
            DelegateComputers = "Server1","Server2"
        }
    }
}
```
