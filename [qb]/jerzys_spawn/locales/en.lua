local Translations = {
    error = {
        permission = 'No permission',
        title = 'Error',
    },
    success = {
        saveCords = 'Successfully created coord Point',
        title = 'Success',
        delete = 'Successfully deleted coord Point',
        update = 'Successfully updated coord Point',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
