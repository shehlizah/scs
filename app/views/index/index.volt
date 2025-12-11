{% extends 'template/index.volt' %}


{% block content %}
<div class="page-content">
    <h2>Fingerprint </h2>
    <p>Sampel</p>

    <div class="row">
        <div class="panel col-md-8">
            <div class="form-group form-material">
                <button id="start-ektp" type="button" class="btn btn-primary">Scan E-KTP</button>
            </div>
            <div class="panel-body container-fluid">
                <div id="ektp-response"></div>
                <form autocomplete="off">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group form-material">
                                <label class="form-control-label">NIK</label>
                                <input type="text" class="form-control" name="nik" id="nik"/>
                            </div>
                            <div class="form-group form-material">
                                <label class="form-control-label">Nama</label>
                                <input type="text" class="form-control" name="nama" id="name"/>
                            </div>
                            <div class="form-group form-material">
                                <label class="form-control-label">Jenis Kelamin</label>
                                <input type="text" class="form-control" name="gender" id="gender"/>
                            </div>
                        </div>
                        <div class="col-md-6 text-right">
                            <img id="ektp-photo" class="rounded img-bordered img-bordered-green" width="130" height="150" ><br/>
                            <img id="ektp-finger" class="rounded img-bordered img-bordered-green" width="130" height="100" ><br/>
                            <img id="ektp-signature" class="rounded img-bordered img-bordered-green" width="130" height="100" ><br/>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="panel col-md-3 offset-1">
            <div class="form-group form-material">
                <button id="start-camera" type="button" class="btn btn-primary">Start Camera</button>
            </div>
            <div class="panel-body container-fluid">
                <div id="camera-response"></div>
                <img id="camera-photo" class="rounded img-bordered img-bordered-green" width="100%" height="300px">
            </div>

        </div>

        <div class="panel col-md-12">
            <div class="form-group form-material">
                <button id="start-fingerprint" type="button" class="btn btn-primary">Start Fingerprint</button>
            </div>
            <div class="panel-body container-fluid">
                <div id="fingerprint-response"></div>
                <div class="row justify-content-center">
                    <div class="offset-sm-0">
                        <div class="card">
                            <div class="card-block"><small>Ibu Jari Kiri</small></div>
                            <img id="finger-left-thumb" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                    <div class="offset-sm-1">
                        <div class="card">
                            <div class="card-block"><small>Jari Telunjuk Kiri</small></div>
                            <img id="finger-left-index" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                    <div class="offset-sm-1">
                        <div class="card">
                            <div class="card-block"><small>Jari Tengah Kiri</small></div>
                            <img id="finger-left-middle" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                    <div class="offset-sm-1">
                        <div class="card">
                            <div class="card-block"><small>Jari Manis Kiri</small></div>
                            <img id="finger-left-ring" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                    <div class="offset-sm-1">
                        <div class="card">
                            <div class="card-block"><small>Kelingking Kiri</small></div>
                            <img id="finger-left-litle" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="offset-sm-0">
                        <div class="card">
                            <div class="card-block"><small>Ibu Jari Kanan</small></div>
                            <img id="finger-right-thumb" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                    <div class="offset-sm-1">
                        <div class="card">
                            <div class="card-block"><small>Jari Telunjuk Kanan</small></div>
                            <img id="finger-right-index" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                    <div class="offset-sm-1">
                        <div class="card">
                            <div class="card-block"><small>Jari Tengah Kanan</small></div>
                            <img id="finger-right-middle" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                    <div class="offset-sm-1">
                        <div class="card">
                            <div class="card-block"><small>Jari Manis Kanan</small></div>
                            <img id="finger-right-ring" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                    <div class="offset-sm-1">
                        <div class="card">
                            <div class="card-block"><small>Kelingking Kanan</small></div>
                            <img id="finger-right-litle" class="rounded img-bordered img-bordered-green" width="130" height="150">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel col-md-3">
            <div class="form-group form-material">
                <button id="start-signature" type="button" class="btn btn-primary">Start Signature</button>
            </div>
            <div class="panel-body container-fluid">
                <div id="signature-response"></div>
                <img id="signature-photo" class="rounded img-bordered img-bordered-green" width="100%" height="200px">
            </div>
        </div>


    </div>
</div>
<script>
    if ($.connection) {
        var tryingToReconnect = false;

        $.connection.hub.url = "http://localhost:7777/signalr";
        $.connection.hub.logging = true;
        $.connection.hub.reconnecting(function() {
            tryingToReconnect = true;
        });

        $.connection.hub.reconnected(function() {
            tryingToReconnect = false;
        });

        $.connection.hub.disconnected(function() {
            if(tryingToReconnect) {
                /*Your function to notify user.*/
            }
        });

        $.connection.hub.connectionSlow(function() {
            /*Your function to notify user.*/
        });

        if ($.connection.ektpHub) {
            var hub = $.connection.ektpHub;
            hub.client.addNewMessageToPage = function (message) {
                $('#ektp-response').html(message);

                var obj = jQuery.parseJSON(message);
                $('#nik').val(obj.Id);
                $('#name').val(obj.Name);
                $('#gender').val(obj.Gender);
                $('#ektp-photo').attr('src',obj.FileUrlPhoto);
                $('#ektp-finger').attr('src',obj.FileUrlCaptureFinger);
                $('#ektp-signature').attr('src',obj.FileUrlSignature);
                playSoundNotif();
            };
        }

        if ($.connection.cameraHub) {
            var hub = $.connection.cameraHub;
            hub.client.addNewMessageToPage = function (message) {
                $('#camera-response').html(message);

                var obj = jQuery.parseJSON(message);
                $('#camera-photo').attr('src',obj.FileUrl);
                playSoundNotif();
            };
        }

        if ($.connection.fingerprintHub) {
            var hub = $.connection.fingerprintHub;
            hub.client.addNewMessageToPage = function (message) {
                $('#fingerprint-response').html(message);

                var obj = jQuery.parseJSON(message);
                $('#finger-left-thumb').attr('src',obj.FileUrlLeftThumb);
                $('#finger-left-index').attr('src',obj.FileUrlLeftIndex);
                $('#finger-left-middle').attr('src',obj.FileUrlLeftMiddle);
                $('#finger-left-ring').attr('src',obj.FileUrlLeftRing);
                $('#finger-left-litle').attr('src',obj.FileUrlLeftLittle);

                $('#finger-left-thumb').attr('src',obj.FileUrlLeftThumb);
                $('#finger-left-index').attr('src',obj.FileUrlLeftIndex);
                $('#finger-left-middle').attr('src',obj.FileUrlLeftMiddle);
                $('#finger-left-ring').attr('src',obj.FileUrlLeftRing);
                $('#finger-left-litle').attr('src',obj.FileUrlLeftLittle);
                playSoundNotif();
            };
        }

        if ($.connection.signatureHub) {
            var hub = $.connection.signatureHub;
            hub.client.addNewMessageToPage = function (message) {
                $('#signature-response').html(message);
                console.log(message);

                var obj = jQuery.parseJSON(message);
                $('#signature-photo').attr('src',obj.FileUrl);
                playSoundNotif();
            };
        }

    }

    $(document).on('click','#start-ektp', function(){
        if($.connection){
            if ($.connection.ektpHub) {
                var hub = $.connection.ektpHub;
                /*Start Connection*/
                $.connection.hub.start().done(function () {
                    hub.server.send().fail(function (e) {
                        console.log(e.message);
                    });
                }).fail(function (e) {
                    console.log(e.message);
                });


            }
        }
    });

    $(document).on('click','#start-fingerprint', function(){
       if($.connection){
           if ($.connection.fingerprintHub) {
               var hub = $.connection.fingerprintHub;
               /*Start Connection*/
               $.connection.hub.start().done(function () {
                   hub.server.send($('#nik').val()).fail(function (e) {
                       console.log(e.message);
                   });
               }).fail(function (e) {
                   console.log(e.message);
               });
           }
       }
    });

    $(document).on('click','#start-signature', function(){
        if($.connection){
            if ($.connection.signatureHub) {
                var hub = $.connection.signatureHub;
                /*Start Connection*/
                $.connection.hub.start().done(function () {
                    hub.server.send($('#nik').val()).fail(function (e) {
                        console.log(e.message);
                    });
                }).fail(function (e) {
                    console.log(e.message);
                });
            }
        }
    });

    $(document).on('click','#start-camera', function(){
        if($.connection){
            if ($.connection.cameraHub) {
                var hub = $.connection.cameraHub;
                /*Start Connection*/
                $.connection.hub.start().done(function () {
                    hub.server.send($('#nik').val()).fail(function (e) {
                        console.log(e.message);
                    });
                }).fail(function (e) {
                    console.log(e.message);
                });
            }
        }
    });

</script>
{% endblock %}