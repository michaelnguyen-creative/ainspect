=> Problem: Choice fields like UsageStatus & ConditionRating have errors (no options shown etc.), I don't know where this error comes from nor how to solve it (since the CapturedInspections wasn't seeded or anything, it's init on form submission...)

UsageStatus has these values 
Items: Choices([@CapturedInspections].ConditionRating)

Actual capturedinspections table has UsageStatus that is likely to be a text column...

💯 **Michael, great that you spotted this subtle issue — let’s break it down carefully so you can see exactly where the problem comes from and how to cleanly fix it.**

---

## 🚩 **Root cause**

👉 Your `CapturedInspections` collection is **not a SharePoint list**
👉 Therefore:

* `CapturedInspections.UsageStatus` is just plain **text** in your collection
* PowerApps can’t infer or auto-generate `Choices([@CapturedInspections].UsageStatus)`
* `Choices()` works only on SP columns (or Dataverse) that are of type *Choice / Lookup / Managed Metadata*

⚠ **Since `CapturedInspections` is a collection, `Choices([@CapturedInspections].ConditionRating)` or `Choices([@CapturedInspections].UsageStatus)` won’t work → will show nothing / error.**

---

## 🚀 **How to fix it**

👉 **Manually define the available options in the app.**
Instead of:

```powerapps
Items: Choices([@CapturedInspections].UsageStatus)
```

✅ Replace with:

```powerapps
Items: ["Operational", "Standby", "Deactivated", "Under Maintenance"]
```

(or whatever your actual SP choice options are)

Same for `ConditionRating`, `InspectionType`, etc:

```powerapps
Items: ["Good", "Fair", "Poor", "Critical"]
```

➡ This ensures your dropdowns always have the right options, regardless of whether you're online or offline.

---

## 🌟 **Where to define these lists?**

👉 You can:
1️⃣ **Directly in `Items` property of the dropdown / combobox**
2️⃣ Or cleaner: define app-level variables or collections on `OnStart`, e.g.:

```powerapps
Set(varUsageStatusOptions, ["Operational", "Standby", "Deactivated", "Under Maintenance"]);
Set(varConditionRatingOptions, ["Good", "Fair", "Poor", "Critical"]);
```

Then bind like:

```powerapps
Items: varUsageStatusOptions
```

👉 This makes future updates easier and keeps your code clean.

---

## ✅ **Summary of your solution**

| Problem                                                       | Solution                                                |
| ------------------------------------------------------------- | ------------------------------------------------------- |
| `Choices([@CapturedInspections].UsageStatus)` → empty / error | Replace with hardcoded list or app variable             |
| CapturedInspections = text fields → can’t infer Choice values | Manage choice values at app level (not from collection) |

---

## ⚡ **Bonus: future-proof**

If you want to **sync these option lists from SP dynamically** (optional but possible):

* On app start, download the choices from a config SP list or table
* Save to local collections
* Bind your dropdowns to those collections

---

## 🎯 **Final recommendation**

👉 Update your `Items` properties for choice fields to app-level lists
👉 Stop using `Choices([@CapturedInspections].Field)` — only valid for SP / Dataverse fields
