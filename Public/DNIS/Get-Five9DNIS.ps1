function Get-Five9DNIS
{
    <#
    .SYNOPSIS
    
        Function to returns the list of DNIS for the domain
 
    .EXAMPLE
    
        Get-Five9DNIS

        # returns list of all DNIS for the domain

    .EXAMPLE
    
        Get-Five9DNIS -SelectUnassigned: $true

        # returns only DNIS not assigned to a campaign
    
    #>
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        <#
        Options are
            • True: only DNIS not assigned to a campaign are returned
            • False (Default): all DNIS provisioned for the domain are returned
        #>
        [Parameter(Mandatory=$false)][bool]$SelectUnassigned = $false
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        if ($SelectUnassigned -eq $true)
        {
            Write-Verbose "$($MyInvocation.MyCommand.Name): Returning only DNIS which are not assigned to a campaign." 
        }
        else
        {
            Write-Verbose "$($MyInvocation.MyCommand.Name): Returning all DNIS provisioned to domain." 
        }

        return $global:DefaultFive9AdminClient.getDNISList($SelectUnassigned, $true)

    }
    catch
    {
        throw $_
    }
}
