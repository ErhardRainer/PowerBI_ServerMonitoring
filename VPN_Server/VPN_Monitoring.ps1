$serverName = "SQLServer"
$databaseName = "Monitoring"

$currentConnections = (Get-RemoteAccessConnectionStatistics)
foreach ($connection in $currentConnections) {
$bandwidth = $connection.Bandwidth
$hostName = $connection.HostName
$connectionDuration = $connection.ConnectionDuration
$connectionStartTime = $connection.ConnectionStartTime
$connectionType = $connection.ConnectionType
$totalBytesIn = $connection.TotalBytesIn
$totalBytesOut = $connection.TotalBytesOut
$transitionTechnology = $connection.TransitionTechnology
$tunnelType = $connection.TunnelType
$userActivityState = $connection.UserActivityState
$userName = $connection.UserName
$clientExternalAddress = $connection.ClientExternalAddress
$clientIPv4Address = $connection.ClientIPv4Address
$clientIPv6Address = $connection.ClientIPv6Address

# SQL-Stored procedure aufrufen
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection
$sqlConnection.ConnectionString = "Data Source=$serverName;Initial Catalog=$databaseName;Integrated Security=True;"
$sqlConnection.Open()

$sqlCommand = New-Object System.Data.SqlClient.SqlCommand
$sqlCommand.Connection = $sqlConnection
$sqlCommand.CommandType = [System.Data.CommandType]::StoredProcedure
$sqlCommand.CommandText = "sp_VPN_InsertVPNConnectionData"


$sqlCommand.Parameters.AddWithValue("@Bandwidth", [int]$bandwidth)
$sqlCommand.Parameters.AddWithValue("@HostName", [string]$hostName)
$sqlCommand.Parameters.AddWithValue("@ConnectionDuration", [string]$connectionDuration)
$sqlCommand.Parameters.AddWithValue("@ConnectionStartTime", [string]$connectionStartTime)
$sqlCommand.Parameters.AddWithValue("@ConnectionType", [string]$connectionType)
$sqlCommand.Parameters.AddWithValue("@TotalBytesIn", [int]$totalBytesIn)
$sqlCommand.Parameters.AddWithValue("@TotalBytesOut", [int]$totalBytesOut)
$sqlCommand.Parameters.AddWithValue("@TransitionTechnology", [string]$transitionTechnology)
$sqlCommand.Parameters.AddWithValue("@TunnelType", [string]$tunnelType)
$sqlCommand.Parameters.AddWithValue("@UserActivityState", [string]$userActivityState)
$sqlCommand.Parameters.AddWithValue("@UserName", [string]$userName)
$sqlCommand.Parameters.AddWithValue("@ClientExternalAddress", [string]$clientExternalAddress)
$sqlCommand.Parameters.AddWithValue("@ClientIPv4Address", [string]$clientIPv4Address)
$sqlCommand.Parameters.AddWithValue("@ClientIPv6Address", [string]$clientIPv6Address)

$sqlCommand.ExecuteNonQuery() | Out-Null
$sqlConnection.Close()
}
# SQL-Stored procedure aufrufen
$sqlConnection2 = New-Object System.Data.SqlClient.SqlConnection
$sqlConnection2.ConnectionString = "Data Source=$serverName;Initial Catalog=$databaseName;Integrated Security=True;"
$sqlConnection2.Open()

$sqlCommand2 = New-Object System.Data.SqlClient.SqlCommand
$sqlCommand2.Connection = $sqlConnection2
$sqlCommand2.CommandType = [System.Data.CommandType]::StoredProcedure
$sqlCommand2.CommandText = "sp_VPN_ConnectionPerDate"
$sqlCommand2.ExecuteNonQuery() | Out-Null
$sqlConnection2.Close()
Write-Host "Fertig"