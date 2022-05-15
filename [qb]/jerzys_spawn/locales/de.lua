local Translations = {
    error = {
        permission = 'Keine Zulassung',
        title = 'Fehler',
    },
    success = {
        saveCords = 'Erfolgreich erstellter Koordinatenpunkt',
        title = 'Erfolg',
        delete = 'Erfolgreich gelöschter Koordinatenpunkt',
        update = 'Erfolgreich aktualisierter Koordinatenpunkt',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
