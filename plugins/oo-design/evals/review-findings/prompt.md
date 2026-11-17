---
max_turns: 6
allowed_tools: [Skill]
---

Review the following Java code and report your findings.

```java
public class ReportService {
    public List<String> lines = new ArrayList<>();

    public void createReport(List<Invoice> invoices) {
        lines.clear();
        double total = 0;
        for (Invoice i : invoices) {
            if (i.getAmount() > 10000) {
                lines.add("LARGE: " + i.getNumber() + " " + String.format("%.2f", i.getAmount() * 1.19));
            } else {
                lines.add(i.getNumber() + " " + String.format("%.2f", i.getAmount() * 1.19));
            }
            total += i.getAmount() * 1.19;
        }
        lines.add("TOTAL " + String.format("%.2f", total));
        try {
            Files.write(Path.of("/tmp/report.txt"), lines);
        } catch (IOException e) {
        }
    }
}
```
