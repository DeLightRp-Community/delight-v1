local Translations = {
    error = {
        permission = 'Brak zatwierdzenia',
        title = 'Error',
    },
    success = {
        saveCords = 'Pomyślnie utworzono punkt współrzędnych',
        title = 'Sukces',
        delete = 'Pomyślnie usunięto punkt współrzędnych',
        update = 'Pomyślna aktualizacja punktu współrzędnych',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
