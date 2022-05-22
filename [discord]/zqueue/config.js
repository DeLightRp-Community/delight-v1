// Log debug messages (joined queue, removed from queue, etc)
const debug = false;

// Use queue always (true) or only when server is at near capacity (false)
const alwaysUse = true;

// amount of time someone can rejoin without having to wait in queue again (for crashes)
const graceListTime = 5; // minutes

const adaptiveCard = {
    "card_title": "DeLightRP",
    "card_header": "https://cdn.discordapp.com/attachments/930782372155260939/977818225599479838/56569569659.png",
    "card_description": "Welcome to The DeLight Rp Queue",
    "button1_title": "Website",
    "button1_url": "https://delightrp.com/",
    "button2_title": "Discord",
    "button2_url": "https://discord.gg/FvxrKkyQyq",
};


const priorityList = [ // Order defines priority
    // { // Priority 1
    //     "title": "Owner",
    //     "roles": [
    //         "000000000000000000", // Owner / God
    //     ],
    // },
    // { // Priority 2
    //     "title": "Staff",
    //     "roles": [
    //         "000000000000000000", // Admin
    //         "000000000000000000", // Mod
    //     ],
    // },
    { // Priority 1
        "title": "VIP",
        "roles": [
            "930782284880183306", // Donor
        ],
    },
    { // Priority 2
        "title": "WhiteListed",
        "roles": [
            "930782320942800916", // Whitelist
            "946122365778149482" //Whitelist Test Server
        ],
    },
    // Everyone else will default to end
];



/** !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * !! DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU'RE DOING !!
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

module.exports = {
    debug: getConBool("zqueue_debug", debug),
    alwaysUse: getConBool("zqueue_alwaysuse", alwaysUse),
    graceListTime: graceListTime,
    adaptiveCard: adaptiveCard,
    priorityList: priorityList,
};

/** Returns convar or default value fixed to a true/false boolean
 * @param {boolean|string|number} con - Convar name
 * @param {boolean|string|number} def - Default fallback value
 * @returns {boolean} - parsed bool */
function getConBool(con, def) {
    if (typeof def == "boolean") def = def.toString();
    const ret = GetConvar(con, def);
    if (typeof ret == "boolean") return ret;
    if (typeof ret == "string") return ["true", "on", "yes", "y", "1"].includes(ret.toLocaleLowerCase().trim());
    if (typeof ret == "number") return ret > 0;
    return false;
}
