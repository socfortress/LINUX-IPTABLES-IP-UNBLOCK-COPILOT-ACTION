## Unblock-IP-iptables

This script unblocks a specified IP address using iptables, providing a JSON-formatted output for integration with security tools like OSSEC/Wazuh.

### Overview

The `Unblock-IP-iptables` script checks if an IP address is currently blocked by an iptables DROP rule and removes the rule if present. It logs all actions and outputs the result in JSON format for active response workflows.

### Script Details

#### Core Features

1. **IP Unblocking**: Removes iptables DROP rules for a specified IPv4 address.
2. **Status Reporting**: Reports whether the IP was unblocked, not blocked, or if an error occurred.
3. **JSON Output**: Generates a structured JSON report for integration with security tools.
4. **Logging Framework**: Provides detailed logs for script execution.
5. **Log Rotation**: Implements automatic log rotation to manage log file size.

### How the Script Works

#### Command Line Execution
```bash
ARG1="1.2.3.4" ./Unblock-IP-iptables
```

#### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `ARG1`    | string | The IPv4 address to unblock (required) |
| `LOG`     | string | `/var/ossec/active-response/active-responses.log` (output JSON log) |
| `LogPath` | string | `/tmp/Unblock-IP-iptables.log` (detailed execution log) |
| `LogMaxKB` | int | 100 | Maximum log file size in KB before rotation |
| `LogKeep` | int | 5 | Number of rotated log files to retain |

### Script Execution Flow

#### 1. Initialization Phase
- Rotates the detailed log file if it exceeds the size limit
- Clears the active response log file
- Logs the start of the script execution

#### 2. Unblock Logic
- Checks if the IP is provided and valid
- Checks if the IP is currently blocked by iptables
- Removes the DROP rule if present
- Logs the result and status

#### 3. JSON Output Generation
- Formats the result into a JSON object
- Writes the JSON result to the active response log

### JSON Output Format

#### Example Response
```json
{
  "timestamp": "2025-07-18T10:30:45.123Z",
  "host": "HOSTNAME",
  "action": "Unblock-IP-iptables",
  "ip": "1.2.3.4",
  "status": "unblocked",
  "reason": "IP unblocked successfully",
  "copilot_soar": true
}
```

#### Already Unblocked Response
```json
{
  "timestamp": "2025-07-18T10:30:45.123Z",
  "host": "HOSTNAME",
  "action": "Unblock-IP-iptables",
  "ip": "1.2.3.4",
  "status": "not_blocked",
  "reason": "No matching iptables rule found",
  "copilot_soar": true
}
```

#### Error Response
```json
{
  "timestamp": "2025-07-18T10:30:45.123Z",
  "host": "HOSTNAME",
  "action": "Unblock-IP-iptables",
  "ip": "",
  "status": "error",
  "reason": "No IP provided",
  "copilot_soar": true
}
```

#### Invalid IP Response
```json
{
  "timestamp": "2025-07-18T10:30:45.123Z",
  "host": "HOSTNAME",
  "action": "Unblock-IP-iptables",
  "ip": "not_an_ip",
  "status": "error",
  "reason": "Invalid IP format",
  "copilot_soar": true
}
```

#### iptables Not Installed Response
```json
{
  "timestamp": "2025-07-18T10:30:45.123Z",
  "host": "HOSTNAME",
  "action": "Unblock-IP-iptables",
  "ip": "1.2.3.4",
  "status": "failed",
  "reason": "iptables not installed",
  "copilot_soar": true
}
```

### Implementation Guidelines

#### Best Practices
- Run the script with appropriate permissions to manage iptables rules
- Validate the JSON output for compatibility with your security tools
- Test the script in isolated environments

#### Security Considerations
- Ensure minimal required privileges
- Protect the output log files

### Troubleshooting

#### Common Issues
1. **Permission Errors**: Ensure the script has privileges to modify iptables rules
2. **Missing or Invalid IP**: Provide a valid IPv4 address via the `ARG1` environment variable
3. **iptables Not Installed**: Ensure `iptables` is installed
4. **Log File Issues**: Check write permissions

#### Debugging
Enable verbose logging:
```bash
VERBOSE=1 ARG1="1.2.3.4" ./Unblock-IP-iptables
```

### Contributing

When modifying this script:
1. Maintain the IP unblocking and JSON output structure
2. Follow Shell scripting best practices
3. Document any additional functionality
4. Test thoroughly in isolated environments
