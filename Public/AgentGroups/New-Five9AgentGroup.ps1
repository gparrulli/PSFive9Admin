<#
.SYNOPSIS
    
    Function used to create an agent group

.PARAMETER Name
 
    Name for new agent group
   
.PARAMETER Description
 
    Description for new agent group
   
.EXAMPLE
    
    New-Five9AgentGroup -Name "Team Joe" -Description "Joe Montana's team members"
    
    # Creates new group named "Team Joe"
    
#>

function New-Five9AgentGroup
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name,
        [Parameter(Mandatory=$true)][string]$Description
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        $agentGroup = New-Object PSFive9Admin.agentGroup
        $agentGroup.name = $Name
        $agentGroup.description = $Description

        Write-Verbose "$($MyInvocation.MyCommand.Name): Creating new Five9 agent group '$Name'." 
        $response =  $global:DefaultFive9AdminClient.createAgentGroup($agentGroup)

        return $response

    }
    catch
    {
        Write-Error $_
    }

}



