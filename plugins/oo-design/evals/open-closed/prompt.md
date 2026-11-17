---
max_turns: 6
allowed_tools: [Skill]
---

Review the design of the following Java class and suggest improvements. We add a new parcel carrier every few months.

```java
public class ShippingCostCalculator {
    public BigDecimal cost(Parcel parcel, String carrier) {
        switch (carrier) {
            case "DHL":
                return parcel.weightKg().multiply(new BigDecimal("4.50"));
            case "UPS":
                return new BigDecimal("6.00").add(parcel.weightKg().multiply(new BigDecimal("3.20")));
            case "FEDEX":
                return parcel.isExpress()
                        ? new BigDecimal("15.00")
                        : parcel.weightKg().multiply(new BigDecimal("3.90"));
            default:
                throw new IllegalArgumentException("Unknown carrier: " + carrier);
        }
    }
}
```
