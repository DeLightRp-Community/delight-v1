Printer = {
    previewPaperWidth: parseInt(getComputedStyle(document.documentElement).getPropertyValue("--print-preview-width")),
    previewPaperHeight: parseInt(getComputedStyle(document.documentElement).getPropertyValue("--print-preview-width")) * Math.SQRT2,
    paperWidth: parseInt(getComputedStyle(document.documentElement).getPropertyValue("--paper-width")),
    paperHeight: parseInt(getComputedStyle(document.documentElement).getPropertyValue("--paper-width")) * Math.SQRT2,
    imageCount: 0,
    imageData: []
}

/* donr */
window.addEventListener("message", function(e){

    if(Printer[e.data.event]) {
        Printer[e.data.event](e.data.data || {})
    }
})

/* done */
Printer.post = (e, d, cb) => {
    $.post(`https://al_qb_printer/${e}`, JSON.stringify(d), cb)
}

/* done */
Printer.updateImageData = function() {
    this.imageData = []

    for(let i = 0; i < this.imageCount; i++) {
        const child = $("#pp-paper").children().eq(i) || {}
        const parent = $("#pp-paper").position()

        if(child.position()) {
            this.imageData[i] = {}; 

            /* math to get relative size and position + get url */
            this.imageData[i].x = (child.position().left - parent.left) / this.previewPaperWidth
            this.imageData[i].y = parseFloat((child.position().top - parent.top) / (parseFloat(this.previewPaperWidth * Math.SQRT2)))
            this.imageData[i].width = parseInt(child.width()) / this.previewPaperWidth
            this.imageData[i].height = parseInt(child.height()) / this.previewPaperHeight
            this.imageData[i].url = child.attr("url")
        }
    }
}

/* done */
Printer.openPrinter = function(data){
    Printer.translations = data.translations

    $("#root").html(`
        <div id="printer-interface">
            <div id="print-preview">
                <div id="pp-paper">
                    
                </div>

                
                <div class="input-field">
                    <input id="url" type="text">
                    <label >${data.translations.img_url}</label>
                </div>
                
                <a id="add-image" class="waves-effect btn" href="#">${data.translations.submit}</a>
            </div>

            <div id="print-settings">
                <div class="settings-wrapper">
                    <div class="input-field">
                        <input min="1" id="copys" type="number" value="1">
                        <label >${data.translations.copys}</label>
                    </div>

                    <div class="input-field">
                        <select id="select">
                            <option value="1">${data.translations.yes}</option>
                            <option value="0">${data.translations.no}</option>
                        </select>
                        <label>${data.translations.colored}</label>
                    </div>

                    <div class="input-field">
                        <input disabled value="${data.printer.inkLevel}%" type="text">
                        <label>Ink level</label>
                    </div>

                    <div class="input-field">
                        <input disabled value="${data.printer.paperAmount}/${data.cfg.MaxPapers}" type="text">
                        <label>Paper amount</label>
                    </div>
                    
                    <a id="print" class="waves-effect btn" href="#">${data.translations.print}</a>
                </div>

                <h1>
                    ${data.translations.tip}
                </h1>
            </div>
        </div>
    `)

    $('select').formSelect();

    $("#pp-paper").height(`${this.previewPaperHeight}px`)
    $("#paper").height(`${this.paperHeight}px`)
    M.updateTextFields()
}

/* done */
Printer.openPaper = function(data){
    $("#root").html(`
        <div id="paper">
                
        </div>
    `)

    $("#paper").height(this.paperWidth * Math.SQRT2)

    data.imageData.map(obj => {
        $("#paper").append(`
            <div style="
                position: absolute; 
                left: ${obj.x * 100}%;
                top: ${obj.y * 100}%;
                height: ${obj.height * 100}%;
                width: ${obj.width * 100}%;
            " class="imported-obj">
                <img class="${!data.colored ? "bnw" : ""}" src=${obj.url} alt="">
            </div>
        `)
    }) 
}

/* done */
Printer.printImage = $(document).on("click", "#print", () => {
    const copys = parseInt($("#copys").val())
    const colored = parseInt($("#select option:selected").val())

    if(!Printer.imageData[0]) {
        M.toast({ html: Printer.translations.notifications.no_img })

        return  
    }

    if(!copys || copys < 1){
        M.toast({ html: Printer.translations.notifications.invalid_copys })

        return    
    }

    Printer.post("printImage", {
        copys: copys,
        colored: colored,
        imageData: Printer.imageData
    }, (res) => {

        if(res === "no_paper"){
            M.toast({ html: Printer.translations.notifications.no_paper })

            return
        } 

        if(res === "no_ink") {
            M.toast({ html: Printer.translations.notifications.no_ink })

            return
        }

        if(res === "success") {
            Printer.close()
        }
    })
})

/* done */
Printer.close = () => {
    $("#root").html("")

    Printer.post("close")
}

/* done */
$(document).on("click", "#add-image", () => {
    const url = $("#url").val()

    if(!url){
        M.toast({html: Printer.translations.notifications.url_image})

        return
    }


    Printer.imageCount += 1

    $("#pp-paper").append(`
        <div url=${url || "unknown"} class="imported-obj">
            <img src=${url} alt="">
        </div>
    `)

    $(".imported-obj").resizable({
        aspectRatio: true,
    }).draggable({
        containment: "parent",
    })

    $("#url").val("")
    M.updateTextFields()
})

/* on right click => remove obj */
$(document).on("mousedown", ".imported-obj", function(event){
    switch(event.which) {
        case 3: {
            Printer.imageCount -= 1

            const id = $(".imported-obj").index(this)

            $(this).remove()  
        }
    }
})

/* checks for image data every 500ms */
setInterval(() => {
    Printer.updateImageData()
}, 500)

/* done */
$(document).keyup(function(e) {
    if (e.keyCode == 27) {
        
        Printer.close()
    }
 });