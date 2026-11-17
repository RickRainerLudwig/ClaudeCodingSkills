---
max_turns: 6
allowed_tools: [Skill]
---

Add documentation comments (Javadoc and inline comments) to the following Java method. Reply with the documented code in your answer.

```java
public Duration nextDelay(int attempt) {
    long base = 500L * (1L << Math.min(attempt, 6));
    long jitter = ThreadLocalRandom.current().nextLong(base / 2);
    return Duration.ofMillis(base / 2 + jitter);
}
```
