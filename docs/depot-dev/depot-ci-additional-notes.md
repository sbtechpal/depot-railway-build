# Depot CI Additional Notes

## Durable Storage vs Persistent Storage

Are they the same thing?

They're very similar and often used interchangeably, but there's a subtle distinction:

| Term | Emphasis | Example |
| :--- | :--- | :--- |
| **Persistent** | Data survives power cycles / reboots | Hard drive, SSD, database |
| **Durable** | Data survives failures / crashes | Distributed consensus (etcd), write-ahead logs |

### In Practice

- **Persistent** = "writes to disk, not RAM"
- **Durable** = "writes survive failures, can be recovered"

### For Depot CI's Switchyard

"Durable state machine" means both: state is persisted to storage **and** designed to recover from infrastructure failures. The term "durable" emphasizes that even if a component crashes, the workflow state isn't lost and can resume exactly where it left off.
