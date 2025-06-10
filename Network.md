# Network Configuration
## Operating System Specific Configuration
   * Ensure **Network Throttling Index feature is enabled**
     * **Recommendation:** Set a value between **10 and 20 decimal**, e.g. 15mbps-30mbps
     ```HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\NetworkThrottlingIndex``` 
     * See [research on Network Throttling Index](../../RESEARCH/NETWORK/README.md#networkthrottlingindex) and the impacts on NDIS DPC processing latency.
   * **Use a network adapter that supports Message-Signaled Interrupts (MSI/MSI-X)**
     * Most modern network adapters and associated driver configuration files define the use of MSI out of the box, when this is enabled it allows both the interrupt service routines and deferred procedure calls to be allocated to the same CPU cores allowing for better processing efficiency and improved performance.
     * To determine if Windows recognizes your adapter as RSS and MSI-X capable use the following commands, if identified as capable windows will allocate ISR/DPCs to CPU/Cores as specified by the RSS Base and Max core configuration discussed in the next step.
       ``` 
       As administrator run the following commands in powershell.exe
       
       > Get-NetAdapterHardwareInfo | fl
       Name                        : Ethernet 2
       InterfaceDescription        : Intel(R) Gigabit CT Desktop Adapter
       [...]
       LineBasedInterruptSupported : True
       MsiInterruptSupported       : True
       MsiXInterruptSupported      : True
       
       > Get-SmbClientNetworkInterface
       Interface Index RSS Capable RDMA Capable Speed  IpAddresses    Friendly Name
       --------------- ----------- ------------ -----  -----------    -------------
       14              True        False        1 Gbps {192.168.0.3} Ethernet 2
       ```
     * See the [Technical References](../../TECHNICAL%20REFERENCES/README.md) page articles under **Microsoft Windows > Networking** regarding RSS, and RSS with Message Signaled Interrupts. You can also validate this optimization is working not only via performance increase but that the NDIS work is being locked to the predefined CPU cores with tools such as xperf.
   * Consider **binding your Receive Side Scaling (RSS) queue workloads to one or more CPUs**, assuming you have MSI/MSI-X enabled as noted above.
     * There has been notable NDIS DPC latency processing improvements observed (xperf isr/dpc latency analysis) through binding your RSS queues to specific cores. By default Windows primarily allocates much of the process and thread work to Core 0 of your CPU so there may be added benefit moving that workload to less used cores.
     * **Recommendation:** If you have a 4 core CPU, try binding RSS queues to cores 2 and 3 (3rd and 4th core)
     ``` 
         Run the following commands using powershell.exe as administrator
         Get-NetAdapterRSS
             Make note of the name associated with the network adapter e.g. Ethernet
         Set-NetAdapterRSS -Name "Ethernet" -BaseProcessorNumber 2
             Bind the RSS base core value to core 2 (3rd core), if you have 2 RSS queues
             enabled this should allocate work to 3rd and 4th core.
     ```


