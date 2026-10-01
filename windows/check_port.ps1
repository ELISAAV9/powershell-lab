# Uso: .\check_port.ps1 -Puerto <numero>
param(
    [Parameter(Mandatory = $true)]
    [int]$Puerto
)

# 1. Validar rango
if ($Puerto -lt 1 -or $Puerto -gt 65535) {
    Write-Host "Error: '$Puerto' no es un puerto válido (1-65535)"
    exit 1
}

# 2. Intentar conectar por TCP a localhost con límite de 2 segundos
$cliente = New-Object System.Net.Sockets.TcpClient
try {
    $tarea = $cliente.ConnectAsync("127.0.0.1", $Puerto)
    if ($tarea.Wait(2000) -and $cliente.Connected) {
        Write-Host "El puerto $Puerto está ABIERTO"
        exit 0
    }
    else {
        Write-Host "El puerto $Puerto está CERRADO"
        exit 2
    }
}
catch {
    # Conexión rechazada
    Write-Host "El puerto $Puerto está CERRADO"
    exit 2
}
finally {
    $cliente.Close()
}
