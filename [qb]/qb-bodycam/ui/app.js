//***edit this only for your information***
const player = "NAME";
const agency = "SAN ANDREAS STATE POLICE";
const callsign = "[XX-XXX]";
//***        end edit this only         ***

$(document).ready(function(){
    
    $(".top-right-container").hide();
    $(".top-left-container").hide();
    window.addEventListener("message", function(event){
        if(event.data.open == true)
        {
            init();
            $(".top-right-container").fadeIn();
            $("#player").html(event.data.daneosoby);
            $("#agency").html(event.data.ranga);
            $("#callsign").html(event.data.sign);
        }
        else if(event.data.open == false) 
        {
            $(".top-right-container").fadeOut();
            clearTimeout(animate)
        }
        else if(event.data.cam == true)
        {
            $(".top-left-container").fadeIn();
            $("#playerC").html(event.data.player);
            $("#agencyC").html(event.data.agency);
            $("#callsignC").html(event.data.sign);
        }
        else if(event.data.cam == false) 
        {
            $(".top-left-container").fadeOut();
        }
    })
});

var d,h,m,s,animate;
const monthNames = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"];

function init(){
    d=new Date();
    h=d.getHours();
    m=d.getMinutes();
    s=d.getSeconds();
    t=d.toLocaleString('en', {timeZoneName:'short'}).split(' ').pop();
    day=d.getDate();
    month=d.getMonth();
    year=d.getFullYear();
    clock();
};

function clock(){
    s++;
    if(s==60){
        s=0;
        m++;
        if(m==60){
            m=0;
            h++;
            if(h==24){
                h=0;
            }
        }
    }
    $("#sec").html(s);
    $("#min").html(m);
    $("#hr").html(h);
    $("#tz").html(t);
    $("#day").html(day);
    $("#year").html(year);
    $("#month").html(monthNames[month]);
    animate=setTimeout(clock,1000);
};

/*function $(id,val){
    if(val<10){
        val='0'+val;
    }
    document.getElementById(id).innerHTML=val;
};*/

//window.onload=init;