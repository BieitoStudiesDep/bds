
## configurar archivos

![[core-site.xml|core-site.xml]]
![[hdfs-site.xml-namenode]]
![[workers|workers]]

## establecer la tabla de particiones

```bash
hdfs namenode -format
```

>
>>[!ouput]-
>>
>> WARNING: /home/hdfs-admin/hadoop/logs does not exist. Creating.
>> 2024-04-28 19:43:51,538 INFO namenode.NameNode: STARTUP_MSG:
>> /************************************************************
>> STARTUP_MSG: Starting NameNode
>> STARTUP_MSG:   host = nodo01/192.168.0.101
>> STARTUP_MSG:   args = [-format]
>> STARTUP_MSG:   version = 3.4.0
>> STARTUP_MSG:   classpath = ....
>> STARTUP_MSG:   build = <git@github.com>:apache/hadoop.git -r bd8b77f398f626bb7791783192ee7a5dfaeec760; compiled by 'root' on 2024-03-04T06:35Z
>> STARTUP_MSG:   java = 1.8.0_402
>> ************************************************************/
>> 2024-04-28 19:43:51,585 INFO namenode.NameNode: registered UNIX signal handlers for [TERM, HUP, INT]
>> 2024-04-28 19:43:51,784 INFO namenode.NameNode: createNameNode [-format]
>> 2024-04-28 19:43:52,769 INFO common.Util: Assuming 'file' scheme for path /home/hadoop/discogrande/namenode in configuration.
>> 2024-04-28 19:43:52,771 INFO common.Util: Assuming 'file' scheme for path /home/hadoop/discogrande/namenode in configuration.
>> 2024-04-28 19:43:52,796 INFO namenode.NameNode: Formatting using clusterid: CID-509387a3-13f7-4f53-a80b-ce751c2ff750
>> 2024-04-28 19:43:52,892 INFO namenode.FSEditLog: Edit logging is async:true
>> 2024-04-28 19:43:52,950 INFO namenode.FSNamesystem: KeyProvider: null
>> 2024-04-28 19:43:52,957 INFO namenode.FSNamesystem: fsLock is fair: true
>> 2024-04-28 19:43:52,958 INFO namenode.FSNamesystem: Detailed lock hold time metrics enabled: false
>> 2024-04-28 19:43:52,983 INFO namenode.FSNamesystem: fsOwner                = hdfs-admin (auth:SIMPLE)
>> 2024-04-28 19:43:52,983 INFO namenode.FSNamesystem: supergroup             = supergroup
>> 2024-04-28 19:43:52,983 INFO namenode.FSNamesystem: isPermissionEnabled    = true
>> 2024-04-28 19:43:52,984 INFO namenode.FSNamesystem: isStoragePolicyEnabled = true
>> 2024-04-28 19:43:52,984 INFO namenode.FSNamesystem: HA Enabled: false
>> 2024-04-28 19:43:53,080 INFO common.Util: dfs.datanode.fileio.profiling.sampling.percentage set to 0. Disabling file IO >> profiling
>> 2024-04-28 19:43:53,310 INFO blockmanagement.DatanodeManager: Slow peers collection thread shutdown
>
>>[!error]-
>> 2024-04-28 19:43:53,330 ERROR blockmanagement.DatanodeManager: error reading hosts files:
>>> java.nio.file.NoSuchFileException: /home/hadoop/hadoop/etc/hadoop/workers
>>
>> 2024-04-28 19:43:53,675 WARN namenode.NameNode: Encountered exception during format
>>> java.io.IOException: Cannot create directory /home/hadoop/discogrande/namenode/current
>>
>> 2024-04-28 19:43:53,697 ERROR namenode.NameNode: Failed to start namenode.
>>> java.io.IOException: Cannot create directory /home/hadoop/discogrande/namenode/current
>>
>>2024-04-28 20:12:42,147 INFO namenode.NameNode: registered UNIX signal handlers for [TERM, HUP, INT]
2024-04-28 20:12:42,324 INFO namenode.NameNode: createNameNode [-format]
2024-04-28 20:12:42,856 INFO common.Util: Assuming 'file' scheme for path /home/hdfs-admin/discogrande/namenode in configuration.
2024-04-28 20:12:42,857 INFO common.Util: Assuming 'file' scheme for path /home/hdfs-admin/discogrande/namenode in configuration.
2024-04-28 20:12:42,866 INFO namenode.NameNode: Formatting using clusterid: CID-d156aec7-773f-4320-b8e9-539bf901f503
2024-04-28 20:12:42,945 INFO namenode.FSEditLog: Edit logging is async:true
2024-04-28 20:12:42,983 INFO namenode.FSNamesystem: KeyProvider: null
2024-04-28 20:12:42,986 INFO namenode.FSNamesystem: fsLock is fair: true
2024-04-28 20:12:42,987 INFO namenode.FSNamesystem: Detailed lock hold time metrics enabled: false 
2024-04-28 20:12:42,995 INFO namenode.FSNamesystem: fsOwner                = hdfs-admin (auth:SIMPLE)
2024-04-28 20:12:42,996 INFO namenode.FSNamesystem: supergroup             = supergroup
2024-04-28 20:12:42,996 INFO namenode.FSNamesystem: isPermissionEnabled    = true
2024-04-28 20:12:42,996 INFO namenode.FSNamesystem: isStoragePolicyEnabled = true
2024-04-28 20:12:42,997 INFO namenode.FSNamesystem: HA Enabled: false
2024-04-28 20:12:43,074 INFO common.Util: dfs.datanode.fileio.profiling.sampling.percentage set to 
0. Disabling file IO profiling
2024-04-28 20:12:43,230 INFO blockmanagement.DatanodeManager: Slow peers collection thread shutdown2024-04-28 20:12:43,245 INFO util.HostsFileReader: Adding a node "nodo02" to the list of included hosts from /home/hdfs-admin/hadoop/etc/hadoop/workers
2024-04-28 20:12:43,246 INFO util.HostsFileReader: Adding a node "nodo03" to the list of included hosts from /home/hdfs-admin/hadoop/etc/hadoop/workers
2024-04-28 20:12:43,247 INFO util.HostsFileReader: Adding a node "nodo04" to the list of included hosts from /home/hdfs-admin/hadoop/etc/hadoop/workers
2024-04-28 20:12:43,267 INFO blockmanagement.DatanodeManager: dfs.block.invalidate.limit : configured=1000, counted=20, effected=1000
2024-04-28 20:12:43,267 INFO blockmanagement.DatanodeManager: dfs.namenode.datanode.registration.ip-hostname-check=true
2024-04-28 20:12:43,268 WARN blockmanagement.DatanodeManager: The given interval for marking stale 
datanode = 30000, which is larger than heartbeat expire interval 11000.
2024-04-28 20:12:43,274 INFO blockmanagement.BlockManager: dfs.namenode.startup.delay.block.deletion.sec is set to 000:00:00:00.000
2024-04-28 20:12:43,275 INFO blockmanagement.BlockManager: The block deletion will start around 2024 Apr 28 20:12:43
2024-04-28 20:12:43,278 INFO util.GSet: Computing capacity for map BlocksMap
2024-04-28 20:12:43,278 INFO util.GSet: VM type       = 64-bit
2024-04-28 20:12:43,282 INFO util.GSet: 2.0% max memory 436 MB = 8.7 MB
2024-04-28 20:12:43,282 INFO util.GSet: capacity      = 2^20 = 1048576 entries
2024-04-28 20:12:43,296 INFO blockmanagement.BlockManager: Storage policy satisfier is disabled
2024-04-28 20:12:43,297 INFO blockmanagement.BlockManager: dfs.block.access.token.enable = false   
2024-04-28 20:12:43,312 INFO blockmanagement.BlockManagerSafeMode: Using 1000 as SafeModeMonitor Interval
2024-04-28 20:12:43,313 INFO blockmanagement.BlockManagerSafeMode: dfs.namenode.safemode.threshold-pct = 0.999
2024-04-28 20:12:43,313 INFO blockmanagement.BlockManagerSafeMode: dfs.namenode.safemode.min.datanodes = 0
2024-04-28 20:12:43,313 INFO blockmanagement.BlockManagerSafeMode: dfs.namenode.safemode.extension 
= 30000
2024-04-28 20:12:43,315 INFO blockmanagement.BlockManager: defaultReplication         = 2
2024-04-28 20:12:43,316 INFO blockmanagement.BlockManager: maxReplication             = 512
2024-04-28 20:12:43,316 INFO blockmanagement.BlockManager: minReplication             = 1
2024-04-28 20:12:43,317 INFO blockmanagement.BlockManager: maxReplicationStreams      = 2
2024-04-28 20:12:43,317 INFO blockmanagement.BlockManager: redundancyRecheckInterval  = 3000ms
2024-04-28 20:12:43,318 INFO blockmanagement.BlockManager: encryptDataTransfer        = false
2024-04-28 20:12:43,319 INFO blockmanagement.BlockManager: maxNumBlocksToLog          = 1000
2024-04-28 20:12:43,376 INFO namenode.FSDirectory: GLOBAL serial map: bits=29 maxEntries=536870911
2024-04-28 20:12:43,377 INFO namenode.FSDirectory: USER serial map: bits=24 maxEntries=16777215
2024-04-28 20:12:43,377 INFO namenode.FSDirectory: GROUP serial map: bits=24 maxEntries=16777215
2024-04-28 20:12:43,378 INFO namenode.FSDirectory: XATTR serial map: bits=24 maxEntries=16777215
2024-04-28 20:12:43,399 INFO util.GSet: Computing capacity for map INodeMap
2024-04-28 20:12:43,400 INFO util.GSet: VM type       = 64-bit
2024-04-28 20:12:43,401 INFO util.GSet: 1.0% max memory 436 MB = 4.4 MB
2024-04-28 20:12:43,401 INFO util.GSet: capacity      = 2^19 = 524288 entries
2024-04-28 20:12:43,404 INFO namenode.FSDirectory: ACLs enabled? true
2024-04-28 20:12:43,405 INFO namenode.FSDirectory: POSIX ACL inheritance enabled? true
2024-04-28 20:12:43,405 INFO namenode.FSDirectory: XAttrs enabled? true
2024-04-28 20:12:43,406 INFO namenode.NameNode: Caching file names occurring more than 10 times
2024-04-28 20:12:43,415 INFO snapshot.SnapshotManager: Loaded config captureOpenFiles: false, skipCaptureAccessTimeOnlyChange: false, snapshotDiffAllowSnapRootDescendant: true, maxSnapshotFSLimit: 65536, maxSnapshotLimit: 65536
2024-04-28 20:12:43,416 INFO snapshot.SnapshotManager: dfs.namenode.snapshot.deletion.ordered = false
2024-04-28 20:12:43,418 INFO snapshot.SnapshotManager: SkipList is disabled
2024-04-28 20:12:43,426 INFO util.GSet: Computing capacity for map cachedBlocks
2024-04-28 20:12:43,427 INFO util.GSet: VM type       = 64-bit
2024-04-28 20:12:43,428 INFO util.GSet: 0.25% max memory 436 MB = 1.1 MB
2024-04-28 20:12:43,428 INFO util.GSet: capacity      = 2^17 = 131072 entries
2024-04-28 20:12:43,442 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.window.num.buckets = 10
2024-04-28 20:12:43,443 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.num.users = 10
2024-04-28 20:12:43,443 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.windows.minutes = 1,5,25
2024-04-28 20:12:43,449 INFO namenode.FSNamesystem: Retry cache on namenode is enabled
2024-04-28 20:12:43,450 INFO namenode.FSNamesystem: Retry cache will use 0.03 of total heap and retry cache entry expiry time is 600000 millis
2024-04-28 20:12:43,455 INFO util.GSet: Computing capacity for map NameNodeRetryCache
2024-04-28 20:12:43,455 INFO util.GSet: VM type       = 64-bit
2024-04-28 20:12:43,456 INFO util.GSet: 0.029999999329447746% max memory 436 MB = 133.9 KB
2024-04-28 20:12:43,456 INFO util.GSet: capacity      = 2^14 = 16384 entries
2024-04-28 20:12:43,562 INFO namenode.FSImage: Allocated new BlockPoolId: BP-1060448874-192.168.0.101-1714327963551
2024-04-28 20:12:43,600 INFO common.Storage: Storage directory /home/hdfs-admin/discogrande/namenode has been successfully formatted.
2024-04-28 20:12:43,640 INFO namenode.FSImageFormatProtobuf: Saving image file /home/hdfs-admin/discogrande/namenode/current/fsimage.ckpt_0000000000000000000 
using no compression
2024-04-28 20:12:43,781 INFO namenode.FSImageFormatProtobuf: Image file /home/hdfs-admin/discogrande/namenode/current/fsimage.ckpt_0000000000000000000 of size 402 bytes saved in 0 seconds .
2024-04-28 20:12:43,799 INFO namenode.NNStorageRetentionManager: Going to retain 1 images with txid >= 0
2024-04-28 20:12:43,808 INFO blockmanagement.DatanodeManager: Slow peers collection thread shutdown2024-04-28 20:12:43,818 INFO namenode.FSNamesystem: Stopping services started for active state
2024-04-28 20:12:43,819 INFO namenode.FSNamesystem: Stopping services started for standby state
2024-04-28 20:12:43,826 INFO namenode.FSImage: FSImageSaver clean checkpoint: txid=0 when meet shutdown.
2024-04-28 20:12:43,827 INFO namenode.NameNode: SHUTDOWN_MSG:
