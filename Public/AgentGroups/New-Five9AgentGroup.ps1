function New-Five9AgentGroup
{
    <#
    .SYNOPSIS
    
        Function used to create an agent group

    .EXAMPLE
    
        New-Five9AgentGroup -Name "Team Joe" -Description "Joe Montana's team members"
    
        # Creates new group named "Team Joe"
    #>

    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        # Name for new agent group
        [Parameter(Mandatory=$true, Position=0)][string]$Name,

        # Description for new agent group
        [Parameter(Mandatory=$false)][string]$Description
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        $agentGroup = New-Object PSFive9Admin.agentGroup
        $agentGroup.name = $Name

        if ($PSBoundParameters.Keys -contains "Description")
        {
            $agentGroup.description = $Description
        }

        Write-Verbose "$($MyInvocation.MyCommand.Name): Creating new Five9 agent group '$Name'." 
        $response =  $global:DefaultFive9AdminClient.createAgentGroup($agentGroup)

        return $response

    }
    catch
    {
        throw $_
    }
}


