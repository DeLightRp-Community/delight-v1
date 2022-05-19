const { ref } = Vue

// Customize language for dialog menus and carousels here

const load = Vue.createApp({
  setup () {
    return {
      CarouselText1: 'Space For Mute/UnMute Music',
      CarouselSubText1: '',
      CarouselText2: '',
      CarouselSubText2: '',
      CarouselText3: '.',
      CarouselSubText3: '',
      CarouselText4: '',
      CarouselSubText4: '',

      DownloadTitle: '',
      DownloadDesc: "",

      SettingsTitle: '',
      AudioTrackDesc1: '',
      AutoPlayDesc2: '',
      PlayVideoDesc3: '',

      KeybindTitle: '',
      Keybind1: '',
      Keybind2: '',
      Keybind3: '',
      Keybind4: '',
      Keybind5: '',
      Keybind6: '',
      Keybind7: '',
      Keybind8: '',
      Keybind9: '',
      Keybind10: '',
      Keybind11: '',
      Keybind12: '',
      Keybind13: '',
      Keybind14: '',
      Keybind15: '',
      Keybind16: '',

      firstap: ref(true),
      secondap: ref(true),
      thirdap: ref(true),
      firstslide: ref(1),
      secondslide: ref('1'),
      thirdslide: ref('5'),
      audioplay: ref(true),
      playvideo: ref(true),
      download: ref(true),
      settings: ref(false),
    }
  }
})

load.use(Quasar, { config: {} })
load.mount('#loading-main')

var audio = document.getElementById("audio");
audio.volume = 0.05;

function audiotoggle() {
    var audio = document.getElementById("audio");
    if (audio.paused) {
        audio.play();
    } else {
        audio.pause();
    }
}

function videotoggle() {
    var video = document.getElementById("video");
    if (video.paused) {
        video.play();
    } else {
        video.pause();
    }
}

let count = 0;
let thisCount = 0;

const handlers = {
    startInitFunctionOrder(data) {
        count = data.count;
    },

    initFunctionInvoking(data) {
        document.querySelector(".thingy").style.left = "0%";
        document.querySelector(".thingy").style.width = (data.idx / count) * 100 + "%";
    },

    startDataFileEntries(data) {
        count = data.count;
    },

    performMapLoadFunction(data) {
        ++thisCount;

        document.querySelector(".thingy").style.left = "0%";
        document.querySelector(".thingy").style.width = (thisCount / count) * 100 + "%";
    },
};

window.addEventListener("message", function (e) {
    (handlers[e.data.eventName] || function () {})(e.data);
});
