---
type: llm
weight: 1
---

The comments explain the intention and the reasons (e.g. exponential backoff to reduce load on a struggling service, the cap at 2^6 to limit the maximum delay, jitter so that many clients do not retry at the same moment) instead of restating the operations (e.g. 'shift 1 left by attempt', 'add jitter to base'). The Javadoc describes the purpose and the contract (parameter meaning, result range). Fail if most comments only repeat what the code does.
