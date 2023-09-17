exports.ox_inventory:RegisterStash('policezbrojownia', 'Zbrojownia LSPD', 100, 500000)
exports.ox_inventory:RegisterStash('policehaw', 'Szafka HAW', 100, 500000)
exports.ox_inventory:RegisterStash('policewu', 'Szafka WU', 100, 500000)

TriggerEvent('esx_service:activateService', 'police', -1)

TriggerEvent('esx_society:registerSociety', 'police', "LSPD", 'society_police', 'society_police', 'society_police', {
    type = 'public'
})