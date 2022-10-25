var cancelledTimer = null;
var IntervalIDz = null;
var TimeoutProcess = null;
$('document').ready(function() {
    MythicProgBar = {};

    MythicProgBar.Progress = function(data) {
        clearTimeout(cancelledTimer)
        // $('.progbar-in').css({"background": "linear-gradient(0deg, rgba(130,200,45,1) 0%, rgba(190,255,100,1) 100%"})
        $("#mina").show();
        var start = new Date();
        var maxTime = data.duration;
        var text = data.label;
        var img = data.img;
        var timeoutVal = Math.floor(maxTime/100);
        animateUpdate();

        // $('#pbar_innertext').text(text);
        if (!img) {
            // $('.img-progbar').html("<img src='../html/progbar-gif.gif' style='margin-top: -20px;' width='80px' class='img-progressbar'>");
        } else {
            $('.img-progbar').html(img);
        }

        function updateProgress(percentage) {
            $('#pbar_innerdiv').css("height", percentage + "%");
            $('.pbar_text').text( percentage + "%");
            $('.img-progbar').css('left', percentage + '%');
        }

        function animateUpdate() {
            var now = new Date();
            var timeDiff = now.getTime() - start.getTime();
            var perc = Math.round((timeDiff/maxTime)*100);
            if (perc <= 100) {
                updateProgress(perc);
                TimeoutProcess = setTimeout(animateUpdate, timeoutVal);
            } else {
                $("#mina").hide()
                $.post('http://mythic_progbar/actionFinish', JSON.stringify({}))
            }
        }
    };



    MythicProgBar.ProgressCancel = function() {
        // $("#pbar_innertext").text("CANCELLED");
        clearTimeout(TimeoutProcess)
        $('.progbar-in').css({"background": "#ff0000"})
        $("#pbar_innerdiv").css("width", '100%');
        $(".img-progbar").css("left", '100%');
        cancelledTimer = setTimeout(function () {
            $("#mina").css({"display":"none"});
            $.post('http://mythic_progbar/actionCancel', JSON.stringify({
                })
            );
        }, 1000);
    };

    MythicProgBar.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $(".character-box").attr("data-ischar", "false")
        $("#delete").css({"display":"none"});
    };
    
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'mythic_progress':
                MythicProgBar.Progress(event.data);
                break;
            case 'mythic_progress_cancel':
                MythicProgBar.ProgressCancel();
                break;
        }
    })
});