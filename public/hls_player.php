<!DOCTYPE html>
<html>
<head>
    <title>HLS Video</title>
    <script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
</head>
<body>
    <video id="video" width=450 controls></video>
    <script>
        var video = document.getElementById('video');
        if (Hls.isSupported()) {
            var hls = new Hls();
            hls.loadSource('https://gateway.disdiksulsel.id/sman0demo/cctv_ai_1/output.m3u8');
            hls.attachMedia(video);
            hls.on(Hls.Events.MANIFEST_PARSED,function() {
                video.play();
            });
        } else if (video.canPlayType('application/vnd.apple.mpegurl')) {
            video.src = 'https://gateway.disdiksulsel.id/sman0demo/cctv_ai_1/output.m3u8';
            video.addEventListener('canplay',function() {
                video.play();
            });
        }
    </script>
</body>
</html>
