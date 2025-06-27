Should RemoteInspection (sharepoint records) include Inspection status? If yes which value should it have & state transition events associated with each?
LocalInspection already has a sync status property to track sync lifecycle

✅ **Excellent architectural question** — this distinction between `RemoteInspection` (SharePoint records) and `LocalInspection` (PowerApps offline-first capture) is key for clarity, traceability, and system robustness.

Let’s break it down carefully.

---

## ⚡ Should `RemoteInspection` include **InspectionStatus**?

👉 **Yes** — it's highly recommended.
Your `RemoteInspection` records in SharePoint should have a clear **business-level status field** that reflects the inspection’s lifecycle *from the organization’s / command center’s perspective*.

This status is separate from the **SyncStatus** (which is purely about technical data flow).

---

## 🚦 Suggested `InspectionStatus` values (RemoteInspection)

Here’s a clean, minimal **state model** for `RemoteInspection`:

| Status      | Meaning                                                        | Set When                                                          |
| ----------- | -------------------------------------------------------------- | ----------------------------------------------------------------- |
| `Submitted` | Inspection was captured & synced from the app                  | When PowerApps pushes the inspection to SharePoint                |
| `In Review` | Inspection is being checked / audited by office or supervisors | When an authorized person starts reviewing in SharePoint / portal |
| `Approved`  | Inspection has been reviewed and accepted                      | When supervisor/QA marks as approved                              |
| `Rejected`  | Inspection failed review and needs follow-up                   | When supervisor/QA rejects                                        |
| `Closed`    | (Optional) Inspection completed, follow-up done if needed      | When final resolution actions are recorded                        |

You can add more if your business flow requires, but this covers most use cases.

---

## 🔁 **State transition events**

| From                           | To                                   | Event |
| ------------------------------ | ------------------------------------ | ----- |
| (null / not set) → `Submitted` | Mobile app sync                      |       |
| `Submitted` → `In Review`      | Reviewer opens or assigns inspection |       |
| `In Review` → `Approved`       | Reviewer approves                    |       |
| `In Review` → `Rejected`       | Reviewer rejects                     |       |
| `Approved` → `Closed`          | (Optional) Follow-up completed       |       |
| `Rejected` → `Closed`          | (Optional) Follow-up completed       |       |

---

## 📝 Where to set this in your pipeline

✅ **PowerApps (Mobile App)**
When syncing to SharePoint, PowerApps should:

```powerapps
Patch(
    Inspections,
    Defaults(Inspections),
    {
        InspectionId: ThisRecord.InspectionId,
        AssetId: ThisRecord.AssetId,
        ...
        InspectionStatus: "Submitted"
    }
)
```

✅ **Command Center / Portal**

* Portal users update `InspectionStatus` as they review and process inspections.

---

## 🚫 Don’t overload `SyncStatus`

👉 Your existing `SyncStatus` in `LocalInspection` (e.g., `Pending`, `Synced`, `Error`) is great — don’t mix this with `InspectionStatus`.

* `SyncStatus` = technical (has this record reached SharePoint?)
* `InspectionStatus` = business (what's the inspection’s lifecycle state?)

---

## 🌟 Final design tip

Your `RemoteInspection` SharePoint schema could look like:

| Field              | Purpose                   |
| ------------------ | ------------------------- |
| `InspectionId`     | Unique ID for inspection  |
| `AssetId`          | Link to asset             |
| `InspectorName`    | Who performed it          |
| `InspectionDate`   | When it happened          |
| `InspectionStatus` | Business lifecycle status |
| `CreatedBy`        | Who submitted (PowerApps) |
| `ReviewedBy`       | Who reviewed (portal)     |
| `ReviewedDate`     | When reviewed             |
| `ApprovalNotes`    | Any notes from reviewer   |
| `Attachments`      | Linked media              |

