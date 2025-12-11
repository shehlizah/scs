<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1" name="viewport" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <meta name="language" content="en" />
    <meta name="google" content="notranslate" />
    <title>Smart Controlling School (SCS)</title>
    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="/template/plugins/bootstrap/css/bootstrap.min.css" />
    <!-- Font CSS -->
    <link rel="stylesheet" href="/template/dist/css/all_icons.css" />
    <!-- Loader CSS -->
    <link rel="stylesheet" href="/template/dist/css/loader.css" />
    <!-- Dropzone CSS -->
    <link rel="stylesheet" href="/template/plugins/dropzone/dropzone.css" />
    <!-- MetisMenu CSS -->
    <link rel="stylesheet" href="/template/plugins/metisMenu/metisMenu.min.css" />
    <!-- daterange picker -->
    <link rel="stylesheet" href="/template/plugins/daterangepicker/daterangepicker-bs3.css" />
    <!-- bootstrap datepicker -->
    <link rel="stylesheet" href="/template/plugins/datepicker/datepicker3.css" />
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="/template/plugins/iCheck/all.css" />
    <!-- Bootstrap Color Picker -->
    <link rel="stylesheet" href="/template/plugins/colorpicker/bootstrap-colorpicker.min.css" />
    <!-- Bootstrap time Picker -->
    <link rel="stylesheet" href="/template/plugins/timepicker/bootstrap-timepicker.min.css" />
    <!-- Select2 -->
    <link rel="stylesheet" href="/template/plugins/select2/select2.min.css" />
    <!--Data Tables-->
    <link rel="stylesheet" href="/template/plugins/datatables/dataTables.bootstrap4.min.css" />
    <!-- Summernot -->
    <link rel="stylesheet" href="/template/plugins/summernote/dist/summernote.css" />
    <!-- Summernot -->
    <link rel="stylesheet" href="/template/plugins/bootstrap-tokenfield/bootstrap-tokenfield.css" />
    <!-- easy auto complete -->
    <link rel="stylesheet" href="/template/plugins/jquery-easyautocomplete/easy-autocomplete.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/template/plugins/jquery-easyautocomplete/easy-autocomplete.themes.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/template/dist/nested/nested.css" />
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/template/dist/css/kavach.min.css" />
    <link rel="stylesheet" href="/template/dist/css/animate.css" />
    <link href="/template/dist/masonry/masonry-gallery.css" rel="stylesheet" />
    <!-- Change Color CSS -->
    <link rel="stylesheet" id="jssDefault" href="/template/dist/css/skin/default-skin.css" />
    <!--<link rel="stylesheet" id="jssDefault" href="/template/dist/css/overdark.css" />-->
    <!-- <link rel="stylesheet" id="jssDefault" href="/template/dist/css/overcolor.css" /> -->
    <link rel="shortcut icon" href="/memberdir/82/profil/hp3sb2rzqz9g3k5ygqqw.png?1695859911" type="image/x-icon" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
    <script src="/template/webdepan/js/g-tag.js"></script>
    <script src="https://code.iconify.design/1/1.0.6/iconify.min.js"></script>
    <script src="/template/plugins/ckeditor/ckeditor.js"></script>
  </head>
  <body>
    <div id="wrapper" class="">
      <div class="fakeLoader"></div>
      <!-- Navigation -->
      <nav class="navbar navbar-default navbar-static-top" style="margin-bottom: 0">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">
            <!-- <div class="img">
              <img src="/memberdir/82/profil/hp3sb2rzqz9g3k5ygqqw.png?1695859911" class="img-responsive" alt="Logo">
            </div> -->
            <div class="title">
              <small>Aplikasi</small> Smart Controlling School
            </div>
          </a>
        </div>
        <!-- /.navbar-header -->
        <ul class="nav navbar-top-links navbar-left header-search-form hidden-xs">
          <li>
            <a class="menu-brand" id="menu-toggle" href="javascript:;">
              <span class="ti-view-grid"></span>
            </a>
            <div class="smtnmheader">
              <label>Tahun Ajaran</label>
              <div style="display:inline-block;vertical-align: middle;">
                <form method="get">
                  <select name="smtid" id="smtid" class="form-control" onchange="this.form.submit()">
                    <option value="20222" selected>2022/2023 Semester Genap</option>
                    <option value="20221">2022/2023 Semester Ganjil</option>
                    <option value="20212">2021/2022 Semester Genap</option>
                    <option value="20202">2020/2021 Semester Genap</option>
                    <option value="20211">2021/2022 Semester Ganjil</option>
                    <option value="20201">2020/2021 Semester Ganjil</option>
                    <option value="20192">2019/2020 Semester Genap</option>
                    <option value="20191">2019/2020 Semester Ganjil</option>
                  </select>
                </form>
              </div>
            </div>
          </li>
        </ul>
        <ul class="nav navbar-top-links navbar-right">
          <li class="accountlogin">
            <a href="javascript:;" class="accinfolog">
              <img src="/memberdir/82/user.png">
              <span><?=$this->session->get('auth')->username?></span>
            </a>
            <ul class="accountdrop">
              <li>
                <a href="#">Profile</a>
              </li>
              <li>
                <a href="#">Ubah Password</a>
              </li>
              <li>
                <a href="/auth/logout">Logout</a>
              </li>
            </ul>
          </li>
          <li>
            <a class="notification-show" id="fullscreen" href="javascript:;">
              <i class="ti-fullscreen"></i>
            </a>
          </li>
        </ul>
        <!-- /.navbar-top-links -->
        <!-- Sidebar Navigation -->
        <div class="navbar-default sidebar" role="navigation">
          <div class="sidebar-nav navbar-collapse">
            {{ page.sidebar_menu_scs }}
          </div>
          <!-- /.sidebar-collapse -->
        </div>
      </nav>
      <!-- Sidebar Navigation -->
      <div id="page-wrapper">
      {% block content %}{% endblock %}
      </div>

      <footer class="footer"> &copy; 2023 Smart Controlling School</footer>
    </div>
    <!-- /#wrapper -->
    <style>
      #mydiv {
        position: fixed;
        width: 600px;
        height: 450px;
        z-index: 9;
        top: 100px;
        right: 10px;
        background-color: #f1f1f1;
        border: 1px solid #d3d3d3;
        display: none;
      }

      #mydivheader {
        padding: 10px;
        cursor: move;
        z-index: 10;
        background-color: #2196F3;
        color: #fff;
      }

      #closebutton,
      #copybutton {
        cursor: pointer;
        text-align: right;
        font-weight: bold;
        color: white;
      }
    </style>
    <!--<div id="mydiv"><div class="row" style="background-color: #2196F3;margin-right:0 !important;margin-left:0 !important;"><div id="mydivheader" class="col-sm-10">Click here to move</div><div id="copybutton" class="col-sm-1">Copy</div><div id="closebutton" class="col-sm-1">&times;</div></div><iframe id="contentframe" style="width: 100%;height: 400px;" src=""></iframe></div>-->
    <!-- CKEditor v.4-->
    <script src="/template/plugins/ckeditor/ckeditor.js"></script>
    <!-- jQuery -->
    <script src="/template/plugins/jquery/dist/jquery.min.js"></script>
    <script src="/template/plugins/jquery-lazyload/dist/jquery.lazy.min.js"></script>
    <script src="/template/dist/masonry/jquery.isotope.min.js"></script>
    <script src="/template/dist/masonry/masonry-gallery.js"></script>
    <!-- nested -->
    <script src="/template/dist/nested/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="/template/dist/nested/nested.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="/template/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Metis Menu Plugin JavaScript -->
    <script src="/template/plugins/metisMenu/metisMenu.min.js"></script>
    <script src="/template/plugins/slim-scroll/js/jquery.slimscroll.js"></script>
    <!-- Dropzone Js -->
    <script src="/template/plugins/dropzone/dropzone.js"></script>
    <script src="/template/dist/js/jQuery.style.switcher.js"></script>
    <!-- Select2 -->
    <script src="/template/plugins/select2/select2.full.min.js"></script>
    <!-- InputMask -->
    <script src="/template/plugins/input-mask/jquery.inputmask.js"></script>
    <script src="/template/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="/template/plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <!-- date-range-picker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
    <script src="/template/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap datepicker -->
    <script src="/template/plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="/template/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
    <!-- bootstrap time picker -->
    <script src="/template/plugins/timepicker/bootstrap-timepicker.min.js"></script>
    <!-- iCheck 1.0.1 -->
    <script src="/template/plugins/iCheck/icheck.min.js"></script>
    <!-- FastClick -->
    <script src="/template/plugins/fastclick/fastclick.js"></script>
    <!-- FLOT CHARTS -->
    <script src="/template/plugins/flot/jquery.flot.js"></script>
    <!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
    <script src="/template/plugins/flot/jquery.flot.resize.js"></script>
    <!-- FLOT PIE PLUGIN - also used to draw donut charts -->
    <script src="/template/plugins/flot/jquery.flot.pie.js"></script>
    <!-- FLOT CATEGORIES PLUGIN - Used to draw bar charts -->
    <script src="/template/plugins/flot/jquery.flot.categories.js"></script>
    <!-- ChartJS -->
    <script src="/template/plugins/chart.js/Chart.bundle.js"></script>
    <script src="/template/plugins/chart.js/Chart.js"></script>
    <!-- Advance Form Element -->
    <script src="/template/dist/js/custom/form-element.js"></script>
    <!-- Data Tables-->
    <script src="/template/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="/template/plugins/datatables/dataTables.bootstrap4.min.js"></script>
    <!-- easy auto complete -->
    <script src="/template/plugins/jquery-easyautocomplete/jquery.easy-autocomplete.min.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="/template/dist/js/kavach.min.js"></script>
    <!-- Custom Float JavaScript -->
    <script src="/template/dist/js/custom/dashboard/dashboard1.js"></script>
    <!-- Custom summesnote -->
    <script src="/template/plugins/summernote/dist/summernote.min.js"></script>
    <!-- Custom tokenfield -->
    <script src="/template/plugins/bootstrap-tokenfield/bootstrap-tokenfield.min.js"></script>
    <!-- Jquery Mentions Input-->
    <script src="https://cdn.rawgit.com/jashkenas/underscore/1.8.3/underscore-min.js" type="text/javascript"></script>
    <script src="/template/plugins/jquery-mentions-input-master/lib/jquery.events.input.js" type="text/javascript"></script>
    <script src="/template/plugins/jquery-mentions-input-master/lib/jquery.elastic.js" type="text/javascript"></script>
    <script src="/template/plugins/jquery-mentions-input-master/jquery.mentionsInput.js" type="text/javascript"></script>
    <script src="/template/dist/js/jquery-sortable.js"></script>
    <script>
      var $temp = $(" < input > ");
          $(document).ready(function() {
            var framecookie = getCookie('framecontent');
            var framecookieurl = getCookie('framecontenturl');

            function setCookie(cname, cvalue, exdays) {
              var d = new Date();
              d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
              var expires = "expires=" + d.toUTCString();
              document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
            }

            function getCookie(cname) {
              var name = cname + "=";
              var decodedCookie = decodeURIComponent(document.cookie);
              var ca = decodedCookie.split(';');
              for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') {
                  c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                  return c.substring(name.length, c.length);
                }
              }
              return "";
            }
            $('.jsContentOpener').on('click', function(event) {
              let url = $(this).data('url');
              window.open(url, 'newChildWindow', 'top=100,left=600,width=600,height=600,menubar=no,location=yes,resizable=yes,scrollbars=yes,status=no');
              /*$('#contentframe').attr('src', url);
              $('#mydiv').css('display', 'block');
              setCookie('framecontent', 'open', 1);
              setCookie('framecontenturl', url, 1);*/
            });
            $('#closebutton').on('click', function(event) {
              $('#mydiv').css('display', 'none');
              //setCookie('framecontent', 'close', 1);
              //setCookie('framecontenturl', '', 1);
            });
            $('#copybutton').on('click', function(event) {
              $("body").append($temp);
              var url = $('#contentframe').attr('src');
              $temp.val(url).select();
              document.execCommand("copy");
              $temp.remove();
              alert('Referensi telah di copy.');
            });
            // Make the DIV element draggable:
            //dragElement(document.getElementById("mydiv"));
            function dragElement(elmnt) {
              var pos1 = 0,
                pos2 = 0,
                pos3 = 0,
                pos4 = 0;
              if (document.getElementById(elmnt.id + "header")) {
                // if present, the header is where you move the DIV from:
                document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
              } else {
                // otherwise, move the DIV from anywhere inside the DIV:
                elmnt.onmousedown = dragMouseDown;
              }

              function dragMouseDown(e) {
                e = e || window.event;
                e.preventDefault();
                // get the mouse cursor position at startup:
                pos3 = e.clientX;
                pos4 = e.clientY;
                document.onmouseup = closeDragElement;
                // call a function whenever the cursor moves:
                document.onmousemove = elementDrag;
              }

              function elementDrag(e) {
                e = e || window.event;
                e.preventDefault();
                // calculate the new cursor position:
                pos1 = pos3 - e.clientX;
                pos2 = pos4 - e.clientY;
                pos3 = e.clientX;
                pos4 = e.clientY;
                // set the element's new position:
                elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
                elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
              }

              function closeDragElement() {
                // stop moving when mouse button is released:
                document.onmouseup = null;
                document.onmousemove = null;
              }
            }
          }); $('#tagstoken').tokenfield();
          //Date picker
          $('.datepickerfull').datepicker({
            autoclose: true
          }); 
          $(".modal").on('shown.bs.modal', function(e) {
            $('.datepickerfull1').datepicker();
          });
          $('table th input:checkbox').on('click', function() {
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox').each(function() {
              this.checked = that.checked;
              $(this).closest('tr').toggleClass('selected');
            });
          });

          function insertAtCaret(areaId, text) {
            var txtarea = document.getElementById(areaId);
            if (!txtarea) {
              return;
            }
            var scrollPos = txtarea.scrollTop;
            var strPos = 0;
            var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ? "ff" : (document.selection ? "ie" : false));
            if (br == "ie") {
              txtarea.focus();
              var range = document.selection.createRange();
              range.moveStart('character', -txtarea.value.length);
              strPos = range.text.length;
            } else if (br == "ff") {
              strPos = txtarea.selectionStart;
            }
            var front = (txtarea.value).substring(0, strPos);
            var back = (txtarea.value).substring(strPos, txtarea.value.length);
            txtarea.value = front + text + back;
            strPos = strPos + text.length;
            if (br == "ie") {
              txtarea.focus();
              var ieRange = document.selection.createRange();
              ieRange.moveStart('character', -txtarea.value.length);
              ieRange.moveStart('character', strPos);
              ieRange.moveEnd('character', 0);
              ieRange.select();
            } else if (br == "ff") {
              txtarea.selectionStart = strPos;
              txtarea.selectionEnd = strPos;
              txtarea.focus();
            }
            txtarea.scrollTop = scrollPos;
          }
          $(document).on("click", ".listtemplaporan li a", function() {
            valtext = $(this).html();
            insertAtCaret("textgettemp", valtext);
            //console.log(valtext);
          });

          function onlyNumbers(evt) {
            // Mendapatkan key code 
            var charCode = (evt.which) ? evt.which : event.keyCode;
            // Validasi hanya tombol angka
            if ((charCode > 13 || charCode < 13) && (charCode < 48 || charCode > 57)) return false;
            return true;
          }

          function pointNumbers(evt) {
            // Mendapatkan key code 
            var charCode = (evt.which) ? evt.which : event.keyCode;
            // Validasi hanya tombol angka
            if ((charCode > 13 || charCode < 13) && (charCode < 48 || charCode > 57) && charCode != 45) return false;
            return true;
          }

          function nilaiInput(evt) {
            // Mendapatkan key code 
            var charCode = (evt.which) ? evt.which : event.keyCode;
            // Validasi hanya tombol angka
            if ((charCode > 13 || charCode < 13) && (charCode < 48 || charCode > 57) && charCode != 46) return false;
            return true;
          }
    </script>
    <script>
      $('.dd-list').nestedSortable({
        tabSize: 20,
        disableNesting: 'no-nest',
        handle: 'div',
        items: 'li',
        toleranceElement: '> div',
        protectRoot: true
      });
      $("#hir").submit(function() {
        // Retrieve the HTML from the plugin
        var html = $('.dd-list').html();
        // Put this in the hidden field
        $('#val1').val(html);
        // alert(html);
        submit();
        return false;
      });

      function randomString(length) {
        var result = '';
        var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        for (var i = length; i > 0; --i) result += chars[Math.round(Math.random() * (chars.length - 1))];
        return result;
      }
      $('[data-toggle="tooltip"]').tooltip();
    </script>
    <script type="text/javascript">
      Dropzone.options.imgrecordupload = {
          init: function() {
            this.on("maxfilesexceeded", function(file) {
              this.removeFile(file);
            });
            this.on("success", function(file, response) {
                  file.serverId = response;
                  $("#saveformdrop").append(' < input type = "hidden" name = "foto[]" class = "imgdropzn" value = "'+file.serverId+'" / > ');}); 
                  this.on("removedfile", function(file) {
                  console.log(file);
                  namafilehapus = file.name;
                  if (file.serverId != "") {
                    namafilehapus = file.serverId;
                  }
                  $("#saveformdrop .imgdropzn").each(function() {
                    valinp = $(this).val();
                    if (valinp == namafilehapus) {
                      $(this).remove();
                    }
                  });
                  if (file.serverId != "") {
                    $.post("/siswaedit/tambah/hapus-foto/?filename=" + namafilehapus);
                  }
                });
              },
              maxFilesize: 2,
              acceptedFiles: ".jpeg,.jpg,.png,.gif",
              addRemoveLinks: true,
              accept: function(file, done) {
                if (file.name == "justinbieber.jpg") {
                  done("Naha, you don't.");
                } else {
                  done();
                }
              }
          };
          $("#savetext").click(function() {
            $(".summernotearea").each(function() {
              htmltext = $(this).find(".summernoteused + .note-editor .note-editing-area .note-editable").html();
              //$(this).find(".isisummernote").val(htmltext);
            });
            $(".formsummernote").submit();
          });
          if ($('.summernote').length) {
            $('.summernote').summernote({
              popover: {
                image: [
                  ['custom', ['imageAttributes']],
                  ['imagesize', ['imageSize100', 'imageSize50', 'imageSize25']],
                  ['float', ['floatLeft', 'floatRight', 'floatNone']],
                  ['remove', ['removeMedia']]
                ],
              },
              lang: 'en-US',
              imageAttributes: {
                imageDialogLayout: 'default', // default|horizontal
                icon: ' < i class = "note-icon-pencil" / > ',
                removeEmpty: false // true = remove attributes | false = leave empty if present
              },
              displayFields: {
                imageBasic: true, // show/hide Title, Source, Alt fields
                imageExtra: false, // show/hide Alt, Class, Style, Role fields
                linkBasic: true, // show/hide URL and Target fields for link
              },
              dialogsInBody: false,
              height: 500,
              airMode: $(this).data('airmode') ? $(this).data('airmode') : false,
              airPopover: [
                ["style", ["style"]],
                ['color', ['color']],
                ['font', ['bold', 'underline', 'clear']],
                ['para', ['ul', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']]
              ],
              toolbar: [
                ["style", ["style"]],
                ["style", ["bold", "italic", "underline", "clear"]],
                ["fontsize", ["fontsize"]],
                ["fontname", ["fontname"]],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ["color", ["color"]],
                ["para", ["ul", "ol", "paragraph"]],
                ["height", ["height"]],
                ["undo", ["undo"]],
                ["redo", ["redo"]],
                ['table', ['table']],
                ['insert', ['link', 'picture', 'hr']]
              ],
              fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '26', '28', '36', '48', '72'],
              callbacks: {
                onImageUpload: function(files) {
                  var data = new FormData();
                  data.append("image", files[0]);
                  $(".note-editor").before(" < div class = 'infostatussummer' > < i class = 'icon-spinner icon-spin orange bigger-125' > < /i> Uploading Image... < /div> < br / > ")
                  $.ajax({
                    data: data,
                    type: "POST",
                    url: "/ajax/uploadsummernote",
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function(url) {
                      $(".infostatussummer").remove();
                      //var image = IMAGE_PATH + url;
                      //$('.summernote').summernote('insertImage', image);
                      //console.log(url);
                      var imgNode = '';
                      $('.summernote').summernote('insertImage', url);
                    },
                    error: function(data) {
                      console.log(data);
                    }
                  });
                }
              }
            });
          }
    </script>
    <script type="text/javascript" src="/template/plugins/webcamjs-master/webcam.js"></script>
    <script language="JavaScript">
      Webcam.set({
        width: 465,
        height: 350,
        image_format: 'jpeg',
        jpeg_quality: 1000
      });
    </script>
    <script language="JavaScript">
      function setup() {
        Webcam.reset();
        Webcam.attach('#captmodal .my_camera');
      }

      function preview_snapshot() {
        // freeze camera so user can preview pic
        Webcam.snap(function(data_uri) {
          $(".captureimage").val(data_uri);
        });
        Webcam.freeze();
        // swap button sets
        document.getElementById('pre_take_buttons').style.display = 'none';
        document.getElementById('post_take_buttons').style.display = '';
      }

      function cancel_preview() {
        // cancel preview freeze and return to live camera feed
        Webcam.unfreeze();
        // swap buttons back
        document.getElementById('pre_take_buttons').style.display = '';
        document.getElementById('post_take_buttons').style.display = 'none';
      }

      function save_photo() {
        // actually snap photo (from preview freeze) and display it
        Webcam.snap(function(data_uri) {
          // display results in page
          document.getElementById('results').innerHTML = ' < h2 > Here is your image: < /h2>' + 
          ' < img src = "'+data_uri+'" / > ';
          // swap buttons back
          document.getElementById('pre_take_buttons').style.display = '';
          document.getElementById('post_take_buttons').style.display = 'none';
        });
      }
      $(".btncaptfoto").click(function() {
        setup();
        gmodal = $(this).attr("modal-id");
        nisnval = $(this).closest("form").find(".nisnsiswa").val();
        oldfotoval = $(this).closest("form").find(".oldfoto").val();
        $("#" + gmodal).modal("show");
        $("#" + gmodal).find(".nisnval").val(nisnval);
        $("#" + gmodal).find(".oldfotoval").val(oldfotoval);
      });
      var pwhrquery = " AND (a.nama like '%a%' or a.nisn like '%a%' or a.kartu like '%a%')";
      $.ajax({
        type: "POST",
        url: "/ajax/getinfonis",
        data: ({
          whrquery: pwhrquery
        }),
        success: function(data) {
          splginfonis = data.split("~~");
          $(".jaxinfonisn").removeClass("loaddt");
          $(".jaxinfonisn.hasnisn").html(splginfonis[0]);
          $(".jaxinfonisn.nothasnisn").html(splginfonis[1]);
        }
      });
      $(".bchangepass").click(function() {
        gnama = $(this).attr("data-nama");
        gemail = $(this).attr("data-email");
        gid = $(this).attr("data-id");
        gnis = $(this).attr("data-nis");
        gnisn = $(this).attr("data-nisn");
        gnewpassdt = randomString(5);
        $("#changepass").modal("show");
        $("#changepass").find(".emailval").val(gid);
        $("#changepass").find("#namachpass").html(gnama);
        $("#changepass").find("#nischpass").html(gnis);
        $("#changepass").find("#nisnchpass").html(gnisn);
        $("#changepass").find("#emailchpass").html(gemail);
        $("#changepass").find(".dnewpassword").val(gnewpassdt);
        $("#changepass").find("#pasnewdt").html(gnewpassdt);
      });
    </script>
    <script>
      $(".newcustomcb").click(function() {
        checkedlabel = $(this).find("input[type=checkbox]").prop("checked");
        $("#changepass form").removeAttr("target");
        if (checkedlabel == 1) {
          $("#changepass form").attr("target", "_blank");
        }
      });
      $(window).load(function() {
        $("#changepass form button[type=submit]").click(function() {
          cektarget = $("#changepass form").attr("target");
          if (cektarget == "_blank") {
            noitv = 0;
            console.log("sd");
            intstarget = setInterval(function() {
              if (noitv == 1) {
                location.href = "/siswaedit/?statuspesan=1&infostatus=edit&halaman=1&snamasiswa=a";
                clearInterval(intstarget);
              } else {
                noitv++;
              }
            }, 500);
          }
        });
      });
    </script>
    <script>
      $('body').on('click', '.check_pkl', function() {
        var idsiswa = $(this).data('id');
        var value = $('#check_pkl' + idsiswa);
        if (value.is(":checked")) {
          status = 1;
        } else {
          status = 0;
        }
        //send value to ajax
        $.ajax({
          type: "POST",
          url: "/siswaedit",
          data: ({
            idsiswa: idsiswa,
            status: status,
            update_pkl: 1
          }),
          success: function(data) {}
        });
      });
    </script>

<script>
<?php
if(Config::findFirstByKey('nvr_available')->value == 'yes' && strlen(Config::findFirstByKey('nvr_login_at')->value) > 0) {
    ?>
    function fetchdata(){
        $.ajax({
            url: '/api/heartbeat',
            type: 'post',
            success: function(data){
                // Perform operation on return value
                console.log(data);
                if(data.result != 'success') {
                    alert("NVR API SESSION IS EXPIRED");
                    window.location.href = "/auth/logout";
                }
            },
            complete:function(data){
                setTimeout(fetchdata,30000);
            }
        });
    }

    $(document).ready(function(){
        setTimeout(fetchdata,30000);
        console.log('call /api/heartbeat');
    });

    // function fetchdata_heartbeatsyncfacelog(){
    //     $.ajax({
    //         url: '/api/heartbeatcekabsen',
    //         type: 'post',
    //         success: function(data){
    //             // Perform operation on return value
    //             console.log(data);
    //         },
    //         complete:function(data){
    //             setTimeout(fetchdata_heartbeatsyncfacelog,10000);
    //         }
    //     });
    // }


    // $(document).ready(function(){
    //   setTimeout(fetchdata_heartbeatsyncfacelog,10000);
    //   console.log('call /api/heartbeatcekabsen');
    // }); 
    <?php
}
?>


/*
function fetchdata_heartbeatabsensi(){
    $.ajax({
        url: '/api/heartbeatabsensi',
        type: 'post',
        success: function(data){
            // Perform operation on return value
            console.log(data);
        },
        complete:function(data){
            setTimeout(fetchdata_heartbeatabsensi,10000);
        }
    });
}

$(document).ready(function(){
  setTimeout(fetchdata_heartbeatabsensi,10000);
  console.log('call /api/heartbeatsyncfacelog');
});
*/

/*
function fetchdata_heartbeatfacematch(){
    $.ajax({
        url: '/api/heartbeatfacematch',
        type: 'post',
        success: function(data){
            // Perform operation on return value
            console.log(data);
        },
        complete:function(data){
            setTimeout(fetchdata_heartbeatfacematch,8000);
        }
    });
}

$(document).ready(function(){
    setTimeout(fetchdata_heartbeatfacematch,8000);
    console.log('call /api/heartbeatfacematch');
});
*/
</script>

{{ partial(dispatcher.getControllerName()~"/"~dispatcher.getActionName()~"_js") }}

  </body>
</html>