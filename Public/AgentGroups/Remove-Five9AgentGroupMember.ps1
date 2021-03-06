function Remove-Five9AgentGroupMember
{
    <#
    .SYNOPSIS
    
        Function used to remove member(s) from an agent group

    .EXAMPLE
    
        Remove-Five9AgentGroupMember -Name "Team Joe" -Member "jdoe@domain.com"
    
        # Removes one member from agent group "Team Joe"
    
    .EXAMPLE
    
        Remove-Five9AgentGroupMember -Name "Team Joe" -Member "jdoe@domain.com", "sdavis@domain.com"
    
        # Removes multiple members from agent group "Team Joe"

    #>

    [CmdletBinding(PositionalBinding=$true)]
    param
    ( 
        # Name of agent group to remove member(s) from
        [Parameter(Mandatory=$true)][string]$Name,

        # Username of single member, or array of multiple usernames to be removed from agent group
        [Parameter(Mandatory=$true)][string[]]$Members
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        $agentGroupToModify = $null
        try
        {
            $agentGroupToModify = $global:DefaultFive9AdminClient.getAgentGroup($Name)
        }
        catch
        {
        
        }

        if ($agentGroupToModify.Count -gt 1)
        {
            throw "Multiple Agent Groups were found using query: ""$Name"". Please try using the exact username of the user you're trying to modify."
            return
        }

        if ($agentGroupToModify -eq $null)
        {
            throw "Cannot find a Agent Group with name: ""$Name"". Remember that Name is case sensitive."
            return
        }

        Write-Verbose "$($MyInvocation.MyCommand.Name): Removing member(s) to agent group '$Name'." 
        $response =  $global:DefaultFive9AdminClient.modifyAgentGroup($agentGroupToModify, $null, $Members)

        return $response

    }
    catch
    {
        throw $_
    }
}


