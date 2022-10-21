# Welcome to the xCredSSP wiki

<sup>*xCredSSP v#.#.#*</sup>

Here you will find all the information you need to make use of the xCredSSP
DSC resources in the latest release. This includes details of the resources
that are available, current capabilities, known issues, and information to
help plan a DSC based implementation of xCredSSP.

Please leave comments, feature requests, and bug reports for this module in
the [issues section](https://github.com/dsccommunity/xCredSSP/issues)
for this repository.

## Deprecated resources

The documentation, examples, unit test, and integration tests have been removed
for these deprecated resources. These resources will be removed
in a future release.

### xCredSSP

- No deprecated resource at this time

## Getting started

To get started either:

- Install from the PowerShell Gallery using PowerShellGet by running the
  following command:

```powershell
Install-Module -Name xCredSSP -Repository PSGallery
```

- Download xCredSSP from the [PowerShell Gallery](https://www.powershellgallery.com/packages/xCredSSP)
  and then unzip it to one of your PowerShell modules folders (such as
  `$env:ProgramFiles\WindowsPowerShell\Modules`).

To confirm installation, run the below command and ensure you see the xCredSSP
DSC resources available:

```powershell
Get-DscResource -Module xCredSSP
```

## Prerequisites

The minimum Windows Management Framework (PowerShell) version required is 4.0
or higher.

## Change log

A full list of changes in each version can be found in the [change log](https://github.com/dsccommunity/xCredSSP/blob/dev/CHANGELOG.md).
