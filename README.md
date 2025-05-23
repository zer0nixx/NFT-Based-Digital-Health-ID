# Digital Health ID on Aptos

A Move smart contract for managing digital health records on the Aptos blockchain. This module enables patients to securely create, update, and share their health data with authorized medical providers.

---

## ✨ Features

- **Unique Digital Health ID:** Each patient can create a unique health record.
- **Data Privacy:** Only authorized providers or the patient can update health data.
- **Auditability:** All updates are timestamped for traceability.
- **Extensible:** Easily add new fields or permissions as needed.

---

## 🏗️ Module Overview

**Module:** `HealthRecords::DigitalHealthID`

### Struct: `HealthRecord`
- `id`: Unique identifier for the health record
- `data_hash`: Hash of health data (for off-chain verification)
- `created_at`: Creation timestamp
- `updated_at`: Last updated timestamp
- `authorized_providers`: List of addresses allowed to update

---

## 📝 Example Usage

### Create a Health ID

```move
public entry fun create_health_id(
    patient: &signer,
    record_id: String,
    data_hash: String
)
```

Update Health Record

public entry fun update_health_record(
    provider: &signer,
    patient_addr: address,
    new_data_hash: String
) acquires HealthRecord



🔒 Access Control
Only the patient or an authorized provider can update a health record.
Patients cannot create multiple health IDs.

 How to Run
1. Build the module:
```move
aptos move compile
```
3. Run tests:
```move
aptos move test
```


📄 License
MIT

Made with ❤️ for secure digital health on Aptos.

Contract Address - ```0x53b245a88bf6c728cab7b25bbcb9c51503911bc301f5d75e2978f5100ed22e51```

Sender Address - ```0xf91b1452ee8a00e314293dffdc38539c880f4714ccabffd47f05c0688b1349f5```
