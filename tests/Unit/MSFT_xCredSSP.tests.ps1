<#
.Synopsis
   Unit tests for MSFT_xCredSSP
.DESCRIPTION
   Unit tests for MSFT_xCredSSP

.NOTES
   Code in HEADER and FOOTER regions are standard and may be moved into DSCResource.Tools in
   Future and therefore should not be altered if possible.
#>


$script:dscModuleName      = 'xCredSSP' # Example xNetworking
$script:dscResourceName    = 'MSFT_xCredSSP' # Example MSFT_xFirewall

function Invoke-TestSetup
{
    try
    {
        Import-Module -Name DscResource.Test -Force -ErrorAction 'Stop'
    }
    catch [System.IO.FileNotFoundException]
    {
        throw 'DscResource.Test module dependency not found. Please run ".\build.ps1 -Tasks build" first.'
    }

    $script:testEnvironment = Initialize-TestEnvironment `
        -DSCModuleName $script:dscModuleName `
        -DSCResourceName $script:dscResourceName `
        -ResourceType 'Mof' `
        -TestType 'Unit'
}

function Invoke-TestCleanup
{
    Restore-TestEnvironment -TestEnvironment $script:testEnvironment
}

Invoke-TestSetup

try
{
    InModuleScope $script:dscModuleName  {
        Describe "$($script:dscModuleName)\Get-TargetResource" {
            # TODO: Complete Tests...
        }

        Describe "$($script:dscModuleName)\Test-TargetResource" {
            Context "Enable Server Role with invalid delegate Computer parameter" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                mock Enable-WSManCredSSP -MockWith {} -Verifiable
                mock Disable-WSManCredSSP -MockWith {}

                it 'should throw' {
                    Test-TargetResource -Ensure 'Present' -Role Server -DelegateComputer 'foo' | Should Be $false
                }
            }

            Context "Server Role not configured" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                mock Get-ItemProperty -MockWith {
                    return @{ auth_credssp = 0 }
                }
                it 'should not return anything' {
                    Test-TargetResource -Ensure 'Present' -Role Server | should be $false
                }
            }

            Context "Client Role not configured" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                Mock Get-WSManCredSSP -MockWith {@([string]::Empty,[string]::Empty)}
                mock Get-ItemProperty -MockWith {
                    return @{
                        1 = "wsman/testserver.domain.com"
                        2 = "wsman/testserver2.domain.com"
                    }
                }
                mock Get-Item -MockWith {
                    $client1 = New-Object -typename PSObject|
                                Add-Member NoteProperty "Name" 1 -PassThru |
                                Add-Member NoteProperty "Property" 1 -PassThru

                    $client2 = New-Object -typename PSObject|
                                Add-Member NoteProperty "Name" 2 -PassThru |
                                Add-Member NoteProperty "Property" 2 -PassThru

                    return @($client1, $client2)
                }

                it 'should not return anything' {
                    Test-TargetResource -Ensure 'Present' -Role Client -DelegateComputer 'foo' | should be $false
                }
            }
            # TODO: Complete Tests...
        }

        Describe "$($script:dscModuleName)\Set-TargetResource" {
            Context "Enable Server Role with invalid delegate Computer parameter" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                mock Enable-WSManCredSSP -MockWith {} -Verifiable
                mock Disable-WSManCredSSP -MockWith {}

                it 'should throw' {
                    { Set-TargetResource -Ensure 'Present' -Role Server -DelegateComputer 'foo' } | should throw
                }
                it 'should have not called enable' {
                    Assert-MockCalled -CommandName Enable-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'should have not called disable' {
                    Assert-MockCalled -CommandName Disable-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'Should not have triggered a reboot' {
                    $global:DSCMachineStatus | should be $null
                }
            }

            Context "Enable Server Role when it has been configured using GPO" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                mock Enable-WSManCredSSP -MockWith {} -Verifiable
                mock Disable-WSManCredSSP -MockWith {}
                mock Get-ItemProperty -MockWith {
                    return @{ AllowCredSSP = 1 }
                } -ParameterFilter { $Path -eq "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" }

                it 'should throw' {
                    { Set-TargetResource -Ensure 'Present' -Role Server }| should throw
                }
                it 'should have not called enable' {
                    Assert-MockCalled -CommandName Enable-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'should have not called disable' {
                    Assert-MockCalled -CommandName Disable-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'Should not have triggered a reboot' {
                    $global:DSCMachineStatus | should be $null
                }
            }

            Context "Enable Client Role when it has been configured using GPO" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                mock Enable-WSManCredSSP -MockWith {} -Verifiable
                mock Disable-WSManCredSSP -MockWith {}
                mock Get-ItemProperty -MockWith {
                    return @{ AllowCredSSP = 1 }
                } -ParameterFilter { $Path -eq "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" }

                it 'should throw' {
                    {Set-TargetResource -Ensure 'Present' -Role Client -DelegateComputers 'foo'}| should throw
                }
                it 'should have not called enable' {
                    Assert-MockCalled -CommandName Enable-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'should have not called disable' {
                    Assert-MockCalled -CommandName Disable-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'Should not have triggered a reboot' {
                    $global:DSCMachineStatus | should be $null
                }
            }

            Context "Enable Server Role" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                mock Enable-WSManCredSSP -MockWith {} -Verifiable
                mock Disable-WSManCredSSP -MockWith {}
                mock Get-ItemProperty -MockWith {
                    return @{ auth_credssp = 1 }
                }
                it 'should not return anything' {
                    Set-TargetResource -Ensure 'Present' -Role Server | should be $null
                }
                it 'should have called enable'{
                    Assert-MockCalled -CommandName Enable-WSManCredSSP -Times 1 -ParameterFilter {$Role -eq 'Server' -and $Force -eq $true}
                }
                it 'should have not called disable' {
                    Assert-MockCalled -CommandName Disable-WSManCredSSP -Times 0
                }
                it 'Should have triggered a reboot'{
                    $global:DSCMachineStatus | should be 1
                }
            }

            Context "Enable Client Role" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                Mock Get-WSManCredSSP -MockWith {@([string]::Empty,[string]::Empty)}
                mock Enable-WSManCredSSP -MockWith {} -Verifiable
                mock Disable-WSManCredSSP -MockWith {}
                mock Get-ItemProperty -MockWith {
                    return @{
                        1 = "wsman/testserver.domain.com"
                        2 = "wsman/testserver2.domain.com"
                    }
                }
                mock Get-Item -MockWith {
                    $client1 = New-Object -typename PSObject|
                                Add-Member NoteProperty "Name" 1 -PassThru |
                                Add-Member NoteProperty "Property" 1 -PassThru

                    $client2 = New-Object -typename PSObject|
                                Add-Member NoteProperty "Name" 2 -PassThru |
                                Add-Member NoteProperty "Property" 2 -PassThru

                    return @($client1, $client2)
                }

                it 'should not return anything' {
                    Set-TargetResource -Ensure 'Present' -Role Client -DelegateComputer 'foo' | should be $null
                }
                it 'should have called enable'{
                    Assert-MockCalled -CommandName Enable-WSManCredSSP -Times 1 -ParameterFilter {$Role -eq 'Client' -and $Force -eq $true -and $DelegateComputer -eq 'foo'}
                }
                it 'should have not called disable' {
                    Assert-MockCalled -CommandName Disable-WSManCredSSP -Times 0
                }
                it 'Should have triggered a reboot'{
                    $global:DSCMachineStatus | should be 1
                }
            }
            Context "Enable Client Role  with invalid delegate Computer parameter" {
                BeforeAll {
                    $global:DSCMachineStatus = $null
                }
                AfterAll {
                    $global:DSCMachineStatus = $null
                }

                Mock Get-WSManCredSSP -MockWith {@([string]::Empty,[string]::Empty)}
                mock Enable-WSManCredSSP -MockWith {} -Verifiable
                mock Disable-WSManCredSSP -MockWith {}
                mock Get-ItemProperty -MockWith {
                    return @{ auth_credssp = 1 }
                }
                mock Get-Item -MockWith {
                    return @(
                        @{
                            Name = 1
                            Property = "wsman/foo"
                        },
                        @{
                            Name = 1
                            Property = "wsman/testserver.domain.com"
                        }
                    )
                }

                it 'should throw' {
                    { Set-TargetResource -Ensure 'Present' -Role Client } | should throw 'DelegateComputers is required!'
                }
                it 'should have not called get' {
                    Assert-MockCalled -CommandName Get-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'should have called enable' {
                    Assert-MockCalled -CommandName Enable-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'should have not called disable' {
                    Assert-MockCalled -CommandName Disable-WSManCredSSP -Times 0 -Scope 'Context'
                }
                it 'Should have triggered a reboot'{
                    $global:DSCMachineStatus | should be $null
                }
            }
        }

        # TODO: Pester Tests for any Helper Cmdlets
    }
}
finally
{
    Invoke-TestCleanup
}
