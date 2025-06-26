```code
✅ 2. PowerApps + Local Cache Only (One-Way Sync)
Description:
Instead of two-way sync, treat the app as a field capture tool:

Download master data (Assets, Inspections) on start.

Let users submit new inspections/media only.

No editing/updating existing remote records.

Advantages:
Very simple logic.

No need for conflict resolution or record merging.

Robust even with poor/no network.

Limitations:
No editing of inspections.

Not collaborative (users can’t see each other’s edits).

Verdict:
✅ Ideal for asset audits, inspections, surveys, data collection — where data is append-only.
```

=> the app as field capture tool & another model-driven app as a portal/command center
