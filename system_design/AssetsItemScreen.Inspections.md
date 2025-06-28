Fix refresh (rebuild) LocalInspections in AssetsItemScreen on offline form submission
Add trigger for refresh/build

Perhaps it would make better sense to build LocalInspections on AssetsItemScreen visible

right now LocalInspections collection is built on app start with this logic
```fx
// --- 📋 6. Merge Captured + Downloaded into LocalInspections ---
// Collect DownloadedInspections transformed
Collect(
    LocalInspections,
    AddColumns(
        ShowColumns(
            DownloadedInspections,
            InspectionId,
            AssetId,
            Inspector,
            InspectionDate
        ),
        Source, "Remote",
        SyncStatus, "Synced"
    )
);

// Collect CapturedInspections transformed
Collect(
    LocalInspections,
    AddColumns(
        ShowColumns(
            CapturedInspections,
            InspectionId,
            AssetId,
            Inspector,
            InspectionDate,
            Inspected,
            SyncStatus
        ),
        Source, "Local"
    )
);```

is there a simpler way to refresh the localinspections collection without having to rebuild everything while keeping everything organized & in sync?
---
You're on the right track wanting to **move LocalInspections building logic to `AssetItemScreen.OnVisible`** — that’s cleaner, ensures it's always up to date **after form submission**, and keeps things in sync without redundant app-wide rebuilding.

Let’s break it down and propose a simpler, maintainable solution.

---

## 💡 **Why rebuild on `AssetItemScreen.OnVisible`?**

✅ You always want LocalInspections to reflect:

* Latest *DownloadedInspections* (if refreshed or loaded)
* Latest *CapturedInspections* (if just submitted offline)

✅ You avoid doing unnecessary work at app start (which might slow loading)

---

## ⚡ **Simpler rebuild logic**

You don’t need to `Collect` twice with separate calls; you can combine the collections *before* calling `ClearCollect`. PowerApps allows you to `ClearCollect` from `Ungroup` + `AddColumns` of a merged table.

---

## ✨ Proposed code for `AssetItemScreen.OnVisible`

```powerapps
// Merge both transformed collections at once
ClearCollect(
    LocalInspections,
    Ungroup(
        Table(
            {
                Group: AddColumns(
                    ShowColumns(
                        DownloadedInspections,
                        "InspectionId",
                        "AssetId",
                        "Inspector",
                        "InspectionDate"
                    ),
                    "Source", "Remote",
                    "SyncStatus", "Synced"
                )
            },
            {
                Group: AddColumns(
                    ShowColumns(
                        CapturedInspections,
                        "InspectionId",
                        "AssetId",
                        "Inspector",
                        "InspectionDate",
                        "Inspected",
                        "SyncStatus"
                    ),
                    "Source", "Local"
                )
            }
        ),
        "Group"
    )
);
```

✅ This logic:

* Combines both in **one ClearCollect**
* Avoids double calls to `Collect`
* Is easy to maintain
* Works even if one collection is empty

---

## 📝 **Trigger refresh manually?**

If you want, you can create a button:

```powerapps
OnSelect:
Select(AssetItemScreen) // Triggers OnVisible logic again
```

Or just call the same ClearCollect logic in your form’s `OnSuccess` or `OnSave`.

---

## 🚀 Alternative: Use a helper function (if you want)

If you have a central location (like an App-level function screen or component):

```powerapps
Set(varRebuildLocalInspections, true)
```

and in `AssetItemScreen.OnVisible`:

```powerapps
If(varRebuildLocalInspections,
    // ClearCollect logic...
    Set(varRebuildLocalInspections, false)
)
```

---

## ✅ Summary of best practice

👉 **Move LocalInspections building to `AssetItemScreen.OnVisible`.**

👉 **Merge both collections in one ClearCollect using Table + Ungroup trick.**

👉 **Optionally use a flag like `varRebuildLocalInspections` to control when to rebuild.**
