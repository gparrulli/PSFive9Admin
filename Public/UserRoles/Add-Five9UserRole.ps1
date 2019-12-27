function Add-Five9UserRole
{
    <#
    .SYNOPSIS
    
        Function used to add a new role to a user

    .EXAMPLE
    
        Add-Five9UserRole -Username 'jdoe@domain.com' -RoleName Reporting
    
        # Adds default reporting role to user
    #>
    [CmdletBinding(PositionalBinding=$true)]
    param
    ( 
        # Username of user role is being added to
        [Parameter(Mandatory=$true)][string]$Username,

        # Name of role being added. Role permissions will be default. 
        # Use Set-Five9User<RoleName>Role to change permissions on role. i.e. Set-Five9UserAgentRole
        [Parameter(Mandatory=$true)][ValidateSet("Agent", "Admin", "Supervisor", "Reporting")][string]$RoleName
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        $userToModify = $null
        try
        {
            $userToModify = $global:DefaultFive9AdminClient.getUserInfo($Username)
        }
        catch
        {

        }

        if ($userToModify.Count -gt 1)
        {
            throw "Multiple user matches were found using query: ""$Username"". Please try using the exact username of the user you're trying to modify."
            return
        }

        if ($userToModify -eq $null)
        {
            throw "Cannot find a Five9 user with username: ""$Username"". Remember that username is case sensitive."
            return
        }

        if ($userToModify.roles.$RoleName -ne $null)
        {
            throw "$RoleName has already been added to this user. Please use Set-Five9User$($RoleName)Role to modify role permisisons."
            return
        }


        $userRoles = New-Object -TypeName PSFive9Admin.userRoles

        if ($RoleName -eq "Agent")
        {
            $agentRole = New-Object -TypeName PSFive9Admin.agentRole
            $agentRole.permissions = @()

            $userRoles.agent = $agentRole

        }
        elseif ($RoleName -eq "Admin")
        {
            $userRoles.admin = @()
        }
        elseif ($RoleName -eq "Supervisor")
        {
            $userRoles.supervisor = @()
        }
        elseif ($RoleName -eq "Reporting")
        {
            $userRoles.reporting = @()
        }

        Write-Verbose "$($MyInvocation.MyCommand.Name): Adding '$RoleName' to user '$Username'." 
        $response = $global:DefaultFive9AdminClient.modifyUser($userToModify.generalInfo, $userRoles, $null)

        return $response.roles

    }
    catch
    {
        throw $_
    }
}

