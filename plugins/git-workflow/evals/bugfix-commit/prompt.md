---
max_turns: 6
allowed_tools: [Skill]
---

I fixed a bug and added a regression test. Reply with the exact git command you would run to commit both files; do not run it.

```diff
--- a/src/main/java/com/example/invoice/DueDateCalculator.java
+++ b/src/main/java/com/example/invoice/DueDateCalculator.java
@@ -12,6 +12,9 @@ public class DueDateCalculator {
     public LocalDate dueDate(LocalDate invoiceDate, int paymentTermDays) {
         LocalDate due = invoiceDate.plusDays(paymentTermDays);
-        return due;
+        while (due.getDayOfWeek() == DayOfWeek.SATURDAY || due.getDayOfWeek() == DayOfWeek.SUNDAY) {
+            due = due.plusDays(1);
+        }
+        return due;
     }
 }
--- a/src/test/java/com/example/invoice/DueDateCalculatorTest.java
+++ b/src/test/java/com/example/invoice/DueDateCalculatorTest.java
@@ -20,4 +20,10 @@ class DueDateCalculatorTest {
+    @Test
+    void dueDateOnWeekendMovesToMonday() {
+        LocalDate saturday = LocalDate.of(2026, 11, 14);
+        assertEquals(LocalDate.of(2026, 11, 16),
+                calculator.dueDate(saturday.minusDays(30), 30));
+    }
 }
```
