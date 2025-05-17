module HealthRecords::DigitalHealthID {
    use std::string::{String};
    use std::vector;
    use aptos_framework::signer;
    use aptos_framework::timestamp;
    
    /// Error codes
    const E_NOT_AUTHORIZED: u64 = 1;
    const E_ALREADY_HAS_HEALTH_ID: u64 = 2;
    
    /// Struct representing a digital health ID with medical information
    struct HealthRecord has key {
        // Unique identifier for the health record
        id: String,
        // Health data hash (can be used for verification with off-chain data)
        data_hash: String,
        // Creation timestamp
        created_at: u64,
        // Last updated timestamp
        updated_at: u64,
        // Authorized medical providers that can update this record
        authorized_providers: vector<address>
    }
    
    /// Creates a new digital health ID for a patient
    public entry fun create_health_id(
        patient: &signer,
        record_id: String,
        data_hash: String
    ) {
        let patient_addr = signer::address_of(patient);
        
        // Ensure patient doesn't already have a health ID
        assert!(!exists<HealthRecord>(patient_addr), E_ALREADY_HAS_HEALTH_ID);
        
        // Get current timestamp
        let current_time = timestamp::now_seconds();
        
        // Store the health record with initial data
        let health_record = HealthRecord {
            id: record_id,
            data_hash,
            created_at: current_time,
            updated_at: current_time,
            authorized_providers: vector::empty<address>()
        };
        
        move_to(patient, health_record);
    }
    
    /// Updates the health record with new data
    public entry fun update_health_record(
        provider: &signer,
        patient_addr: address,
        new_data_hash: String
    ) acquires HealthRecord {
        let provider_addr = signer::address_of(provider);
        let record = borrow_global_mut<HealthRecord>(patient_addr);
        
        // Check if provider is authorized or is the patient
        let is_authorized = provider_addr == patient_addr || 
                           vector::contains(&record.authorized_providers, &provider_addr);
        
        assert!(is_authorized, E_NOT_AUTHORIZED);
        
        // Update the record with new data
        record.data_hash = new_data_hash;
        record.updated_at = timestamp::now_seconds();
    }
}