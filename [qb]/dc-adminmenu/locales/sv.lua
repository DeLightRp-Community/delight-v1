local Translations = {
    error = {
        ["blips_deactivated"] = "Blips inaktiverad",
        ["names_deactivated"] = "Names inaktiverad",
        ["changed_perm_failed"] = "Välj en grupp!",
        ["missing_reason"] = "Du måste ge en anledning!",
        ["invalid_reason_length_ban"] = "Du måste ge en anledning och ställa in en längd för ban!",
        ["no_store_vehicle_garage"] = "Du kan inte lagra detta fordon i ditt garage..",
        ["no_vehicle"] = "Du är inte i ett fordon..",
        ["no_weapon"] = "Du har inte ett vapen i händerna..",
        ["no_free_seats"] = "Fordonet har inga fria säten!",
        ["failed_vehicle_owner"] = "Det här fordonet är redan ditt..",
        ["not_online"] = "Den här spelaren är inte online",
        ["no_receive_report"] = "Du får inte reports",
        ["failed_set_speed"] = "Du ställde inte en hastighet.. (`fast` for super-run, `normal` for normal)",
        ["failed_set_model"] = "Du ställde inte in en modell..",
        ["player_no_vehicle"] = "Spelaren är inte i ett fordon",
        ["give_item"] = "Du måste ange allt",
    },
    success = {
        ["blips_activated"] = "Blips activated",
        ["names_activated"] = "Names activated",
        ["coords_copied"] = "Koordinater kopierade till urklipp!",
        ["heading_copied"] = "Heading kopierad till urklipp!",
        ["changed_perm"] = "Rättighetsgrupp Ändrad",
        ["entered_vehicle"] = "Sitter i Fordonet",
        ["success_vehicle_owner"] = "Fordonet är nu ditt!",
        ["receive_reports"] = "Du får reports",
    },
    info = {
        ["ped_coords"] = "Ped Koordinater:",
        ["vehicle_dev_data"] = "Fordons Data:",
        ["ent_id"] = "Entity ID:",
        ["net_id"] = "Net ID:",
        ["model"] = "Model",
        ["hash"] = "Hash",
        ["eng_health"] = "Motor Hälsa:",
        ["body_health"] = "Kaross Hälsa:",
        ["goto"] = "Gå Till",
        ["remove"] = "Radera",
        ["confirm"] = "Bekräfta",
        ["reason_title"] = "Anledning",
        ["length"] = "Längd",
        ["options"] = "Alternativ",
        ["position"] = "Position",
        ["your_position"] = "till din position",
        ["open"] = "Öppna",
        ["inventories"] = "Inventories",
        ["reason"] = "Du måste ge en anledning",
        ["give"] = "Ge",
        ["id"] = "ID:",
        ["player_name"] = "Spelarnamn",
        ["health"] = "Hälsa",
        ["networked"] = "Nätverkad",
        ["speed"] = "Fart",
        ["networked_owner_id"] = "Ägare-ID",
        ["delete_object_info"] = "Om du vill ta bort objektet trycker du på [~g~E~w~]",
        ["obj"] = "Obj",
        ["ammoforthe"] = "+%{value} Ammunition för %{weapon}",
        ["kicked_server"] = "Du har blivit sparkad från servern",
        ["check_discord"] = "🔸 Kolla våran discord för mer information: ",
        ["banned"] = "Du har blivit bannad:",
        ["ban_perm"] = "\n\nDin bann är permanent.\n🔸 Kolla våran discord för mer information: ",
        ["ban_expires"] = "\n\nBann Löper Ut Om: ",
        ["rank_level"] = "Din rättighetsgrupp är nu ",
        ["admin_report"] = "Admin Report - ",
        ["staffchat"] = "STAFFCHAT - ",
        ["warning_chat_message"] = "^8VARNING: ^7 Du har blivit varnad av",
        ["warning_staff_message"] = "^8VARNING: ^7 Du har varnat ",
        ["no_reason_specified"] = "Ingen anledning angiven",
        ["server_restart"] = "Server omstart, kolla våran discord för mer information: ",
        ["item"] = "Föremål",
        ["amount"] = "Belopp",
        ["sound"] = "Ljudnamn",
        ["volume"] = "Volym",
        ["confirm_play"] = "Bekräfta (Spela för spelare)",
        ["confirm_play_radius"] = "Bekräfta (Spela runt spelare)",
        ["dropped"] = "Hur gjorde du det här?",
        ["radio_list"] = "Spelarlista från radio",
    },
    menu = {
        ["admin_menu"] = "Adminmeny",
        ["admin_options"] = "Adminalternativ",
        ["online_players"] = "Online-spelare",
        ["manage_server"] = "Hantera servern",
        ["weather_conditions"] = "Tillgängliga väderalternativ",
        ["dealer_list"] = "Dealer Lista",
        ["ban"] = "Banna",
        ["kick"] = "Kicka",
        ["permissions"] = "Behörighet",
        ["developer_options"] = "Utvecklaralternativ",
        ["vehicle_options"] = "Fordonsalternativ",
        ["vehicle_categories"] = "Fordonskategorier",
        ["vehicle_models"] = "Fordonsmodeller",
        ["player_management"] = "Spelarhantering",
        ["server_management"] = "Serverhantering",
        ["vehicles"] = "Fordon",
        ["noclip"] = "NoClip",
        ["revive"] = "Återuppliva",
        ["invisible"] = "Osynlig",
        ["god"] = "Godmode",
        ["names"] = "Namn",
        ["blips"] = "Blips",
        ["weather_options"] = "Väderalternativ",
        ["server_time"] = "Server tid",
        ["time"] = "Tid",
        ["copy_vector3"] = "Kopiera vector3",
        ["copy_vector4"] = "Kopiera vector4",
        ["display_coords"] = "Visa Koordinater",
        ["copy_heading"] = "Kopiera Heading",
        ["vehicle_dev_mode"] = "Fordons dev-läge",
        ["delete_laser"] = "Radera laser",
        ["spawn_vehicle"] = "Spawna Fordon",
        ["fix_vehicle"] = "Fixa fordonet",
        ["buy"] = "Köp",
        ["remove_vehicle"] = "Ta bort fordonet",
        ["edit_dealer"] = "Redigera Dealer ",
        ["dealer_name"] = "Dealer namn",
        ["category_name"] = "Kategorinamn",
        ["kill"] = "Döda",
        ["freeze"] = "Frysa",
        ["spectate"] = "Åskåda",
        ["bring"] = "Ta Hit",
        ["sit_in_vehicle"] = "Sitt i fordonet",
        ["open_inv"] = "Öppna Inventory",
        ["give_clothing_menu"] = "Ge klädmenyn",
        ["hud_dev_mode"] = "Dev Mode (qb-hud)",
        ["player_general"] = "Generella alternativ",
        ["player_administration"] = "Administration",
        ["player_extra"] = "Extra alternativ",
        ["give_item_menu"] = "Ge ett föremål",
        ["play_sound"] = "Spela ett ljud",
        ["choose_sound"] = "Spela ett ljud",
        ["vehicle_godmode"] = "Fordon Godmode",
        ["ped"] = "Ändra PED-modell",
        ["reset_ped"] = "Återställ PED-modell",
        ["ammo"] = "Oändlig Ammunition",
        ["item_list"] = "Föremåls-lista",
        ["item_self"] = "Själv",
        ["routingbucket"] = "Routingbucket",
        ["mute_player"] = "Tysta Spelare",
        ["pull_stash"] = "Stash",
        ["tune_car"] = "Bennys",
    },
    desc = {
        ["admin_options_desc"] = "Diverse. Adminalternativ",
        ["player_management_desc"] = "Visa lista över spelare",
        ["server_management_desc"] = "Diverse Serveralternativ",
        ["vehicles_desc"] = "Fordonsalternativ",
        ["dealer_desc"] = "Lista över befintliga Dealers",
        ["noclip_desc"] = "Aktivera/inaktivera NoClip",
        ["revive_desc"] = "Återuppliva dig själv",
        ["invisible_desc"] = "Aktivera/inaktivera Osynlighet",
        ["god_desc"] = "Aktivera/inaktivera God Mode",
        ["names_desc"] = "Aktivera/inaktivera Namn över huvudet",
        ["blips_desc"] = "Aktivera/inaktivera Blips på spelare på mappen",
        ["weather_desc"] = "Ändra vädret",
        ["developer_desc"] = "Diverse. Dev-alternativ",
        ["vector3_desc"] = "Kopiera Vector3 till Urklipp",
        ["vector4_desc"] = "Kopiera vector4 till urklipp",
        ["display_coords_desc"] = "Visa Koordinater på skärmen",
        ["copy_heading_desc"] = "Kopiera Heading till Urklipp",
        ["vehicle_dev_mode_desc"] = "Display Fordonsinformation",
        ["delete_laser_desc"] = "Aktivera/inaktivera Laser",
        ["spawn_vehicle_desc"] = "Spawna ett fordon",
        ["fix_vehicle_desc"] = "Fixa fordonet du sitter i",
        ["buy_desc"] = "Köp fordonet gratis",
        ["remove_vehicle_desc"] = "Ta bort närmaste fordon",
        ["dealergoto_desc"] = "Gå till dealer",
        ["dealerremove_desc"] = "Radera dealer",
        ["kick_reason"] = "Sparka anledning",
        ["confirm_kick"] = "Bekräfta",
        ["ban_reason"] = "Bann anledning",
        ["confirm_ban"] = "Bekräfta",
        ["sit_in_veh_desc"] = "Sitt i",
        ["sit_in_veh_desc2"] = "'s fordon",
        ["clothing_menu_desc"] = "Ge klädmenyn till",
        ["hud_dev_mode_desc"] = "Enable/Disable Developer Mode",
        ["player_administration"] = "Banna, sparka eller ge rättigheter till en spelare",
        ["player_extra_desc"] = "Extra alternativ som att ge föremål etc..",
        ["give_item_menu_desc"] = "Ge ett specifikt föremål till",
        ["amount"] = "Belopp att ge",
        ["play_sound"] = "Spela ett ljud På",
        ["sound"] = "Vad är ljudfilnamnet",
        ["confirm_play"] = "Spela det här ljudet på den valda spelaren",
        ["confirm_play_radius"] = "Spela det här ljudet runt den valda spelaren",
        ["vehicle_godmode"] = "Aktiverar Godmode på Fordon",
        ["ped"] = "Ändra till en annan ped",
        ["reset_ped"] = "Gå tillbaka till din normala PED",
        ["ammo"] = "Ge dig själv oändlig ammunition",
        ["player_info"] = "Extra spelarinfo",
        ["item_list"] = "Få en fullständig lista över alla föremål på servern",
        ["item_self"] = "Fyll i föremål själv",
        ["routingbucket"] = "Teleportera denna spelare till en annan Routingbucket",
        ["mute_player"] = "Tysta Spelarens VOIP",
        ["radio_list"] = "Få en fullständig lista över spelare i en viss radiofrekvens",
        ["update_info"] = "Bara infoga logiska saker",
        ["pull_stash"] = "Öppna stash genom att ange namnet",
        ["tune_car"] = "Uppgradera din bil",
    },
    time = {
        ["ban_length"] = "Bann Längd",
        ["1hour"] = "1 timme",
        ["6hour"] = "6 himmar",
        ["12hour"] = "12 himmar",
        ["1day"] = "1 Dag",
        ["3day"] = "3 Dagar",
        ["1week"] = "1 Vecka",
        ["1month"] = "1 Månad",
        ["3month"] = "3 Månader",
        ["6month"] = "6 Månader",
        ["1year"] = "1 År",
        ["permenent"] = "Permanent",
        ["self"] = "Egen",
        ["changed"] = "Tiden ändras till %{time}:00",
    },
    weather = {
        ["extra_sunny"] = "Extra solig",
        ["extra_sunny_desc"] = "I'm Melting!",
        ["clear"] = "Klar",
        ["clear_desc"] = "Den perfekta dagen!",
        ["neutral"] = "Neutral",
        ["neutral_desc"] = "Bara en vanlig dag!",
        ["smog"] = "smog",
        ["smog_desc"] = "Rökmaskin!",
        ["foggy"] = "Dimmig",
        ["foggy_desc"] = "Rökmaskin x2!",
        ["overcast"] = "Mulet",
        ["overcast_desc"] = "Inte för soligt!",
        ["clouds"] = "Moln",
        ["clouds_desc"] = "Var är solen?",
        ["clearing"] = "Klarnar",
        ["clearing_desc"] = "Moln börjar rensa!",
        ["rain"] = "Regn",
        ["rain_desc"] = "Få det att regna!",
        ["thunder"] = "Åska",
        ["thunder_desc"] = "Spring och göm dig!",
        ["snow"] = "Snö",
        ["snow_desc"] = "Är det kallt här?",
        ["blizzard"] = "Snöstorm",
        ["blizzed_desc"] = "Snömaskin?",
        ["light_snow"] = "Lätt snö",
        ["light_snow_desc"] = "Börjar kännas som jul!",
        ["heavy_snow"] = "Tung snö (XMAS)",
        ["heavy_snow_desc"] = "Snöbollskrig!",
        ["halloween"] = "Halloween",
        ["halloween_desc"] = "Vad var det för ljud?!",
        ["weather_changed"] = "Väder ändras till: %{value}",
    },
    commands = {
        ["blips_for_player"] = "Visa blips för spelare (Admin Only)",
        ["player_name_overhead"] = "Visa spelarens namn över huvudet (Admin Only)",
        ["coords_dev_command"] = "Aktivera koordinater för utvecklings saker (Admin Only)",
        ["toogle_noclip"] = "Noclip (Admin Only)",
        ["save_vehicle_garage"] = "Spara fordon till ditt garage (Admin Only)",
        ["make_announcement"] = "Gör en Announcement (Admin Only)",
        ["open_admin"] = "Öppna administratörsmenyn (Admin Only)",
        ["staffchat_message"] = "Skicka ett meddelande till alla staff (Admin Only)",
        ["nui_focus"] = "Ge en spelare Nui Focus (Admin Only)",
        ["warn_a_player"] = "Varna en spelare (Admin Only)",
        ["check_player_warning"] = "Kontrollera spelarens varningar (Admin Only)",
        ["delete_player_warning"] = "Radera spelare varningar (Admin Only)",
        ["reply_to_report"] = "Svara på en rapport (Admin Only)",
        ["change_ped_model"] = "Ändra PED-modellen (Admin Only)",
        ["set_player_foot_speed"] = "Ange spelarens fothastighet (Admin Only)",
        ["report_toggle"] = "Växla inkommande rapporter (Admin Only)",
        ["kick_all"] = "Sparka alla spelare",
        ["ammo_amount_set"] = "Ställ in din ammunitionsbelopp (Admin Only)",
    },
    volume = {
        ["volume"] = "Volymen på ljudet",
        ["volume_desc"] = "Hur hög volymen ska vara på ljudet",
        ["radius"] = "Ljudområdet",
        ["radius_desc"] = "Hur långt ljudet ska spela",
        ["self"] = "Själv",
        ["01"] = "0.1",
        ["02"] = "0.2",
        ["03"] = "0.3",
        ["04"] = "0.4",
        ["05"] = "0.5",
        ["06"] = "0.6",
        ["07"] = "0.7",
        ["08"] = "0.8",
        ["09"] = "0.9",
        ["1.0"] = "1.0",
        ["10"] = "10",
        ["20"] = "20",
        ["30"] = "30",
        ["40"] = "40",
        ["50"] = "50",
        ["60"] = "60",
        ["70"] = "70",
        ["80"] = "80",
        ["90"] = "90",
        ["100"] = "100",
    },
    label = {
        ["name"] = "Namn",
        ["food"] = "Hunger",
        ["water"] = "Törst",
        ["stress"] = "Stress",
        ["armor"] = "Armor",
        ["phone"] = "Telefonnummer",
        ["craftingrep"] = "Crafting Reputation",
        ["dealerrep"] = "Dealer Reputation",
        ["cash"] = "Kontantsaldo",
        ["bank"] = "Banksaldo",
        ["job"] = "Jobb",
        ["gang"] = "Gäng",
        ["radio"] = "Radiofrekvens",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})